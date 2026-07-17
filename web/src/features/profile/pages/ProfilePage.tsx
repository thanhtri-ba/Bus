import { ProfileSidebar } from '../components/ProfileSidebar';
import { PersonalInfo } from '../components/PersonalInfo';
import { FrequentTravelers } from '../components/FrequentTravelers';
import { AppPreferences } from '../components/AppPreferences';

export function ProfilePage() {
  return (
    <main className="flex-grow w-full max-w-container-max mx-auto px-4 md:px-gutter py-8 md:py-12">
      <div className="flex flex-col md:flex-row gap-8">
        <ProfileSidebar />
        <div className="flex-grow space-y-8">
          <PersonalInfo />
          <FrequentTravelers />
          <AppPreferences />
        </div>
      </div>
    </main>
  );
}
