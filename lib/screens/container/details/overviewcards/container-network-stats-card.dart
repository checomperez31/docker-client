import 'package:docker_client/models/container-stats.dart';
import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/utils/format-utils.dart';
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, Column, Row, FontWeight, Color;
import 'package:flutter/material.dart' show Icon, Icons;
import 'package:styled_widget/styled_widget.dart';

class ContainerNetworkStatsCard extends StatelessWidget {
  final DockerContainer entity;
  final ContainerStats? stats;
  const ContainerNetworkStatsCard({super.key, required this.entity, required this.stats});

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
              Text('Red', style: TextStyle(color: AppTheme.textColor)),
              Row(
                children: [
                  Icon(Icons.arrow_downward, color: Color(0XFF4ADE80), size: 13),
                  Text(FormatUtils.formatBytesComplete(stats?.networks?.eth0?.rxBytes, isNull: 'NA'), style: TextStyle(color: Color(0XFF4ADE80), fontSize: 15, fontWeight: FontWeight.normal)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: Color(0xff5A9AEA), size: 13),
                  Text(FormatUtils.formatBytesComplete(stats?.networks?.eth0?.txBytes, isNull: 'NA'), style: TextStyle(color: Color(0xff5A9AEA), fontSize: 15, fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          )
        ],
      ).padding(all: 10),
    );
  }
}
