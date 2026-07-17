import * as React from 'react';
import {
    List,
    Datagrid,
    TextField,
    EditButton,
    Edit,
    Create,
    SimpleForm,
    TextInput,
    NumberInput,
    DateInput,
    BooleanInput,
    ImageField
} from 'react-admin';

export const PromotionList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="code" />
            <TextField source="title" />
            <TextField source="discountPct" label="Discount %" />
            <ImageField source="logoPath" title="Logo" sx={{ '& img': { maxWidth: 50, maxHeight: 50, objectFit: 'contain' } }} />
            <TextField source="validUntil" />
            <TextField source="isActive" />
            <EditButton />
        </Datagrid>
    </List>
);

export const PromotionEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="code" required />
            <TextInput source="title" required />
            <TextInput source="subtitle" />
            <TextInput source="logoPath" label="Image URL (e.g. from Imgur)" />
            <ImageField source="logoPath" title="Preview" sx={{ '& img': { maxWidth: 200, maxHeight: 200, objectFit: 'contain' } }} />
            <NumberInput source="discountPct" label="Discount Percentage (e.g. 10 for 10%)" required />
            <NumberInput source="maxDiscount" label="Max Discount Amount (VND)" />
            <DateInput source="validUntil" required />
            <BooleanInput source="isActive" defaultValue={true} />
        </SimpleForm>
    </Edit>
);

export const PromotionCreate = () => (
    <Create>
        <SimpleForm>
            <TextInput source="code" required />
            <TextInput source="title" required />
            <TextInput source="subtitle" />
            <TextInput source="logoPath" label="Image URL (e.g. from Imgur)" />
            <NumberInput source="discountPct" label="Discount Percentage (e.g. 10 for 10%)" required />
            <NumberInput source="maxDiscount" label="Max Discount Amount (VND)" />
            <DateInput source="validUntil" required />
            <BooleanInput source="isActive" defaultValue={true} />
        </SimpleForm>
    </Create>
);
