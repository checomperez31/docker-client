import 'package:docker_client/models/container-create.dart';
import 'package:docker_client/models/container.dart';
import 'package:docker_client/models/port.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/models/container_item.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerListActions extends StatelessWidget {
  ContainerItem entity;
  ContainerListProvider provider;
  final void Function(ContainerItem id)? onSelect;

  ContainerListActions({super.key, required this.entity, required this.provider, this.onSelect});

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
        if ( entity.state == 'exited' || entity.state == 'running' ) Tooltip(
          message: 'Clonar contenedor',
          child: IconButton(
            onPressed: provider.loadingRestart ? null: () {
              clone(context).then((value) async {
                if ( value != null ) {
                  var response = await provider.create(value);
                  if ( response != null ) {
                    starting(context, provider.start( response['Id'] ));
                  }
                }
              });
            },
            icon: const Icon(FluentIcons.copy),
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

  Future<bool?> starting(BuildContext context, Future<dynamic> backgroundProcess) async {
    backgroundProcess.then((value) {
      Navigator.pop(context, value);
    }).
    onError((error, stackTrace)  {
      Navigator.pop(context);
    }).catchError((error, stackTrace)  {
      Navigator.pop(context);
    });
    showDialog<bool?>(
        context: context,
        dismissWithEsc: false,
        builder: (ctx) => ContentDialog(
          title: Text('Arrancando contenedor', style: TextStyle(fontSize: 20, color: AppTheme.accentTextColor), textAlign: TextAlign.center),
          content: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: ProgressRing(
                          backgroundColor: AppTheme.buttonBgColor,
                          strokeWidth: 8,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }

  Future<DockerCreate?> clone(BuildContext context) async {
    DockerContainer? entityDet = await provider.details(entity.id!);
    if ( entityDet == null ) return null;
    DockerCreate createEntity = DockerCreate();
    createEntity.name = entityDet.name;
    createEntity.image = entityDet.config!.image;
    createEntity.imageId = entityDet.image;
    createEntity.extraHosts = entityDet.hostConfig!.extraHosts ?? [];
    List<Port> ports = entityDet.hostConfig!.portBindings ?? [];

    final result = showDialog<DockerCreate?>(
        context: context,
        builder: (ctx) {
          return ContentDialog(
            title: Text('Clonar', style: TextStyle(fontSize: 20, color: AppTheme.accentTextColor)),
            content: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInput(
                          hint: 'Nombre',
                          initialValue: createEntity.name,
                          onChanged: (val) => createEntity.name = val,
                        ),
                        SizedBox(height: 4),
                        CustomInput(
                          hint: 'Image',
                          initialValue: entityDet.config!.image,
                        ),
                        SizedBox(height: 4),
                        Text('Puertos'),
                        SizedBox(height: 4),
                        ...ports.map((port) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ( port.mappings != null ) Column(
                                children: port.mappings!.map((mapping) => CustomInput(
                                  hint: 'Expuesto',
                                  initialValue: mapping.hostPort,
                                  onChanged: (val) => mapping.hostPort = val,
                                )).toList(),
                              ).expanded(),
                              SizedBox(width: 4),
                              CustomInput(
                                hint: 'Interno',
                                initialValue: port.port,
                                onChanged: (val) => port.port = val,
                              ).expanded(),
                            ]
                          );
                        }).toList(),
                        SizedBox(height: 8),
                        Text('Hosts'),
                        SizedBox(height: 4),
                        ...createEntity.extraHosts!.map((host) {
                          return CustomInput(
                            hint: 'Host',
                            initialValue: host,
                            onChanged: (val) => host = val,
                          );
                        }).toList()
                      ],
                    )
                )
              ],
            ),
            actions: [
              Button(
                child: const Text('Aceptar'),
                onPressed: () {
                  createEntity.exposedPort = ports;
                  Navigator.pop(context, createEntity);
                  // Delete file here
                },
              ),
              FilledButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.pop(context, null),
              ),
            ],
          );
        }
    );
    return result;
  }
}
