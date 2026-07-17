import { List, Datagrid, TextField, ReferenceField, Edit, SimpleForm, TextInput } from 'react-admin';

export const TripList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <ReferenceField source="busAgentId" reference="busAgents" />
            <TextField source="busClass" />
        </Datagrid>
    </List>
);

export const TripEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="id" disabled />
            <TextInput source="busClass" />
        </SimpleForm>
    </Edit>
);
