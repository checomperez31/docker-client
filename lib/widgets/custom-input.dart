import 'package:docker_client/theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final String? hint;
  final String? initialValue;

  const CustomInput({super.key, this.onChanged, this.controller, this.onFieldSubmitted, this.keyboardType, this.hint, this.initialValue});

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
            initialValue: initialValue,
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
              hintStyle: TextStyle(color: AppTheme.disabledTextColor),
              floatingLabelStyle: TextStyle(color: AppTheme.disabledTextColor),
              hintText: hint,
              labelText: hint
            ),
            onChanged: onChanged,
          ),
        )
    );
  }
}
