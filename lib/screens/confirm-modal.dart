import 'package:docker_client/theme.dart' show AppTheme;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, Placeholder, ContentDialog, TextStyle, Text, Row, MainAxisSize, Column, Expanded, Navigator, Button, FilledButton, showDialog;
import 'package:styled_widget/styled_widget.dart';

class ConfirmModal extends StatelessWidget {
  final String? title;
  final String message;
  const ConfirmModal({super.key, this.title, required this.message});

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
              Text(message)
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
        FilledButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }

  static Future<bool?> asDialog(BuildContext context, String? title, String message) {
    return showDialog<bool?>(
        context: context,
        builder: (ctx) => ConfirmModal(title: title, message: message)
    );
  }
}
