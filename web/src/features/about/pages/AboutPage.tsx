import { AboutHero } from '../components/AboutHero';
import { CompanyMilestones } from '../components/CompanyMilestones';
import { OurStory } from '../components/OurStory';
import { WhyChooseUs } from '../components/WhyChooseUs';
import { AboutCTA } from '../components/AboutCTA';

export function AboutPage() {
  return (
    <>
      <AboutHero />
      <CompanyMilestones />
      <OurStory />
      <WhyChooseUs />
      <AboutCTA />
    </>
  );
}
