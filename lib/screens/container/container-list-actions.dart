import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/models/container_item.dart';

class ContainerListActions extends StatelessWidget {
  ContainerItem entity;
  ContainerListProvider provider;
  final void Function(ContainerItem id)? onSelect;

  ContainerListActions({Key? key, required this.entity, required this.provider, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if ( entity.state == 'exited' || entity.state == 'running' ) Tooltip(
          message: 'Detalles del contenedor',
          child: IconButton(
            onPressed: provider.loadingRestart ? null: () {
              if (onSelect != null) {
                onSelect!(entity);
              }
            },
            icon: const Icon(FluentIcons.backlog_list),
          ),
        ),
        if ( entity.state == 'running' ) Tooltip(
          message: 'Reiniciar contenedor',
          child: IconButton(
            onPressed: provider.loadingRestart ? null: () {
              provider.restart( entity.id! );
            },
            icon: const Icon(FluentIcons.reset),
          ),
        ),
        if ( entity.state == 'running' ) Tooltip(
          message: 'Detener contenedor',
          child: IconButton(
            onPressed: provider.loadingStop ? null: () {
              confirm(context, '¿Está seguro de detener éste contenedor?').then((value) {
                if (value == true) {
                  provider.stop( entity.id! );
                }
              });
            },
            icon: const Icon(FluentIcons.stop),
          ),
        ),
        if ( entity.state == 'created' || entity.state == 'exited' ) Tooltip(
          message: 'Iniciar contenedor',
          child: IconButton(
            onPressed: provider.loadingStart ? null: () {
              provider.start( entity.id! );
            },
            icon: const Icon(FluentIcons.play),
          ),
        ),
        if ( entity.state == 'exited' || entity.state == 'created' ) Tooltip(
          message: 'Eliminar contenedor',
          child: IconButton(
            onPressed: provider.loadingKill ? null: () {
              confirm(context, '¿Está seguro de eliminar éste contenedor?').then((value) {
                if (value == true) {
                  provider.remove( entity.id! );
                }
              });
            },
            icon: const Icon(FluentIcons.delete),
          ),
        )
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
