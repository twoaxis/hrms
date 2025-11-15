import 'package:flutter/material.dart';
import 'package:hrms/core/locator.dart';
import 'package:hrms/theme/color_scheme.dart';
import 'package:hrms/util/auth_validator.dart';
import 'package:hrms/values/spaces.dart';
import 'package:hrms/view/common/primary_button.dart';
import 'package:hrms/view/onboarding/widget/custom_text_form_field.dart';
import 'package:hrms/view/onboarding/widget/exception_container.dart';
import 'package:hrms/view_model/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginViewModel = locator<LoginViewModel>();

  bool emailSubmitted = false;
  bool passwordSubmitted = false;
  String? errorException;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      emailSubmitted = true;
      passwordSubmitted = true;
      errorException = null;
    });

    if (!formKey.currentState!.validate()) return;

    setState(() => loginViewModel.isLoading = true);

    final response = await loginViewModel.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() {
      loginViewModel.isLoading = false;
      errorException = loginViewModel.errorMessage;
    });

    if (response != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful: ${response.accessToken}')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      if (emailSubmitted) {
        emailSubmitted = false;
        formKey.currentState?.validate();
      }
      if (errorException != null) {
        setState(() => errorException = null);
      }
    });

    passwordController.addListener(() {
      if (passwordSubmitted) {
        passwordSubmitted = false;
        formKey.currentState?.validate();
      }
      if (errorException != null) {
        setState(() => errorException = null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(fullscreenSpacing),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: colorScheme.onPrimary,
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.surfaceContainer,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'E-mail:',
                  hintText: 'John@gmail.com',
                  textInputAction: TextInputAction.next,
                  validator: (input) =>
                      AuthValidators.emailValidators(input, emailSubmitted),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  isPasswordField: true,
                  controller: passwordController,
                  labelText: 'Password:',
                  textInputAction: TextInputAction.done,
                  hintText: '•••••••••••',
                  validator: (input) => AuthValidators.passwordValidators(
                    input,
                    passwordSubmitted,
                  ),
                ),
                const SizedBox(height: 24),
                if (errorException != null)
                  ExceptionContainer(loginException: errorException!),
                const Spacer(),
                PrimaryButton(
                  text: loginViewModel.isLoading ? "Logging in..." : "Login",
                  onPressed: loginViewModel.isLoading ? null : login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
