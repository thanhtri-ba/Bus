import { forwardRef, type InputHTMLAttributes } from 'react';
import { cn } from '@/shared/utils/cn';
export interface InputProps extends InputHTMLAttributes<HTMLInputElement>{label?:string;error?:string;hint?:string}
export const Input=forwardRef<HTMLInputElement,InputProps>(({label,error,hint,id,className,...props},ref)=>{const inputId=id??props.name;return <label className="field" htmlFor={inputId}><span className="field__label">{label}</span><input ref={ref} id={inputId} className={cn('input',error&&'input--error',className)} aria-invalid={Boolean(error)} aria-describedby={error?`${inputId}-error`:undefined} {...props}/>{error?<span id={`${inputId}-error`} className="field__error">{error}</span>:hint?<span className="field__hint">{hint}</span>:null}</label>});
Input.displayName='Input';
