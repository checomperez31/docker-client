

import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/utils/format-utils.dart' show FormatUtils;
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:docker_client/widgets/custom-text-row.dart' show CustomTextRow;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, EdgeInsets, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, SizedBox, Column, Row, MainAxisSize;
import 'package:flutter/material.dart' show Icons;
import 'package:styled_widget/styled_widget.dart';

class ContainerInfoCard extends StatelessWidget {
  final DockerContainer entity;
  const ContainerInfoCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(15.0),
        height: 390,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Informacion de contenedor', style: TextStyle(color: AppTheme.accentTextColor, fontSize: 21)),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Imagen', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(entity.config!.image!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        SizedBox(height: 15),
                        Text('Created', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(FormatUtils.formatDate(entity.created!, 'dd/MM/yyyy HH:mm'), style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        SizedBox(height: 15),
                        Text('Size Rw', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(FormatUtils.formatBytesComplete(entity.sizeRw, isNull: 'NA'), style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Plataforma', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(entity.platform!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        SizedBox(height: 15),
                        Text('Driver', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(entity.driver!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        SizedBox(height: 15),
                        Text('Size FS', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(FormatUtils.formatBytesComplete(entity.sizeRootFs, isNull: 'NA'), style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                if ( entity.state?.pid != null ) SizedBox(height: 15),
                if ( entity.state?.pid != null ) Text('PID', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                if ( entity.state?.pid != null ) Text(entity.state!.pid.toString(), style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                SizedBox(height: 15),
                Text('Comando', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                CustomTextRow(icon: Icons.terminal, text: entity.config!.entrypoint!.reduce((value, element) => '$value $element')),
                SizedBox(height: 15),
                Text('Binds', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children:entity.hostConfig!.binds!.map((host) => CustomTextRow(icon: Icons.account_tree_outlined, text: host)).toList(),
                ).expanded(),
              ],
            ).expanded()
          ],
        )
    );
  }
}
