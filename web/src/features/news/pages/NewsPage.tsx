import { NewsHero } from '../components/NewsHero';
import { NewsFilter } from '../components/NewsFilter';
import { NewsGrid } from '../components/NewsGrid';
import { NewsletterForm } from '../components/NewsletterForm';

export function NewsPage() {
  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 space-y-12">
      <NewsHero />
      <NewsFilter />
      <NewsGrid />
      <NewsletterForm />
    </main>
  );
}
