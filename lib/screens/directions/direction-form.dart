import 'package:docker_client/models/address.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:styled_widget/styled_widget.dart';

class DirectionForm extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FocusNode fn = FocusNode();
  final Address address;
  DirectionForm({super.key, required this.address}) ;

  @override
  Widget build(BuildContext context) {
    fn.requestFocus();
    if ( address.ip != null ) ipController.text = address.ip!;
    if ( address.name != null ) nameController.text = address.name!;
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
                  controller: nameController,
                  focusNode: fn,
                  style: TextStyle(color: AppTheme.accentTextColor),
                  cursorColor: AppTheme.accentTextColor,
                  decoration: WidgetStatePropertyAll(BoxDecoration(
                      color: AppTheme.buttonBgColor
                  )),
                  placeholder: 'Nombre',
                  placeholderStyle: TextStyle(color: Colors.white),
                  onChanged: (text) => address.name = text,
                  onSubmitted: (text) => validateForm(context),
                ),
                TextBox(
                  controller: ipController,
                  style: TextStyle(color: AppTheme.accentTextColor),
                  cursorColor: AppTheme.accentTextColor,
                  decoration: WidgetStatePropertyAll(BoxDecoration(
                      color: AppTheme.buttonBgColor
                  )),
                  placeholder: 'IP',
                  placeholderStyle: TextStyle(color: Colors.white),
                  onChanged: (text) => address.ip = text,
                  onSubmitted: (text) => validateForm(context),
                )
              ],
            ).expanded()
          ],
        ),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () => validateForm(context),
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, null),
          ),
        ],
      )
    );
  }

  validateForm(BuildContext context) {
    if ( address.name != null && address.name!.isNotEmpty && address.ip != null && address.ip!.isNotEmpty ) {
      Navigator.pop(context, address);
    } else {
      displayInfoBar(context, builder: (ctx, close) {
        return InfoBar(
          title: address.ip == null ? Text('Debe insertar la direccion del servidor'): Text('Debe insertar el nombre del servidor'),
          isIconVisible: false,
          severity: InfoBarSeverity.info,
        );
      }).then((value) => fn.requestFocus());
    }
  }

  static Future<Address?> asDialog(BuildContext context, Address? address) {
    return showDialog<Address?>(
        context: context,
        builder: (ctx) => DirectionForm(address: address ?? Address(),)
    );
  }
}
