import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_new/data/models/login_model.dart';
import 'package:task_manager_new/data/models/network_response.dart';
import 'package:task_manager_new/data/network_caller/network_caller.dart';
import 'package:task_manager_new/data/utilities/urls.dart';
import 'package:task_manager_new/ui/controllers/auth_controller.dart';
import 'package:task_manager_new/ui/screens/auths/email_verification_screen.dart';
import 'package:task_manager_new/ui/screens/auths/sign_up_screen.dart';
import 'package:task_manager_new/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_new/ui/utility/app_colors.dart';
import 'package:task_manager_new/ui/utility/app_constants.dart';
import 'package:task_manager_new/ui/widgets/background_widgets.dart';
import 'package:task_manager_new/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _signInApiInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidgets(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your email address.';
                        }
                        if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: _showPassword == false,
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                _showPassword = !_showPassword;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              icon: Icon(_showPassword
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off))),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                        visible: _signInApiInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _onTapNextButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        )),
                    const SizedBox(
                      height: 36,
                    ),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: _onTapForgotPasswordButton,
                              child: const Text('Forgot password?')),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4,
                                  ),
                                  text: "Don't have an account? ",
                                  children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: const TextStyle(
                                    color: AppColors.themeColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton,
                                )
                              ])),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    _signInApiInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, body: requestData);
    _signInApiInProgress = false;
    if (mounted) {
      setState(() {});
      if (response.isSuccess) {
        LoginModel loginModel = LoginModel.fromJson(response.responseData);
        await AuthController.saveUserAccessToken(loginModel.token!);
        await AuthController.saveUserData(loginModel.userModel!);
        if(mounted){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainBottomNavScreen()));
        }
        
      } else {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Email or password is not correct. Try again.');
      }
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmailVerificationScreen()));
  }

  void _onTapSignUpButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
