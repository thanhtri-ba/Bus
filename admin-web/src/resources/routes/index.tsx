import {
    List,
    Datagrid,
    TextField,
    EditButton,
    Edit,
    SimpleForm,
    BooleanInput,
    BooleanField,
    NumberInput,
    TextInput,
    NumberField
} from 'react-admin';

export const RouteList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <TextField source="departureCityId" label="Từ" />
            <TextField source="arrivalCityId" label="Đến" />
            <BooleanField source="isPopular" label="Phổ biến?" />
            <NumberField source="basePrice" label="Giá từ" />
            <NumberField source="durationMins" label="Thời gian (phút)" />
            <EditButton />
        </Datagrid>
    </List>
);

export const RouteEdit = () => (
    <Edit>
        <SimpleForm>
            <TextField source="departureCityId" label="Từ" />
            <TextField source="arrivalCityId" label="Đến" />
            <BooleanInput source="isPopular" label="Hiển thị trên Trang chủ?" />
            <TextInput source="color" label="Mã màu thẻ (Hex)" />
            <NumberInput source="basePrice" label="Giá từ (VND)" />
            <NumberInput source="durationMins" label="Thời gian đi (phút)" />
        </SimpleForm>
    </Edit>
);
