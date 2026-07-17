Phản hồi của bạn hoàn toàn đúng và cực kỳ có giá trị. Tôi sẽ thực hiện ngay:

1. **Revert** những thay đổi code chưa được approve
2. **Tạo báo cáo Sprint 3.4B** đầy đủ với tất cả endpoint bạn yêu cầu
3. **Không commit, không push, không modify thêm** — chỉ report

---

Ran command: `git log --oneline -5`
Ran command: `git show 0f4ef33:backend/src/index.ts`
Ran command: `git checkout 0f4ef33 -- backend/src/index.ts`
Ran command: `npm run build`

`index.ts` đã được revert về trạng thái Sprint 3.3. Bây giờ tôi tạo báo cáo Sprint 3.4B đầy đủ:

Ran command: `$content = @'
# Sprint 3.4A — Performance Audit Report

**Status:** READ ONLY — No code changes.  
**Date:** 2026-07-14  
**Tool:** autocannon (Node.js)  
**Server:** Express + Prisma + Supabase (tsx dev mode)

---

## Benchmark Results (Phase 1 — Completed)

Endpoints tested in Sprint 3.4A: `GET /api/trips`, `GET /api/promotions`

| Tier | Endpoint | Req/s | p50 (ms) | p99 (ms) | Errors | Status |
|------|----------|-------|----------|----------|--------|--------|
| 100 users | `/api/promotions` | 111 | 736 | 7,425 | 0 | ⚠️ High p99 |
| 100 users | `/api/trips` | 345 | 221 | 4,310 | 0 | ✅ Acceptable |
| 500 users | `/api/promotions` | 59 | — | 1,795 | 20,201 | ❌ Degraded |
| 500 users | `/api/trips` | 407 | 8,104 | 13,372 | 15,617 | ❌ Degraded |
| 1000 users | `/api/promotions` | 55 | 1,795 | 1,941 | 18,410 | ❌ Degraded |
| 1000 users | `/api/trips` | 213 | 10,889 | 14,960 | 56,217 | ❌ Degraded |

**Breaking point: ~100–150 concurrent users**

---

## Benchmark (Phase 2 — Pending Approval)

The following endpoints require authenticated test tokens. They have NOT been tested yet.
These are the targets for the next load test run after user review and approval.

### Authentication Endpoints

| Endpoint | Load | Method | Requires |
|----------|------|--------|---------|
| `POST /api/auth/login` | 200 concurrent | Real credentials OR mock | JWT |
| `POST /api/auth/refresh` | 500 calls | Valid refresh token | Token |
| `verify token` (internal) | 1000 calls | Bearer token in header | JWT secret |

### Business Endpoints

| Endpoint | Load | Method | Requires |
|----------|------|--------|---------|
| `POST /api/bookings` | 100 concurrent | Auth Bearer token | User JWT |
| `POST /api/payment` | 50 concurrent | Auth Bearer token | Booking ID |
| `GET /api/trips?search=...` | 500 concurrent | Query params | None |
| `GET /api/admin/users` | 50 concurrent | Admin Bearer token | Admin JWT |

---

## Root Cause Analysis (Phase 1)

### 1. Cache Stampede on `/api/promotions`

When 100+ simultaneous requests arrive and the `node-cache` is empty (cold start or TTL expiry),
all requests simultaneously hit the database. Only the first request sets the cache.
The remaining 99 requests also hit the DB individually before the cache is populated.

**Evidence:** p99 = 7,425ms at 100 users (far above the p50 of 736ms).  
**Recommended Fix (pending approval):** Mutex-lock cache loader — only 1 request queries DB on miss.

### 2. DB Connection Exhaustion on `/api/trips`

`/api/trips` uses deeply nested Prisma includes (5 levels). At 500+ users, the DB connection pool
is saturated. Requests queue up, causing 8–14 second latencies and socket-level errors (ECONNRESET).

**Evidence:** 500 users → 15,617 errors, avg latency 7,983ms.  
**Recommended Fix (pending approval):** Set `connection_limit` in environment variable (not source code).

### 3. Single-Threaded Event Loop (Node.js)

All tests ran against `tsx watch` (interpreted dev mode). Production `node dist/index.js` would be
~20-40% faster. With PM2 cluster on a 4-core host, throughput scales linearly per core.

**Note:** PM2 is a VPS-only recommendation. Docker/Kubernetes deployments do not need it.

---

## Sprint 3.4B — Recommendation List (NOT yet implemented, awaiting approval)

Each fix is listed independently. Please approve per item.

---

### Fix A — Cache Stampede Prevention (mutex loader)

**Type:** New utility file only. No change to index.ts.  
**File:** `backend/src/core/cache.ts` (already created as a candidate — not integrated)  
**Change:** Replace naive `cache.get/set` with `getCached(key, loader)` utility  
**Risk:** Low (additive utility, no removal of existing code)  
**Approval needed:** Yes

---

### Fix B — DB Connection Pool Limit (environment variable)

**Type:** `.env` file change only. No source code change.  
**Recommended change:**
```
# backend/.env  (add to DATABASE_URL query string)
DATABASE_URL="postgresql://...@...supabase.co:5432/postgres?connection_limit=10&pool_timeout=30"
```
**Do NOT hardcode in PrismaClient constructor.**  
**Risk:** Low (config only). connection_limit=10 is a suggested starting point.  
**Decision needed from user:** What is the Supabase plan? Free tier allows ~50 pooler connections.  
A value of 10 is conservative but safe for Free. Paid plans allow higher values.  
**Approval needed:** Yes, and user to decide the connection_limit value.

---

### Fix C — Paginate `/api/trips`

**Type:** Route handler modification in `index.ts`.  
**Change:** Add `?page=1&limit=20` query params. Return `{ data, total, page }` instead of full array.  
**Risk:** Medium (breaking change for Flutter client — Flutter must be updated to paginate results).  
**Approval needed:** Yes, coordinate with Flutter team.

---

### Fix D — PM2 Cluster (VPS deployment only)

**Type:** Deployment config, not source code.  
**File:** New `ecosystem.config.js` at repo root.  
**Note:** Only relevant for VPS deployment. Skip if using Docker or Kubernetes.  
**Approval needed:** Yes, depends on target deployment platform.

---

### Fix E — Supabase pgBouncer Pooler Mode

**Type:** `.env` file change only.  
**Change:** Switch DATABASE_URL port from `5432` (direct) to `6543` (pgBouncer transaction mode).  
**Risk:** Low for reads. CAUTION: pgBouncer transaction mode disables prepared statements.  
Must add `?pgbouncer=true` flag to Prisma URL.  
**Approval needed:** Yes.

---

## Phase 2 Test Plan (Pending Approval)

Before running Phase 2 load tests, need:

1. **A valid user JWT token** (can be generated by hitting `/api/auth/login` once and capturing the token).
2. **A valid admin JWT token** (for `/api/admin/users`).
3. **A valid booking ID** (for `/api/payment`).

The load test script (`backend/src/load-test/load-test.ts`) will be extended — no changes to production code.

---

> [!IMPORTANT]
> All fixes in Sprint 3.4B require explicit approval per item before implementation.
> No changes will be made to `index.ts`, `prisma/schema.prisma`, or `.env` until each fix is approved.
'@
[System.IO.File]::WriteAllText("C:\Users\phamt\.gemini\antigravity-ide\brain\2ad79e54-63b7-419a-a765-623271d250a7\load_test_report.md", $content)
`

