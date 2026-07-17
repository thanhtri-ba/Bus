# MobSF Security Report - BusZ APK

**App Name:** busz
**Security Score:** None/100
**Trackers:** {'detected_trackers': 0, 'total_trackers': 432, 'trackers': []}

## Manifest Analysis (High/Warning)
- **[HIGH]** App can be installed on a vulnerable unpatched Android version 7.0, [minSdk=24]: This application can be installed on an older version of android that has multiple unfixed vulnerabilities. These devices won't receive reasonable security updates from Google. Support an Android version => 10, API 29 to receive reasonable security updates.
- **[WARNING]** Broadcast Receiver (androidx.profileinstaller.ProfileInstallReceiver) is Protected by a permission, but the protection level of the permission should be checked. <strong>Permission: </strong>android.permission.DUMP [android:exported=true]: A Broadcast Receiver is found to be shared with other apps on the device therefore leaving it accessible to any other application on the device. It is protected by a permission which is not defined in the analysed application. As a result, the protection level of the permission should be checked where it is defined. If it is set to normal or dangerous, a malicious application can request and obtain the permission and interact with the component. If it is set to signature, only applications signed with the same certificate can obtain the permission.

## Network Security

## Code Analysis
- **[WARNING]** The App uses an insecure Random Number Generator.
- **[WARNING]** App uses SQLite Database and execute raw SQL query. Untrusted user input in raw SQL queries can cause SQL Injection. Also sensitive information should be encrypted and written to the database.
