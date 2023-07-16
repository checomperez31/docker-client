import 'package:docker_client/theme.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:styled_widget/styled_widget.dart';

class DateTimePicker extends StatelessWidget {
  final Function(DateTime?)? onChange;
  final TextEditingController _textEditingController = TextEditingController();
  final String format;
  final DateTime? initialValue;
  DateTimePicker({Key? key, this.onChange, this.format = 'yyyy-MM-dd HH:mm:ss', this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ( initialValue != null ) _textEditingController.text = FormatUtils.formatDate(initialValue!, format);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextBox(
            controller: _textEditingController,
            placeholder: format,
            placeholderStyle: const TextStyle(fontSize: 12),
            onChanged: (txt) {
              DateTime? dt = FormatUtils.dateFromServer(txt);
              if ( onChange != null ) onChange!( dt );
            },
          ).expanded(),
          FittedBox(
            child: Button(
              onPressed: () async {
                DateTime? dt = FormatUtils.dateFromServer( _textEditingController.text );
                dt = await showSelector(context, dt);
                if ( dt != null ) {
                  _textEditingController.text = FormatUtils.formatDate(dt, format);
                  if ( onChange != null ) onChange!( dt );
                }
              },
              child: const Icon(FluentIcons.calendar),
            ),
          )
        ],
      ),
    );
  }

  Future<DateTime?> showSelector(BuildContext context, DateTime? initialValue) {
    DateTime dateTime = initialValue ?? DateTime.now();
    return showDialog<DateTime?>(
        context: context,
        builder: (ctx) => ContentDialog(
          title: Text('Seleccionar Fecha y hora', style: TextStyle(fontSize: 19, color: AppTheme.accentTextColor)),
          content: SingleChildScrollView(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DatePicker(selected: dateTime, onChanged: (dt) => dateTime = dt),
                      const SizedBox(height: 10,),
                      TimePicker(selected: dateTime, onChanged: (dt) => dateTime = dt)
                    ]
                ).expanded()
              ],
            ),
          ),
          actions: [
            Button(
              child: const Text('Aceptar'),
              onPressed: () => Navigator.pop(ctx, dateTime),
            ),
            FilledButton(
              child: const Text('Cerrar'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        )
    );
  }
}
