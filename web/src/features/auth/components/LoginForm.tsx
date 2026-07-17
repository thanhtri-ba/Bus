import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../../../shared/api/apiClient';

export function LoginForm({ isVisible }: { isVisible: boolean }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const res: any = await api.post('/auth/login', { email, password });
      if (res.token) {
        localStorage.setItem('token', res.token);
        localStorage.setItem('user', JSON.stringify(res.user));
        // Force a page reload or trigger auth context update
        window.dispatchEvent(new Event('auth-change'));
        navigate('/');
      }
    } catch (err: any) {
      setError(err.message || 'Đăng nhập thất bại. Vui lòng thử lại.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <form 
      className={`space-y-6 form-transition ${isVisible ? 'opacity-100' : 'hidden opacity-0 translate-x-4'}`}
      id="login-form"
      onSubmit={handleSubmit}
    >
      <div className="space-y-4">
        {error && (
          <div className="p-3 bg-error-container text-on-error-container rounded-lg font-label-sm">
            {error}
          </div>
        )}
        <div>
          <label className="block font-label-md text-label-md text-on-surface mb-2" htmlFor="login-email">
            Email
          </label>
          <div className="relative">
            <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline">person</span>
            <input 
              className="w-full pl-10 pr-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
              id="login-email" 
              placeholder="user@example.com" 
              type="email" 
              required
              value={email}
              onChange={e => setEmail(e.target.value)}
            />
          </div>
        </div>
        <div>
          <div className="flex justify-between items-center mb-2">
            <label className="block font-label-md text-label-md text-on-surface" htmlFor="login-password">
              Mật khẩu
            </label>
            <a className="font-label-sm text-label-sm text-primary hover:underline transition-all" href="#">
              Quên mật khẩu?
            </a>
          </div>
          <div className="relative">
            <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline">lock</span>
            <input 
              className="w-full pl-10 pr-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
              id="login-password" 
              placeholder="••••••••" 
              type="password"
              required
              value={password}
              onChange={e => setPassword(e.target.value)}
            />
          </div>
        </div>
      </div>
      <div className="flex items-center">
        <input 
          className="w-4 h-4 text-primary border-outline-variant rounded focus:ring-primary" 
          id="remember" 
          type="checkbox" 
        />
        <label className="ml-2 font-body-sm text-body-sm text-on-surface-variant cursor-pointer" htmlFor="remember">
          Duy trì đăng nhập
        </label>
      </div>
      <button 
        className="w-full bg-secondary-container hover:bg-secondary text-white font-label-md text-label-md py-4 rounded-lg shadow-md transition-all active:scale-[0.98] focus:ring-4 focus:ring-secondary-fixed disabled:opacity-70 flex items-center justify-center" 
        type="submit"
        disabled={loading}
      >
        {loading ? <span className="material-symbols-outlined animate-spin mr-2">sync</span> : null}
        {loading ? 'Đang xử lý...' : 'Đăng nhập'}
      </button>
    </form>
  );
}
