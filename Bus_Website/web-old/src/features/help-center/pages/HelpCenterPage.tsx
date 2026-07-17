import { HelpHero } from '../components/HelpHero';
import { HelpCategories } from '../components/HelpCategories';
import { TopFAQs } from '../components/TopFAQs';
import { ContactSupport } from '../components/ContactSupport';

export function HelpCenterPage() {
  return (
    <main>
      <HelpHero />
      <HelpCategories />
      <TopFAQs />
      <ContactSupport />
    </main>
  );
}
