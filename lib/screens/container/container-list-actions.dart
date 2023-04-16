import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/models/container_item.dart';

class ContainerListActions extends StatelessWidget {
  ContainerItem entity;
  ContainerListProvider provider;

  ContainerListActions({Key? key, required this.entity, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if ( entity.state == 'exited' || entity.state == 'running' ) Button(child: const Text('Reiniciar'), onPressed: provider.loadingRestart ? null: () {
          provider.restart( entity.id! );
        }),
        if ( entity.state == 'running' ) Button(child: const Text('Detener'), onPressed: provider.loadingStop ? null: () {
          provider.stop( entity.id! );
        }),
        if ( entity.state == 'exited' ) Button(child: const Text('Eliminar'), onPressed: provider.loadingKill ? null: () {
          provider.remove( entity.id! );
        }),
      ],
    );
  }
}
