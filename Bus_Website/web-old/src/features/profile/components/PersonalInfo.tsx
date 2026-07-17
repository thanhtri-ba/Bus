import { useState, useEffect } from 'react';
import { api } from '../../../shared/api/apiClient';

export function PersonalInfo() {
  const [isEditing, setIsEditing] = useState(false);
  const [profile, setProfile] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  const [formData, setFormData] = useState({
    fullName: '',
    phone: '',
    email: ''
  });

  useEffect(() => {
    api.get<any>('/auth/profile')
      .then(res => {
        if (res.success) {
          setProfile(res.data);
          setFormData({
            fullName: res.data.fullName || '',
            phone: res.data.phone || '',
            email: res.data.email || ''
          });
        }
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!isEditing) return;
    
    setSaving(true);
    try {
      const res = await api.put<any>('/auth/profile', {
        fullName: formData.fullName,
        phone: formData.phone
      });
      if (res.success) {
        setProfile(res.data);
        setIsEditing(false);
      }
    } catch (error) {
      console.error(error);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <section className="bg-surface-container-lowest rounded-xl border border-outline-variant shadow-[0px_4px_12px_rgba(0,0,0,0.05)] overflow-hidden p-6 text-center">
        Loading profile...
      </section>
    );
  }

  return (
    <section className="bg-surface-container-lowest rounded-xl border border-outline-variant shadow-[0px_4px_12px_rgba(0,0,0,0.05)] overflow-hidden">
      <div className="px-6 py-5 border-b border-outline-variant flex justify-between items-center">
        <h3 className="font-headline-md text-headline-md text-on-surface">Personal Information</h3>
        {!isEditing ? (
          <button 
            type="button"
            onClick={() => setIsEditing(true)} 
            className="text-primary font-label-md text-label-md hover:underline"
          >
            Edit Info
          </button>
        ) : (
          <button 
            type="button"
            onClick={() => {
              setIsEditing(false);
              setFormData({
                fullName: profile?.fullName || '',
                phone: profile?.phone || '',
                email: profile?.email || ''
              });
            }} 
            className="text-error font-label-md text-label-md hover:underline"
          >
            Cancel
          </button>
        )}
      </div>
      <div className="p-6">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-6" onSubmit={handleSave}>
          <div className="space-y-1.5">
            <label className="font-label-md text-label-md text-on-surface-variant">Full Name</label>
            <input 
              className={`w-full bg-surface-container-low border-outline-variant rounded-lg px-4 py-2.5 font-body-md text-body-md text-on-surface focus:ring-primary focus:border-primary ${!isEditing ? 'cursor-not-allowed opacity-80' : ''}`} 
              readOnly={!isEditing} 
              type="text" 
              name="fullName"
              value={formData.fullName}
              onChange={handleChange}
            />
          </div>
          <div className="space-y-1.5">
            <label className="font-label-md text-label-md text-on-surface-variant">Email Address</label>
            <input 
              className="w-full bg-surface-container-low border-outline-variant rounded-lg px-4 py-2.5 font-body-md text-body-md text-on-surface cursor-not-allowed opacity-80" 
              readOnly 
              type="email" 
              name="email"
              value={formData.email}
              title="Email cannot be changed"
            />
          </div>
          <div className="space-y-1.5">
            <label className="font-label-md text-label-md text-on-surface-variant">Phone Number</label>
            <div className="flex space-x-2">
              <div className="w-16 bg-surface-container-low border border-outline-variant rounded-lg px-3 py-2.5 text-center font-body-md text-on-surface">+84</div>
              <input 
                className={`flex-grow bg-surface-container-low border-outline-variant rounded-lg px-4 py-2.5 font-body-md text-body-md text-on-surface focus:ring-primary focus:border-primary ${!isEditing ? 'cursor-not-allowed opacity-80' : ''}`} 
                readOnly={!isEditing}
                type="tel" 
                name="phone"
                value={formData.phone}
                onChange={handleChange}
              />
            </div>
          </div>
          
          {isEditing && (
            <div className="md:col-span-2 flex justify-end mt-4">
              <button 
                type="submit" 
                disabled={saving}
                className="bg-primary text-on-primary px-6 py-2 rounded-lg font-label-md hover:opacity-90 disabled:opacity-50 flex items-center gap-2"
              >
                {saving && <span className="material-symbols-outlined animate-spin text-sm">sync</span>}
                {saving ? 'Saving...' : 'Save Changes'}
              </button>
            </div>
          )}
        </form>
      </div>
    </section>
  );
}
