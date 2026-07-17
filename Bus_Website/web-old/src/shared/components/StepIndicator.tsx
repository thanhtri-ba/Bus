interface StepIndicatorProps {
  currentStep?: 1 | 2 | 3;
}

export function StepIndicator({ currentStep = 2 }: StepIndicatorProps) {
  // Step 1: Search (Completed if currentStep > 1)
  const step1Classes = currentStep > 1 
    ? "bg-tertiary-container text-on-tertiary-container" 
    : (currentStep === 1 ? "bg-primary text-on-primary border-4 border-primary-fixed" : "border border-outline");
  const step1Text = currentStep > 1 ? "text-on-surface" : (currentStep === 1 ? "text-primary font-bold" : "text-outline");

  // Step 2: Seat & Details
  const step2Classes = currentStep > 2
    ? "bg-tertiary-container text-on-tertiary-container"
    : (currentStep === 2 ? "bg-primary text-on-primary border-4 border-primary-fixed" : "border border-outline text-outline");
  const step2Text = currentStep > 2 ? "text-on-surface" : (currentStep === 2 ? "text-primary font-bold" : "text-outline");

  // Step 3: Payment
  const step3Classes = currentStep === 3
    ? "bg-primary text-on-primary border-4 border-primary-fixed"
    : "border border-outline text-outline";
  const step3Text = currentStep === 3 ? "text-primary font-bold" : "text-outline";

  // Lines
  const line1Classes = currentStep > 1 ? "bg-tertiary-container" : "bg-outline-variant";
  const line2Classes = currentStep > 2 ? "bg-tertiary-container" : (currentStep === 2 ? "bg-primary" : "bg-outline-variant");

  return (
    <div className="flex items-center justify-center mb-12 max-w-2xl mx-auto">
      {/* Step 1 */}
      <div className="flex flex-col items-center flex-1">
        <div className={`w-10 h-10 rounded-full flex items-center justify-center mb-2 transition-colors ${step1Classes}`}>
          {currentStep > 1 ? <span className="material-symbols-outlined" style={{ fontVariationSettings: "'FILL' 1" }}>check</span> : <span>1</span>}
        </div>
        <span className={`font-label-md ${step1Text}`}>Search</span>
      </div>
      
      <div className={`h-0.5 flex-grow mb-8 mx-2 transition-colors ${line1Classes}`}></div>
      
      {/* Step 2 */}
      <div className="flex flex-col items-center flex-1">
        <div className={`w-10 h-10 rounded-full flex items-center justify-center mb-2 transition-colors ${step2Classes}`}>
          {currentStep > 2 ? <span className="material-symbols-outlined" style={{ fontVariationSettings: "'FILL' 1" }}>check</span> : <span>2</span>}
        </div>
        <span className={`font-label-md ${step2Text}`}>Seat & Details</span>
      </div>
      
      <div className={`h-0.5 flex-grow mb-8 mx-2 transition-colors ${line2Classes}`}></div>
      
      {/* Step 3 */}
      <div className="flex flex-col items-center flex-1">
        <div className={`w-10 h-10 rounded-full flex items-center justify-center mb-2 transition-colors ${step3Classes}`}>
          {currentStep === 3 ? <span className="material-symbols-outlined">payments</span> : <span>3</span>}
        </div>
        <span className={`font-label-md ${step3Text}`}>Payment</span>
      </div>
    </div>
  );
}
