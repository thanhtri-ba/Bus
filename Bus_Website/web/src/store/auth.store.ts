import { create } from 'zustand';
export type UserRole='CUSTOMER'|'OPERATOR'|'ADMIN';
export interface AuthUser{id:string;email:string;fullName:string;roles:UserRole[]}
interface AuthState{user:AuthUser|null;status:'idle'|'loading'|'authenticated'|'anonymous';setUser:(user:AuthUser)=>void;setAnonymous:()=>void;reset:()=>void}
export const useAuthStore=create<AuthState>(set=>({user:null,status:'idle',setUser:user=>set({user,status:'authenticated'}),setAnonymous:()=>set({user:null,status:'anonymous'}),reset:()=>set({user:null,status:'idle'})}));
