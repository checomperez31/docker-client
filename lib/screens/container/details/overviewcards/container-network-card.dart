import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, EdgeInsets, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, SizedBox, Column, Row, Container, SingleChildScrollView;
import 'package:flutter/material.dart' show Icon, Icons;
import 'package:flutter/src/widgets/basic.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerNetworkCard extends StatelessWidget {
  final DockerContainer entity;
  const ContainerNetworkCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(15.0),
        height: 280,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Configuracion de red', style: TextStyle(color: AppTheme.accentTextColor, fontSize: 21)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IP', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                          Text(entity.networkSettings!.ipAddress!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                          SizedBox(height: 15),
                          Text('MAC', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                          Text(entity.networkSettings!.macAddress!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        ],
                      ),
                      SizedBox(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gateway', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                          Text(entity.networkSettings!.gateway!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                          SizedBox(height: 15),
                          Text('Modo de red', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                          Text(entity.hostConfig!.networkMode!, style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text('Puertos', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children:[
                      Column(
                        children: entity.networkSettings!.ports!.map((port) => Column(
                          children: port.mappings == null? []: port.mappings!.map((mapping) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              color: AppTheme.buttonBgColor,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(Icons.account_tree_outlined, size: 16, color: AppTheme.blue),
                                  SizedBox(width: 6),
                                  Text('${port.port!}:${mapping.hostPort}', style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16))
                                ],
                              ),
                            ),
                          )
                          ).toList(),
                        )).toList()
                      ).expanded()
                    ],
                  ),
                ],
              ).expanded()
            ],
          ),
        )
    );
  }
}
