import 'package:flutter/material.dart';
import 'dart:async';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/app_gradients.dart';
import 'package:focusappfrontend/focus_timer/ui/focus_primary_button.dart';
import 'package:focusappfrontend/focus_timer/ui/circular_focus_progress.dart';
import 'package:focusappfrontend/focus_timer/ui/flame_widget.dart';
import 'package:focusappfrontend/focus_timer/services/focus_service.dart';
import 'package:focusappfrontend/intro/services/auth_service.dart';
import 'package:focusappfrontend/focus_timer/screens/focus_success_screen.dart';

class FocusTimerScreen extends StatefulWidget {
  const FocusTimerScreen({super.key});

  @override
  State<FocusTimerScreen> createState() => _FocusTimerScreenState();
}

class _FocusTimerScreenState extends State<FocusTimerScreen> with WidgetsBindingObserver {
  static const int _initialTimerSeconds = 25 * 60; // 25 minutes
  int _remainingSeconds = _initialTimerSeconds;
  Timer? _timer;
  bool _isRunning = true;
  int _interruptions = 0;
  DateTime? _startTime;
  DateTime? _pausedTime;

  final _focusService = FocusService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTime = DateTime.now();
    _startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // App went to background or phone locked
      if (_isRunning) {
        _pausedTime = DateTime.now();
        _timer?.cancel();
      }
    } else if (state == AppLifecycleState.resumed) {
      // App came back to foreground
      if (_isRunning && _pausedTime != null) {
        final elapsedWhilePaused = DateTime.now().difference(_pausedTime!).inSeconds;
        setState(() {
          _remainingSeconds -= elapsedWhilePaused;
          if (_remainingSeconds < 0) {
            _remainingSeconds = 0;
          }
        });
        _pausedTime = null;
        
        if (_remainingSeconds > 0) {
          _startTimer();
        } else {
          _endSession();
        }
      }
    }
  }

  void _startTimer() {
    _timer?.cancel(); // ensure no duplicates
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _endSession();
      }
    });
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
        _interruptions++;
      });
    } else {
      _startTimer();
      setState(() {
        _isRunning = true;
      });
    }
  }

  Future<void> _endSession() async {
    _timer?.cancel();
    final endTime = DateTime.now();
    final durationSeconds = _initialTimerSeconds - _remainingSeconds;

    if (durationSeconds > 0) {
      if (mounted) {
        setState(() => _isRunning = false);
      }

      final userId = AuthService.currentUser?['id'];

      // Save to backend using service
      final result = await _focusService.saveFocusSession(
        userId: userId?.toString(),
        startTime: _startTime!.toIso8601String(),
        endTime: endTime.toIso8601String(),
        duration: durationSeconds,
        interruptions: _interruptions,
      );

      if (mounted) {
        if (result['success']) {
          // Navigate to Success Screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FocusSuccessScreen(
                durationSeconds: durationSeconds,
                interruptions: _interruptions,
              ),
            ),
          );
        } else {
          // Show error but still allow closing if data can't be saved
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to sync: ${result['error']}'),
              backgroundColor: Colors.redAccent,
            ),
          );
          Navigator.pop(context);
        }
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                CircularFocusProgress(
                  progress: _remainingSeconds / _initialTimerSeconds,
                  size: 320,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlameWidget(
                        glowColor: _isRunning ? AppColors.focusPrimary : Colors.grey,
                        size: 140,
                        animate: _isRunning,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'remaining',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
                
                Row(
                  children: [
                    Expanded(
                      child: FocusPrimaryButton(
                        text: _isRunning ? 'PAUSE' : 'RESUME',
                        isNeutral: true,
                        onPressed: _pauseTimer,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FocusPrimaryButton(
                        text: 'END',
                        isNeutral: false,
                        onPressed: _endSession,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
