import {
    List,
    Datagrid,
    TextField,
    EditButton,
    Edit,
    SimpleForm,
    TextInput,
    BooleanInput,
    ImageField,
    BooleanField,
} from 'react-admin';

export const CityList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <TextField source="name" />
            <BooleanField source="isPopular" label="Phổ biến?" />
            <TextField source="subtitle" label="Tiêu đề phụ" />
            <ImageField source="image" label="Ảnh" sx={{ '& img': { maxWidth: 100, maxHeight: 100, objectFit: 'cover' } }} />
            <EditButton />
        </Datagrid>
    </List>
);

export const CityEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="name" disabled />
            <BooleanInput source="isPopular" label="Hiển thị trên Trang chủ?" />
            <TextInput source="subtitle" label="Tiêu đề phụ (VD: Thành phố ngàn hoa)" fullWidth />
            <TextInput source="image" label="URL Ảnh đại diện" fullWidth />
        </SimpleForm>
    </Edit>
);
