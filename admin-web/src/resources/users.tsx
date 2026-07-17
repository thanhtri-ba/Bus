import { List, Datagrid, TextField, EmailField, DateField, Edit, SimpleForm, TextInput } from 'react-admin';

export const UserList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <TextField source="fullName" />
            <EmailField source="email" />
            <TextField source="phone" />
            <TextField source="gender" />
            <DateField source="createdAt" />
        </Datagrid>
    </List>
);

export const UserEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="id" disabled />
            <TextInput source="fullName" />
            <TextInput source="email" />
            <TextInput source="phone" />
        </SimpleForm>
    </Edit>
);
