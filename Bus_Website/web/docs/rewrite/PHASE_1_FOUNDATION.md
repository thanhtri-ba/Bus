# BusZ Web Rewrite — Phase 1 Foundation

## Mục tiêu
Dựng lại frontend BusZ từ đầu theo feature-based architecture và giữ `web-old` chỉ để tham khảo UI/assets.

## Thành phần đã tạo
- Application providers: Router, TanStack Query, Error Boundary, Toaster, React Query Devtools.
- Router tách riêng với Main/Auth/Booking/Account layouts.
- Route guards: ProtectedRoute, GuestRoute, RoleRoute.
- Axios API client dùng environment URL, timeout, cookie credentials, chuẩn hóa error và chặn refresh loop.
- Zustand foundation stores: auth, booking, UI.
- Design tokens và component nền tảng: Button, Input, Card, Badge, Spinner, Skeleton.
- Shared states: EmptyState, ErrorState.
- Responsive Header, navigation, Footer.
- Placeholder routes cho Home, Search, Offers, Help, Auth, Booking và Account.
- Trang 403 và 404.

## Dependencies chính
React 19, TypeScript, Vite, React Router, TanStack Query, Zustand, Axios, React Hook Form, Zod, date-fns, Lucide, Sonner, Vitest, Testing Library và Playwright.

## Quality scripts
- `npm run typecheck`
- `npm run lint`
- `npm run test`
- `npm run build`

## Chưa thực hiện
- Authentication API thật.
- Search API và bộ lọc chuyến.
- Seat reservation và countdown.
- Booking, voucher, payment webhook và electronic ticket.
- E2E business flows.

## Bước tiếp theo
Phase 2 — Authentication: session bootstrap, login/register/OTP, forgot/reset password, protected profile và auth tests.

## Kết quả xác minh
- TypeScript strict: PASS
- Oxlint: PASS
- Unit tests: 2/2 PASS
- Production build: PASS
- Bundle chính: khoảng 373 kB trước gzip, khoảng 117 kB sau gzip
