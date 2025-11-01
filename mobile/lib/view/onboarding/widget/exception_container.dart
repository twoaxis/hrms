import 'package:flutter/material.dart';
import 'package:hrms/theme/color_scheme.dart';

class ExceptionContainer extends StatelessWidget {
  const ExceptionContainer({
    super.key,
    required this.loginException,
    this.color,
  });

  final String loginException;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          loginException,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color ?? colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
