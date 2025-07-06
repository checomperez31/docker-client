import 'package:docker_client/theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CustomCard({super.key, required this.child, this.height, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(8.0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: AppTheme.cardBorderColor, width: 1),
        color: AppTheme.cardColor
      ),
      child: child,
    );
  }
}
