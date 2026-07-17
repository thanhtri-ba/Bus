import type { HTMLAttributes } from 'react'; import { cn } from '@/shared/utils/cn';
export function Skeleton({className,...props}:HTMLAttributes<HTMLDivElement>){return <div className={cn('skeleton',className)} aria-hidden="true" {...props}/>}
