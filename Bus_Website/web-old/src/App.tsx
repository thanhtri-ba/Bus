import './index.css'
import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom'
import { Header } from './shared/components/Header'
import { Footer } from './shared/components/Footer'
import { HomePage } from './features/home/pages/HomePage'
import { TripSearchPage } from './features/trip-search/pages/TripSearchPage'

import { SeatSelectionPage } from './features/seat-selection/pages/SeatSelectionPage'
import { PaymentPage } from './features/payment/pages/PaymentPage'
import { BookingConfirmationPage } from './features/booking-confirmation/pages/BookingConfirmationPage'
import { TripReviewPage } from './features/trip-review/pages/TripReviewPage'
import { AuthPage } from './features/auth/pages/AuthPage'
import { OffersPage } from './features/offers/pages/OffersPage'
import { NotificationsPage } from './features/notifications/pages/NotificationsPage'
import { NewsPage } from './features/news/pages/NewsPage'
import { AboutPage } from './features/about/pages/AboutPage'
import { PartnersPage } from './features/partners/pages/PartnersPage'
import { PartnerDetailsPage } from './features/partners/pages/PartnerDetailsPage'
import { MyBookingsPage } from './features/my-bookings/pages/MyBookingsPage'
import { HelpCenterPage } from './features/help-center/pages/HelpCenterPage'
import { ProfilePage } from './features/profile/pages/ProfilePage'

function Layout({ children }: { children: React.ReactNode }) {
  const location = useLocation()
  const isAuthPage = location.pathname === '/auth'

  return (
    <>
      {!isAuthPage && <Header />}
      {children}
      {!isAuthPage && <Footer />}
    </>
  )
}

function App() {
  return (
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/search" element={<TripSearchPage />} />
          <Route path="/seat-selection" element={<SeatSelectionPage />} />
          <Route path="/payment" element={<PaymentPage />} />
          <Route path="/booking-confirmation" element={<BookingConfirmationPage />} />
          <Route path="/trip-review" element={<TripReviewPage />} />
          <Route path="/auth" element={<AuthPage />} />
          <Route path="/offers" element={<OffersPage />} />
          <Route path="/notifications" element={<NotificationsPage />} />
          <Route path="/news" element={<NewsPage />} />
          <Route path="/about" element={<AboutPage />} />
          <Route path="/partners" element={<PartnersPage />} />
          <Route path="/partners/:id" element={<PartnerDetailsPage />} />
          <Route path="/my-bookings" element={<MyBookingsPage />} />
          <Route path="/help" element={<HelpCenterPage />} />
          <Route path="/profile" element={<ProfilePage />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  )
}

export default App
