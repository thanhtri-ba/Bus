import type { ButtonHTMLAttributes, ReactNode } from 'react';
import { cn } from '@/shared/utils/cn';
type Variant = 'primary'|'secondary'|'ghost'|'danger';
export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> { variant?: Variant; loading?: boolean; icon?: ReactNode; }
export function Button({variant='primary',loading=false,icon,className,children,disabled,...props}:ButtonProps){return <button className={cn('btn',`btn--${variant}`,className)} disabled={disabled||loading} {...props}>{loading?<span className="spinner" aria-hidden="true"/>:icon}{children}</button>}
