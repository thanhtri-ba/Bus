import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _locationGranted = false;
  bool _notificationGranted = false;
  bool _cameraGranted = false;

  void _finishPermissionFlow() {
    // Navigate to Login screen after setting up permissions
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Header
              Icon(
                Symbols.security_rounded,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Enable Permissions',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'To give you the best smart transit experience, BusZ needs a few access permissions.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              // Permissions List
              Expanded(
                child: ListView(
                  children: [
                    _buildPermissionTile(
                      icon: Symbols.location_on_rounded,
                      title: 'Location Services',
                      subtitle:
                          'Required to show nearby bus stations and calculate route directions.',
                      value: _locationGranted,
                      onChanged: (val) {
                        setState(() => _locationGranted = val);
                      },
                      theme: theme,
                    ),
                    const Divider(),
                    _buildPermissionTile(
                      icon: Symbols.notifications_active_rounded,
                      title: 'Real-time Notifications',
                      subtitle:
                          'Keep you updated on bus arrival times, delay alerts, and ticket purchases.',
                      value: _notificationGranted,
                      onChanged: (val) {
                        setState(() => _notificationGranted = val);
                      },
                      theme: theme,
                    ),
                    const Divider(),
                    _buildPermissionTile(
                      icon: Symbols.qr_code_scanner_rounded,
                      title: 'Camera Access',
                      subtitle:
                          'Used to scan QR codes on bus tickets and boarding gates.',
                      value: _cameraGranted,
                      onChanged: (val) {
                        setState(() => _cameraGranted = val);
                      },
                      theme: theme,
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Grant all option
                      setState(() {
                        _locationGranted = true;
                        _notificationGranted = true;
                        _cameraGranted = true;
                      });
                      Future.delayed(
                        const Duration(milliseconds: 500),
                        _finishPermissionFlow,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Enable All & Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _finishPermissionFlow,
                    child: Text(
                      'Maybe Later',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: theme.colorScheme.secondary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
