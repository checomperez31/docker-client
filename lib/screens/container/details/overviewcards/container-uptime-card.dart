import 'dart:ui';

import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/utils/format-utils.dart' show FormatUtils;
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, Column, Row, StringExtension, FontWeight;
import 'package:styled_widget/styled_widget.dart';

class ContainerUptimeCard extends StatelessWidget {
  final DockerContainer entity;
  const ContainerUptimeCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tiempo de actividad', style: TextStyle(color: AppTheme.textColor)),
              Text(FormatUtils.formatDate(entity.state!.running! ? entity.state!.startedAt!: entity.state!.finishedAt!, 'dd/MM/yyyy HH:mm').toString(),
                  style: TextStyle(color: entity.state!.running! ? Color(0XFF4ADE80): Color(0XFFE81123), fontSize: 20, fontWeight: FontWeight.bold)
              ),
              Text(entity.state!.status!.uppercaseFirst(), style: TextStyle(color: AppTheme.textColor))
            ],
          )
        ],
      ).padding(all: 10),
    );
  }
}
