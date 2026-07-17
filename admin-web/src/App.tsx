import polyglotI18nProvider from 'ra-i18n-polyglot';
import {
    Admin,
    Resource,
    localStorageStore,
    useStore,
    StoreContextProvider,
} from 'react-admin';

import authProvider from './authProvider';
import dataProviderFactory from './dataProvider';
import englishMessages from './i18n/en';
import { Layout, Login } from './layout';
import { themes, ThemeName } from './themes/themes';

import { UserList, UserEdit } from './resources/users';
import { BookingList, BookingEdit } from './resources/bookings';
import { TripList, TripEdit } from './resources/trips';
import { BusAgentList, BusAgentEdit } from './resources/busAgents';
import { PromotionList, PromotionEdit, PromotionCreate } from './resources/promotions';
import { CityList, CityEdit } from './resources/cities';
import { RouteList, RouteEdit } from './resources/routes';

const i18nProvider = polyglotI18nProvider(
    locale => {
        if (locale === 'fr') {
            return import('./i18n/fr').then(messages => messages.default);
        }

        // Always fallback on english
        return englishMessages;
    },
    'en',
    [
        { locale: 'en', name: 'English' },
        { locale: 'fr', name: 'Français' },
    ]
);

const store = localStorageStore(undefined, 'ECommerce');

const App = () => {
    const [themeName] = useStore<ThemeName>('themeName', 'soft');
    const singleTheme = themes.find(theme => theme.name === themeName)?.single;
    const lightTheme = themes.find(theme => theme.name === themeName)?.light;
    const darkTheme = themes.find(theme => theme.name === themeName)?.dark;
    
    return (
        <Admin
            title="BusZ Admin"
            dataProvider={dataProviderFactory()}
            store={store}
            authProvider={authProvider}
            loginPage={Login}
            layout={Layout}
            i18nProvider={i18nProvider}
            disableTelemetry
            theme={singleTheme}
            lightTheme={lightTheme}
            darkTheme={darkTheme}
            defaultTheme="light"
            requireAuth
        >
            <Resource name="users" list={UserList} edit={UserEdit} />
            <Resource name="bookings" list={BookingList} edit={BookingEdit} />
            <Resource name="trips" list={TripList} edit={TripEdit} />
            <Resource name="busAgents" list={BusAgentList} edit={BusAgentEdit} />
            <Resource name="promotions" list={PromotionList} edit={PromotionEdit} create={PromotionCreate} />
            <Resource name="cities" list={CityList} edit={CityEdit} />
            <Resource name="routes" list={RouteList} edit={RouteEdit} />
        </Admin>
    );
};

const AppWrapper = () => (
    <StoreContextProvider value={store}>
        <App />
    </StoreContextProvider>
);

export default AppWrapper;
