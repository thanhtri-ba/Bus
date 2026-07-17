export interface ApiResponse<T>{data:T;message?:string;meta?:Record<string,unknown>}
export interface ApiErrorPayload{message:string;code?:string;details?:Record<string,unknown>;status:number}
