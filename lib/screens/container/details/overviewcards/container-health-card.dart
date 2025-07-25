import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:docker_client/widgets/custom-text-row.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerHealthCard extends StatelessWidget {
  final DockerContainer entity;
  const ContainerHealthCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(15.0),
        height: ( entity.state?.error != null && entity.state?.error != '' ) ? 400: 330,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Salud', style: TextStyle(color: AppTheme.accentTextColor, fontSize: 21)),
                SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reinicios', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        Text(entity.restartCount?.toString() ?? 'NA', style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        if ( entity.state?.error != null && entity.state?.error != '' ) SizedBox(height: 15),
                        if ( entity.state?.error != null && entity.state?.error != '' ) Text('Error', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                        if ( entity.state?.error != null && entity.state?.error != '' ) Text(entity.state!.error!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                      ],
                    ).expanded(),
                  ],
                ),
                SizedBox(height: 15),
                Text('Comando', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                CustomTextRow(icon: Icons.terminal, text: entity.resolvConfPath),
                SizedBox(height: 2),
                CustomTextRow(icon: Icons.terminal, text: entity.hostnamePath),
                SizedBox(height: 2),
                CustomTextRow(icon: Icons.terminal, text: entity.hostsPath),
                SizedBox(height: 2),
                CustomTextRow(icon: Icons.terminal, text: entity.logPath),
                SizedBox(height: 2),
              ],
            ).expanded()
          ],
        )
    );
  }
}
