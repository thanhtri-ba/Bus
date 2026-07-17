import { NavLink, Outlet } from 'react-router-dom';
export function AccountLayout(){return <div className="container account-layout"><aside className="account-nav"><h2>Tài khoản</h2><NavLink to="/account">Tổng quan</NavLink><NavLink to="/account/bookings">Đơn đặt vé</NavLink><NavLink to="/account/profile">Hồ sơ</NavLink></aside><section className="account-content"><Outlet/></section></div>}
