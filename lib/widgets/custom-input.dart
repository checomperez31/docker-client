import 'package:docker_client/theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const CustomInput({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: AppTheme.buttonBgColor,
        child: Theme(
          data: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.buttonBorderColor)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.buttonBorderColor)
                ),
              )
          ),
          child: TextFormField(
            style: TextStyle(color: AppTheme.accentTextColor),
            cursorColor: AppTheme.accentTextColor,
            decoration: InputDecoration(
              fillColor: AppTheme.buttonBgColor,
              filled: true,
              hoverColor: AppTheme.buttonBgHoveredColor,
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
          ),
        )
    );
  }
}
