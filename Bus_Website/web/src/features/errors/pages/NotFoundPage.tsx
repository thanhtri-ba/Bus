import { Link } from 'react-router-dom'; import { Button } from '@/design-system/components/Button';
export function NotFoundPage(){return <main className="page-center"><span className="error-code">404</span><h1>Không tìm thấy trang</h1><p>Đường dẫn bạn mở không tồn tại hoặc đã được thay đổi.</p><Link to="/"><Button>Về trang chủ</Button></Link></main>}
