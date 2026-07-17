import { List, Datagrid, TextField, NumberField, Edit, SimpleForm, TextInput } from 'react-admin';

export const BusAgentList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <TextField source="name" />
            <NumberField source="rating" />
        </Datagrid>
    </List>
);

export const BusAgentEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="id" disabled />
            <TextInput source="name" />
        </SimpleForm>
    </Edit>
);
