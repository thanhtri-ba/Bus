import { List, Datagrid, TextField, DateField, NumberField, ReferenceField, Edit, SimpleForm, TextInput, NumberInput } from 'react-admin';

export const BookingList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <ReferenceField source="userId" reference="users" />
            <TextField source="status" />
            <NumberField source="totalAmount" />
            <DateField source="createdAt" />
        </Datagrid>
    </List>
);

export const BookingEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="id" disabled />
            <TextInput source="status" />
            <NumberInput source="totalAmount" />
        </SimpleForm>
    </Edit>
);
