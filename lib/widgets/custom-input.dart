import 'package:docker_client/theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;

  const CustomInput({super.key, this.onChanged, this.controller, this.onFieldSubmitted, this.keyboardType});

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
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
            style: TextStyle(color: AppTheme.accentTextColor),
            cursorColor: AppTheme.accentTextColor,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
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
