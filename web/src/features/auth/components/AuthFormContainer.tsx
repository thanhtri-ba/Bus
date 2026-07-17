import { useState } from 'react';
import { LoginForm } from './LoginForm';
import { SignupForm } from './SignupForm';
import { SocialLogin } from './SocialLogin';
import { Link } from 'react-router-dom';

export function AuthFormContainer() {
  const [authMode, setAuthMode] = useState<'login' | 'signup'>('login');

  const handleToggle = (mode: 'login' | 'signup') => {
    setAuthMode(mode);
  };

  return (
    <section className="w-full lg:w-1/2 flex flex-col justify-center items-center px-6 md:px-12 bg-surface-container-lowest overflow-y-auto">
      <div className="w-full max-w-md py-12">
        {/* Brand Header */}
        <div className="mb-10 flex flex-col items-center lg:items-start">
          <Link to="/" className="text-primary font-headline-md text-headline-md font-bold mb-2 hover:opacity-80 transition-opacity">
            Intercity Velocity
          </Link>
          <div id="auth-header-container">
            <h2 className="font-headline-lg text-headline-lg text-on-surface">
              {authMode === 'login' ? 'Chào mừng trở lại' : 'Tham gia cùng chúng tôi'}
            </h2>
            <p className="font-body-md text-body-md text-on-surface-variant">
              {authMode === 'login' 
                ? 'Vui lòng đăng nhập để quản lý các chuyến đi của bạn.' 
                : 'Đăng ký tài khoản để bắt đầu hành trình của bạn.'}
            </p>
          </div>
        </div>

        {/* Toggle */}
        <div className="flex bg-surface-container-high p-1 rounded-lg mb-8">
          <button 
            className={`flex-1 py-2 rounded-md font-label-md text-label-md transition-all ${
              authMode === 'login' 
                ? 'bg-surface-container-lowest text-primary shadow-sm' 
                : 'text-on-surface-variant hover:text-on-surface'
            }`} 
            onClick={() => handleToggle('login')}
          >
            Đăng nhập
          </button>
          <button 
            className={`flex-1 py-2 rounded-md font-label-md text-label-md transition-all ${
              authMode === 'signup' 
                ? 'bg-surface-container-lowest text-primary shadow-sm' 
                : 'text-on-surface-variant hover:text-on-surface'
            }`} 
            onClick={() => handleToggle('signup')}
          >
            Đăng ký
          </button>
        </div>

        {/* Forms */}
        <div className="relative">
          <LoginForm isVisible={authMode === 'login'} />
          <SignupForm isVisible={authMode === 'signup'} />
        </div>

        <SocialLogin />
      </div>
    </section>
  );
}
