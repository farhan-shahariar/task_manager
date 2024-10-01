
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/auths/sign_in_screen.dart';
import 'package:task_manager_new/ui/utility/app_colors.dart';
import 'package:task_manager_new/ui/widgets/background_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidgets(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text('Set Password',
                  style: Theme.of(context).textTheme.titleLarge,),
                  Text('Minimum length of password should be more than 6 letters and combination of number and letter.',
                    style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: _onTapConfirmButton, child: const Text('Confirm')),
                  const SizedBox(height: 36,),
                  _buildSignInSection()

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInSection() {
    return Center(
                  child: RichText(text: TextSpan(
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                    text: "Have an account? ",
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style: const TextStyle(
                          color: AppColors.themeColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
                      )
                    ]
                  )),
                );
  }
  void _onTapConfirmButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => false);
  }
  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => false);
  }
  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
