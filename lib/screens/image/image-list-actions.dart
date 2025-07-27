import 'package:docker_client/models/image-item.dart';
import 'package:docker_client/screens/confirm-modal.dart';
import 'package:docker_client/screens/image/image-list-provider.dart';
import 'package:docker_client/screens/message-modal.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-button.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:styled_widget/styled_widget.dart';

class ImageListActions extends StatelessWidget {
  final ImageItem entity;
  final ImageListProvider provider;

  const ImageListActions({super.key, required this.entity, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if ( entity.containers == null || entity.containers! <= 0 ) CustomButton(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 9),
          size: 30,
          onPressed: provider.loadingDelete ? null: () {
            ConfirmModal.asDialog(context, 'Eliminar imagen', '¿Está seguro de eliminar ésta imagen?').then((value) {
              if (value == true) {
                provider.remove( entity.id! )
                    .then((message) => MessageModal.asDialog(context, 'Correcto', message))
                    .catchError((onError) => MessageModal.asDialog(context, 'Correcto', onError.toString()));
              }
            });
          },
          child: const Icon(FluentIcons.delete, size: 12)
        ),
      ],
    ).padding(vertical: 3);
  }
}
