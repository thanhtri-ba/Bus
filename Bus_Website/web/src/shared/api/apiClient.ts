import axios,{AxiosError,type AxiosRequestConfig} from 'axios';
import { env } from '@/config/env';
import type { ApiErrorPayload } from '@/shared/types/api';
let refreshPromise:Promise<void>|null=null;
export class ApiClientError extends Error { constructor(public readonly payload:ApiErrorPayload){super(payload.message);this.name='ApiClientError'} }
export const apiClient=axios.create({baseURL:env.apiBaseUrl,timeout:15000,withCredentials:true,headers:{'Content-Type':'application/json'}});
async function refreshSession():Promise<void>{await axios.post(`${env.apiBaseUrl}/auth/refresh`,undefined,{withCredentials:true,timeout:10000});}
apiClient.interceptors.response.use(r=>r,async(error:AxiosError<{message?:string;code?:string;details?:Record<string,unknown>}>)=>{const original=error.config as (AxiosRequestConfig&{_retry?:boolean})|undefined; if(error.response?.status===401&&original&&!original._retry&&!original.url?.includes('/auth/refresh')){original._retry=true;try{refreshPromise??=refreshSession().finally(()=>{refreshPromise=null});await refreshPromise;return apiClient.request(original);}catch{window.dispatchEvent(new CustomEvent('auth:expired'));}}
const payload:ApiErrorPayload={message:error.response?.data?.message??(error.code==='ECONNABORTED'?'Yêu cầu đã hết thời gian chờ.':'Không thể kết nối máy chủ.'),code:error.response?.data?.code,details:error.response?.data?.details,status:error.response?.status??0};return Promise.reject(new ApiClientError(payload));});
