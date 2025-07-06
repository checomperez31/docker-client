import 'package:docker_client/models/container-stats.dart';
import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/utils/format-utils.dart';
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, Column, Row, FontWeight, Color;
import 'package:styled_widget/styled_widget.dart';

class ContainerMemoryCard extends StatelessWidget {
  final DockerContainer entity;
  final ContainerStats? stats;
  const ContainerMemoryCard({super.key, required this.entity, required this.stats});

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
              Text('Memoria', style: TextStyle(color: AppTheme.textColor)),
              Text(FormatUtils.formatBytes(stats?.memoryStats?.usage, isNull: 'NA'), style: TextStyle(color: Color(0xFFC084FC), fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ).padding(all: 10),
    );
  }
}
