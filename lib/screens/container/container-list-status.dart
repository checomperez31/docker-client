import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListStatus extends StatelessWidget {
  final ContainerItem entity;
  final bool showTime;
  final double statusSize;

  const ContainerListStatus({Key? key, required this.entity, this.showTime = true, this.statusSize = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 12, color: AppTheme.textColor);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if ( entity.state != null ) createBadge(),
            if ( entity.created != null && showTime ) Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Created ', style: style),
                Text( FormatUtils.formatSeconds( entity.created ), style: style )
              ],
            ),
            if ( entity.status != null && showTime) Text(entity.status!, style: style),
          ]
      ),
    );
  }

  Widget createBadge() {
    Color background = Colors.red;
    Color text = Colors.white;
    switch( entity.state ) {
      case 'running': {
        background = const Color(0xFF0F9F44);
        break;
      }
      case 'created': {
        background = Colors.blue;
        break;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(3)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(entity.state!.uppercaseFirst(), style: TextStyle(color: text, fontSize: statusSize)),
    );
  }
}
