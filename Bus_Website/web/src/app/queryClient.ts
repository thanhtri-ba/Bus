import { QueryClient } from '@tanstack/react-query';
export const queryClient=new QueryClient({defaultOptions:{queries:{staleTime:30_000,retry:(count,error)=>{const status='payload' in Object(error)?(error as {payload?:{status?:number}}).payload?.status:undefined;return status===401||status===403?false:count<2},refetchOnWindowFocus:false},mutations:{retry:false}}});
