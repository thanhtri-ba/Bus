import { ProfileSidebar } from '../../../shared/components/ProfileSidebar';
import { NotificationsList } from '../components/NotificationsList';

export function NotificationsPage() {
  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 md:py-12">
      <div className="flex flex-col md:flex-row gap-8">
        <ProfileSidebar />
        <NotificationsList />
      </div>
    </main>
  );
}
