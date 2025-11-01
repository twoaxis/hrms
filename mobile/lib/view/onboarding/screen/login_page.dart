import 'package:flutter/material.dart';
import 'package:hrms/theme/color_scheme.dart';
import 'package:hrms/util/auth_validator.dart';
import 'package:hrms/values/spaces.dart';
import 'package:hrms/view/onboarding/widget/custom_text_form_field.dart';
import 'package:hrms/view/onboarding/widget/exception_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailSubmitted = false;
  bool passwordSubmitted = false;
  String? errorException;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      emailSubmitted = true;
      passwordSubmitted = true;
      errorException = null;
    });
    if (!formKey.currentState!.validate()) return;
  }

  @override
  initState() {
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
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      (kToolbarHeight + fullscreenSpacing * 2),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 50),
                      Icon(
                        Icons.lock_outline,
                        size: 80,
                        color: colorScheme.onPrimary,
                      ),
                      const SizedBox(height: 20),
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
                        validator: (input) => AuthValidators.emailValidators(
                          input,
                          emailSubmitted,
                        ),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(fullscreenSpacing),
        child: ElevatedButton(
          onPressed: login,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Sign In',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
