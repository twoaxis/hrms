import 'package:flutter/material.dart';
import 'package:hrms/theme/color_scheme.dart';
import 'package:hrms/util/auth_validator.dart';
import 'package:hrms/view/common/primary_button.dart';

class BaseurlScreen extends StatefulWidget {
  const BaseurlScreen({super.key});

  @override
  State<BaseurlScreen> createState() => _BaseurlScreenState();
}

class _BaseurlScreenState extends State<BaseurlScreen> {
  final TextEditingController baseurlController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 28),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: colorScheme.onPrimary.withValues(alpha: 0.5),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter your server URL",
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: baseurlController,
                  validator: AuthValidators.baseUrlValidator,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.disabled,
                  autofocus: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "https://open.rocket.chat/",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.surfaceContainer,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.surfaceContainer,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    hintStyle: TextStyle(
                      color: Color(0xFFAAAAAA),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              PrimaryButton(text: "Connect", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
