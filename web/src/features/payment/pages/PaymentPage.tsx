import { StepIndicator } from '../../../shared/components/StepIndicator';
import { OrderSummary } from '../components/OrderSummary';
import { PaymentMethodForm } from '../components/PaymentMethodForm';

export function PaymentPage() {
  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 md:py-12">
      <StepIndicator currentStep={3} />
      
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
        <OrderSummary />
        <PaymentMethodForm />
      </div>
    </main>
  );
}
