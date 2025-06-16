import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:styled_widget/styled_widget.dart';

class DirectionForm extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode fn = FocusNode();
  DirectionForm({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    fn.requestFocus();
    return Form(
      child: ContentDialog(
        title: Text('Agregar direccion', style: TextStyle(fontSize: 19, color: AppTheme.accentTextColor)),
        content: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextBox(
                  controller: controller,
                  focusNode: fn,
                  style: TextStyle(color: AppTheme.accentTextColor),
                  cursorColor: AppTheme.accentTextColor,
                  decoration: WidgetStatePropertyAll(BoxDecoration(
                      color: AppTheme.buttonBgColor
                  )),
                  onSubmitted: (text) => validateForm(context, controller.text),
                )
              ],
            ).expanded()
          ],
        ),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () => validateForm(context, controller.text),
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, null),
          ),
        ],
      )
    );
  }

  validateForm(BuildContext context, String? txt) {
    if ( txt != null && txt.isNotEmpty ) {
      Navigator.pop(context, txt);
    } else {
      displayInfoBar(context, builder: (ctx, close) {
        return const InfoBar(
          title: Text('Debe insertar la direccion del servidor'),
          isIconVisible: false,
          severity: InfoBarSeverity.info,
        );
      }).then((value) => fn.requestFocus());
    }
  }

  static Future<String?> asDialog(BuildContext context) {
    return showDialog<String?>(
        context: context,
        builder: (ctx) => DirectionForm()
    );
  }
}
