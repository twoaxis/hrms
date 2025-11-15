import 'package:flutter/material.dart';
import 'package:hrms/theme/color_scheme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? colorScheme.onPrimary
              : colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: enabled ? onPressed : null,
        child: Text(
          text,
          style: TextStyle(
            color: enabled ? colorScheme.surface : colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
