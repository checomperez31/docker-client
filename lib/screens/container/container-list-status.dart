import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListStatus extends StatelessWidget {
  ContainerItem entity;

  ContainerListStatus({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if ( entity.state != null ) createBadge(),
            if ( entity.created != null ) Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Creado '),
                Text( FormatUtils.formatSeconds( entity.created ) )
              ],
            ),
            if ( entity.status != null ) Text(entity.status!),
          ]
      ),
    );
  }

  Widget createBadge() {
    Color background = Colors.red;
    Color text = Colors.white;
    if ( entity.state == 'running' ) background = Colors.green;
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(3)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(entity.state!, style: TextStyle(color: text)),
    );
  }
}