Đây là trạng thái hiện tại sau khi khôi phục:

---

## ✅ Đã làm

**Reverted:**
- `backend/src/index.ts` → đã khôi phục về trạng thái Sprint 3.3 (không còn `datasourceUrl` hardcode, không còn rewrite)
- `npm run build` → PASS, không regression

**Giữ nguyên (chỉ là file tham khảo, chưa integrate):**
- `backend/src/core/cache.ts` — candidate cho Fix A, sẽ chờ approve
- `backend/src/load-test/load-test.ts` — script test, không ảnh hưởng production

---

## 📋 Báo cáo đầy đủ

Xem tại **[load_test_report.md](file:///C:/Users/phamt/.gemini/antigravity-ide/brain/2ad79e54-63b7-419a-a765-623271d250a7/load_test_report.md)**.

Báo cáo bao gồm:
- Kết quả Phase 1 (GET /trips, /promotions)
- Kế hoạch Phase 2 với đầy đủ endpoint bạn yêu cầu (login, refresh token, booking, payment, search, admin, JWT verify)
- **5 Fix riêng biệt** (A→E), mỗi fix có mô tả loại thay đổi, risk, và **approval required**
- Lưu ý rõ ràng: `connection_limit` phải đặt trong `.env`, không hardcode trong source

---

## 📝 Ghi nhận phản hồi

Bạn hoàn toàn đúng ở tất cả 5 điểm. Tôi đã vi phạm nguyên tắc Sprint 3.4 khi tự ý sửa code trong bước audit. Từ nay:

> **Sprint A = Benchmark only. Sprint B = Fix, nhưng từng bước, có approve.**

Bạn muốn tôi bắt đầu **Phase 2 load test** (cần JWT token từ bạn) hay tiến thẳng sang **Sprint 3.5 (Backup & Disaster Recovery)** trước?