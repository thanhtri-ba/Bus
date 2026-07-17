import * as React from 'react';
import { Box } from '@mui/material';
import PeopleIcon from '@mui/icons-material/People';
import ConfirmationNumberIcon from '@mui/icons-material/ConfirmationNumber';
import DirectionsBusIcon from '@mui/icons-material/DirectionsBus';
import BusinessIcon from '@mui/icons-material/Business';
import {
    useTranslate,
    DashboardMenuItem,
    MenuItemLink,
    MenuProps,
    useSidebarState,
} from 'react-admin';
import clsx from 'clsx';

const Menu = ({ dense = false }: MenuProps) => {
    const translate = useTranslate();
    const [open] = useSidebarState();

    return (
        <Box
            sx={{
                width: open ? 200 : 50,
                marginTop: 1,
                marginBottom: 1,
                transition: theme =>
                    theme.transitions.create('width', {
                        easing: theme.transitions.easing.sharp,
                        duration: theme.transitions.duration.leavingScreen,
                    }),
            }}
            className={clsx({
                'RaMenu-open': open,
                'RaMenu-closed': !open,
            })}
        >
            <DashboardMenuItem />
            
            <MenuItemLink
                to="/users"
                state={{ _scrollToTop: true }}
                primaryText="Users"
                leftIcon={<PeopleIcon />}
                dense={dense}
            />
            <MenuItemLink
                to="/bookings"
                state={{ _scrollToTop: true }}
                primaryText="Bookings"
                leftIcon={<ConfirmationNumberIcon />}
                dense={dense}
            />
            <MenuItemLink
                to="/trips"
                state={{ _scrollToTop: true }}
                primaryText="Trips"
                leftIcon={<DirectionsBusIcon />}
                dense={dense}
            />
            <MenuItemLink
                to="/busAgents"
                state={{ _scrollToTop: true }}
                primaryText="Bus Agents"
                leftIcon={<BusinessIcon />}
                dense={dense}
            />
        </Box>
    );
};

export default Menu;
