import 'package:docker_client/theme.dart' show AppTheme;
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomTextRow extends StatelessWidget {
  final String? text;
  final IconData? icon;
  const CustomTextRow({super.key, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      color: AppTheme.buttonBgColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(icon, size: 16, color: AppTheme.blue),
          SizedBox(width: 6),
          Text(text ?? '', style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16), overflow: TextOverflow.visible).expanded()
        ],
      ),
    );
  }
}
