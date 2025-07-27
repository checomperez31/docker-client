import 'package:docker_client/theme.dart' show AppTheme;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, Placeholder, ContentDialog, TextStyle, Text, Row, MainAxisSize, Column, Expanded, Navigator, Button, FilledButton, showDialog;
import 'package:flutter/material.dart' show SelectableText;
import 'package:styled_widget/styled_widget.dart';

class MessageModal extends StatelessWidget {
  final String? title;
  final String message;
  const MessageModal({super.key, this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(title ?? 'Atención', style: TextStyle(fontSize: 20, color: AppTheme.accentTextColor)),
      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(message)
            ],
          ).expanded()
        ],
      ),
      actions: [
        Button(
          child: const Text('Aceptar'),
          onPressed: () {
            Navigator.pop(context, true);
            // Delete file here
          },
        ),
      ],
    );
  }

  static Future<bool?> asDialog(BuildContext context, String? title, String message) {
    return showDialog<bool?>(
        context: context,
        builder: (ctx) => MessageModal(title: title, message: message)
    );
  }
}
