import 'package:docker_client/models/image-item.dart';
import 'package:docker_client/screens/image/image-list-provider.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ImageListActions extends StatelessWidget {
  final ImageItem entity;
  final ImageListProvider provider;

  const ImageListActions({Key? key, required this.entity, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if ( entity.containers == null || entity.containers! <= 0 ) Button(
            onPressed: provider.loadingDelete ? null: () {
              confirm(context, '¿Está seguro de eliminar ésta imagen?').then((value) {
                if (value == true) {
                  provider.remove( entity.id! );
                }
              });
            },
            child: const Icon(FluentIcons.delete)
        ),
      ],
    );
  }

  Future<bool?> confirm(BuildContext context, String message) async {
    final result = showDialog<bool?>(
        context: context,
        builder: (ctx) => ContentDialog(
          title: Text('Atención', style: TextStyle(fontSize: 20, color: AppTheme.accentTextColor)),
          content: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(message)
                    ],
                  )
              )
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
        )
    );
    return result;
  }
}
