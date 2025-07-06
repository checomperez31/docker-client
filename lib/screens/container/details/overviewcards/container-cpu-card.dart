import 'package:docker_client/models/container-stats.dart';
import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, Column, Row, FontWeight, Color;
import 'package:styled_widget/styled_widget.dart';

class ContainerCpuCard extends StatelessWidget {
  final DockerContainer entity;
  final ContainerStats? stats;
  const ContainerCpuCard({super.key, required this.entity, required this.stats});

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
              Text('CPU', style: TextStyle(color: AppTheme.textColor)),
              Text(stats != null ? '${(stats!.getCpuUsage())} %': 'NA', style: TextStyle(color: Color(0xff5A9AEA), fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ).padding(all: 10),
    );
  }
}
