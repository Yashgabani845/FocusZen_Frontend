import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focusappfrontend/intro/services/auth_service.dart';
import 'package:focusappfrontend/intro/ui/auth_text_field.dart';
import 'package:focusappfrontend/theme/services/theme_provider.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/focus_timer/screens/focus_home_screen.dart';
import 'package:focusappfrontend/intro/ui/animated_focus_pet.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  final _authService = AuthService();
  
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitAuth() async {
    setState(() => _isLoading = true);

    final isLoginMode = _isLogin;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || (!isLoginMode && username.isEmpty)) {
      _showError('Please fill all fields');
      setState(() => _isLoading = false);
      return;
    }

    try {
      final result = isLoginMode 
          ? await _authService.login(email, password)
          : await _authService.signUp(email, username, password);

      if (!mounted) return;

      if (result['success']) {
        // Success. In a real app we'd save the token/user_id to SharedPreferences here.
        // For now, we just navigate to the home screen.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FocusHomeScreen()),
        );
      } else {
        _showError(result['error']);
      }
    } catch (e) {
      if (!mounted) return;
      _showError('Network error. Is the server running?');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  void _continueAsGuest() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FocusHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Provider.of<ThemeProvider>(context).primaryColor;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Illustration (Text Logo Replacement)
              Center(
                child: Column(
                  children: [
                    const Text(
                      'FocusZen',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Interactive Pet Actor
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.05),
                            ),
                          ),
                          AnimatedFocusPet(pageIndex: _isLogin ? 0 : 1),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Pet Greeting Dialogue
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: primaryColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        _isLoading 
                          ? "Checking your focus records..." 
                          : _isLogin 
                            ? "Welcome back! Ready to focus?" 
                            : "New here? I'll help you focus!",
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Forms
              if (!_isLogin) ...[
                AuthTextField(
                  controller: _usernameController,
                  hint: 'Username',
                  icon: Icons.person_outline,
                  primaryColor: primaryColor,
                ),
                const SizedBox(height: 16),
              ],
              AuthTextField(
                controller: _emailController,
                hint: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 32),

              // Action Buttons
              _isLoading
                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor)))
                  : ElevatedButton(
                      onPressed: _submitAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _isLogin ? 'Login' : 'Sign Up',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
              
              const SizedBox(height: 16),

              // Toggle Mode
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? "Don't have an account? " : "Already have an account? ",
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                        // clear fields on toggle
                        _emailController.clear();
                        _passwordController.clear();
                        _usernameController.clear();
                      });
                    },
                    child: Text(
                      _isLogin ? 'Sign Up' : 'Login',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 48),

              // Guest Option
              OutlinedButton(
                onPressed: _continueAsGuest,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Continue as Guest',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your focus data will be saved locally if you skip login.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
