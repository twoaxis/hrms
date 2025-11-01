import 'package:flutter/material.dart';
import 'package:hrms/theme/color_scheme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.emailAddress,
    required this.textInputAction,
  });

  final String labelText;
  final String hintText;
  final bool isPasswordField;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormField();
}

class _CustomTextFormField extends State<CustomTextFormField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.labelText,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.disabled,
              textInputAction: widget.textInputAction,
              autofocus: true,
              obscureText: widget.isPasswordField && !isVisible ? true : false,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: widget.hintText,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.surfaceContainer),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.surfaceContainer),
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
                suffixIcon: widget.isPasswordField == true
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(
                          isVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
