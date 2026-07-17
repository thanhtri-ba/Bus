# Báo cáo Kiểm toán Kỹ thuật và Bảo mật - Dự án BusZ

## 1. Tổng quan (Overview)
Báo cáo này tập trung đánh giá chất lượng mã nguồn (defensive coding) và cấu hình bảo mật của dự án BusZ (gồm Flutter app và Node.js/Express backend).
Tất cả các lỗi biên dịch (`flutter analyze`, `flutter test`, `npm run build`, `prisma validate`) đều đã được xử lý xanh (Passed) ở bước trước, cho phép tập trung hoàn toàn vào việc phân tích luồng logic.

---

## 2. Các phát hiện (Findings)

### 2.1. Lưu trữ Token xác thực không an toàn (Insecure Local Token Storage)
*   **Severity:** High
*   **CWE:** CWE-312 (Cleartext Storage of Sensitive Information)
*   **File/Location:** `lib/shared/pref_helper.dart` (Dòng 18-35)
*   **Phân loại (Status):** Confirmed
*   **Bằng chứng (Evidence):** Các hàm `setAccessToken` và `setRefreshToken` đang sử dụng package `shared_preferences`. Trên Android/iOS, package này lưu trữ dữ liệu dưới dạng văn bản rõ (plain text) (XML trên Android, UserDefaults trên iOS) mà không có mã hóa, dễ bị đánh cắp nếu thiết bị bị root hoặc jailbreak.
*   **Cách khắc phục:** Chuyển sang sử dụng package `flutter_secure_storage` để lưu các khóa nhạy cảm này an toàn vào Android Keystore và iOS Keychain.

### 2.2. Thiếu Middleware xác thực cho Admin API (Missing Authentication Middleware)
*   **Severity:** Critical
*   **CWE:** CWE-306 (Missing Authentication for Critical Function)
*   **File/Location:** `backend/src/admin.routes.ts` (Dòng 114-118)
*   **Phân loại (Status):** Confirmed
*   **Bằng chứng (Evidence):** Toàn bộ các route CRUD (Users, Bookings, Trips, BusAgents, Promotions) dành cho admin được mount trực tiếp bằng `router.use()` mà không hề đi qua middleware kiểm tra xác thực (như verify JWT) hoặc phân quyền (Role = Admin). Bất kỳ ai biết endpoint đều có thể xem, tạo, sửa hoặc xóa dữ liệu hệ thống.
*   **Cách khắc phục:** Tạo và gắn thêm middleware kiểm tra JWT (AuthGuard) và middleware kiểm tra quyền Admin trước khi gọi các route này.

### 2.3. Thiếu kiểm tra quyền sở hữu (Missing Ownership Checks - IDOR)
*   **Severity:** High
*   **CWE:** CWE-639 (Authorization Bypass Through User-Controlled Key)
*   **File/Location:** `backend/src/modules/booking/booking.controller.ts` (Dòng 6) & `booking.service.ts`
*   **Phân loại (Status):** Confirmed
*   **Bằng chứng (Evidence):** API tạo đặt vé (`/api/bookings/create`) chấp nhận trường `userId` trực tiếp từ phía client (thông qua `z.string().uuid()`). Kẻ tấn công có thể dễ dàng thay đổi UUID này trong request body để đặt vé ẩn danh, đặt hộ, hoặc spam vé vào tài khoản của người dùng khác.
*   **Cách khắc phục:** Không nhận `userId` từ body request. Thay vào đó, backend phải tự lấy ID của người dùng từ token xác thực (ví dụ `req.user.id`).

### 2.4. Hardcode thông tin nhạy cảm trong mã nguồn (Secrets accidentally stored)
*   **Severity:** High
*   **CWE:** CWE-798 (Use of Hard-coded Credentials)
*   **File/Location:** `test_supabase.dart` (Dòng 1)
*   **Phân loại (Status):** Confirmed
*   **Bằng chứng (Evidence):** File chứa trực tiếp URL của dự án Supabase, `anonKey` thật của dự án (`eyJhbG...`), email thật/thử nghiệm và đặc biệt là mật khẩu `Password123` ở dạng rõ.
*   **Cách khắc phục:** Xóa file test này ra khỏi repository hoặc chuyển việc truyền key và thông tin đăng nhập qua biến môi trường (`.env` hoặc `dart-define`).

### 2.5. Cấu hình CORS quá dễ dãi (Overly permissive CORS)
*   **Severity:** Medium
*   **CWE:** CWE-942 (Permissive Cross-domain Policy with Untrusted Domains)
*   **File/Location:** `backend/src/index.ts` (Dòng 12-14)
*   **Phân loại (Status):** Confirmed
*   **Bằng chứng (Evidence):** Cấu hình `app.use(cors({ exposedHeaders: [...] }))` không quy định thuộc tính `origin`. Trong thư viện `cors` của Express, điều này tương đương với `origin: '*'` (cho phép mọi domain thực hiện cross-origin request). 
*   **Cách khắc phục:** Bổ sung cấu hình mảng `origin` chỉ cho phép các domain được tin tưởng (ví dụ: frontend web admin, localhost lúc dev).

### 2.6. Client thao túng giá (Client-controlled prices)
*   **Severity:** N/A
*   **CWE:** N/A
*   **File/Location:** `backend/src/modules/booking/booking.controller.ts` & `booking.service.ts`
*   **Phân loại (Status):** False positive
*   **Bằng chứng (Evidence):** Dù `createBookingSchema` cho phép client gửi lên `totalAmount`, đoạn code trong `BookingService` (Dòng 53-78) đã chủ động tự tính lại giá vé từ DB dựa trên `SeatClass` và ghi đè toàn bộ `totalAmount`. Do đó, hệ thống được an toàn trước lỗi client tự sửa giá.

---

*Báo cáo được tạo trong quá trình rà soát phòng thủ (Defensive Code Review). Code hoàn toàn chưa bị chỉnh sửa theo các phát hiện này trừ khi được người dùng phê duyệt sửa lỗi.*
