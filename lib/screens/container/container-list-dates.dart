import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListDates extends StatelessWidget {
  final ContainerItem entity;

  const ContainerListDates({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 12, color: AppTheme.textColor);
    final dt = FormatUtils.dateFromMillisecondsUnix( entity.created );
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if ( entity.created != null && dt != null) Text( FormatUtils.formatDate(dt, 'dd/MM/yyyy HH:mm'), style: style ),
          if ( entity.status != null) Text(entity.status!, style: style),
        ]
    );
  }
}
