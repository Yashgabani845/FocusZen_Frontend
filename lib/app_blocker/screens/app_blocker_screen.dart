import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/app_gradients.dart';
import 'package:focusappfrontend/theme/ui/glass_container.dart';
import 'package:focusappfrontend/app_blocker/services/app_blocker_service.dart';
import 'package:focusappfrontend/app_blocker/ui/blocked_app_card.dart';

class AppBlockerScreen extends StatefulWidget {
  const AppBlockerScreen({super.key});

  @override
  State<AppBlockerScreen> createState() => _AppBlockerScreenState();
}

class _AppBlockerScreenState extends State<AppBlockerScreen> {
  final _appBlockerService = AppBlockerService();
  List<AppUsageInfo> _appUsages = [];
  bool _isLoading = true;
  String? _error;
  
  // A map to store the 'blocked' state of apps by package name or app name
  final Map<String, bool> _blockedApps = {};

  // Fallback demo data if permissions fail or on unsupported platforms
  final List<Map<String, dynamic>> _demoApps = [
    {
      'name': 'Instagram',
      'icon': Icons.camera_alt,
      'color': Colors.pink,
      'time': '2h 15m',
      'id': 'com.instagram.android',
    },
    {
      'name': 'YouTube',
      'icon': Icons.play_arrow,
      'color': Colors.red,
      'time': '1h 45m',
      'id': 'com.google.android.youtube',
    },
    {
      'name': 'TikTok',
      'icon': Icons.music_note,
      'color': Colors.white,
      'time': '1h 10m',
      'id': 'com.zhiliaoapp.musically',
    },
    {
      'name': 'Twitter / X',
      'icon': Icons.close,
      'color': Colors.blue,
      'time': '45m',
      'id': 'com.twitter.android',
    },
    {
      'name': 'Facebook',
      'icon': Icons.facebook,
      'color': Colors.blueAccent,
      'time': '30m',
      'id': 'com.facebook.katana',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchAppUsage();
  }

  Future<void> _fetchAppUsage() async {
    try {
      List<AppUsageInfo> infoList = await _appBlockerService.fetchAppUsage();
      
      if (mounted) {
        setState(() {
          _appUsages = infoList;
          _isLoading = false;
        });
      }
    } catch (exception) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load app usage data. Displaying Demo Data.';
          _isLoading = false;
        });
      }
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    }
    return '${duration.inMinutes}m';
  }

  String _formatPackageName(String name) {
    // Attempt to make android package names slightly more readable
    final parts = name.split('.');
    if (parts.length > 1) {
      String appName = parts.last;
      if (appName.toLowerCase() == 'android') {
        appName = parts[parts.length - 2];
      }
      return appName.replaceFirst(appName[0], appName[0].toUpperCase());
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('App Blocker'),
        centerTitle: true,
        leading: const SizedBox.shrink(), // No back button needed if it's on the main nav
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (_error != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.orange.withOpacity(0.2),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.orange, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.focusPrimary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.security, color: AppColors.focusPrimary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Focus Mode Active',
                              style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Selected apps will be restricted',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Expanded(
                child: _isLoading 
                    ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.textSecondary)))
                    : _buildAppList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppList() {
    final bool useDemoData = _appUsages.isEmpty || _error != null;
    final int count = useDemoData ? _demoApps.length : _appUsages.length;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      itemCount: count,
      itemBuilder: (context, index) {
        String name;
        String timeString;
        String id;
        Widget icon;
        
        if (useDemoData) {
          final app = _demoApps[index];
          name = app['name'];
          timeString = app['time'];
          id = app['id'];
          icon = Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: app['color'].withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(app['icon'], color: app['color']),
          );
        } else {
          final info = _appUsages[index];
          id = info.packageName;
          name = _formatPackageName(info.packageName);
          timeString = _formatDuration(info.usage);
          icon = Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.surfaceDark,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.android, color: Colors.green),
          );
        }

        final isBlocked = _blockedApps[id] ?? false;

        return BlockedAppCard(
          id: id,
          name: name,
          timeString: timeString,
          icon: icon,
          isBlocked: isBlocked,
          onToggle: (value) {
            setState(() {
              _blockedApps[id] = value;
            });
          },
        );
      },
    );
  }
}
