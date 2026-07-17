import { AuthVisual } from '../components/AuthVisual';
import { AuthFormContainer } from '../components/AuthFormContainer';

export function AuthPage() {
  return (
    <main className="flex h-screen w-full bg-surface text-on-surface overflow-hidden fixed top-0 left-0 z-50">
      <AuthVisual />
      <AuthFormContainer />
    </main>
  );
}
