export function AppPreferences() {
  const preferences = [
    {
      icon: 'language',
      title: 'Language',
      value: 'English (US)'
    },
    {
      icon: 'payments',
      title: 'Currency',
      value: 'USD ($)'
    },
    {
      icon: 'help_center',
      title: 'Support',
      value: '24/7 Priority Help'
    }
  ];

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
      {preferences.map((pref, index) => (
        <div key={index} className="bg-surface-container-low p-6 rounded-xl border border-outline-variant flex flex-col items-center text-center">
          <span className="material-symbols-outlined text-4xl text-primary mb-3">{pref.icon}</span>
          <h4 className="font-label-md text-label-md text-on-surface">{pref.title}</h4>
          <p className="font-body-sm text-body-sm text-on-surface-variant mt-1">{pref.value}</p>
        </div>
      ))}
    </div>
  );
}
