

import 'package:docker_client/models/container.dart' show Container;
import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/utils/format-utils.dart' show FormatUtils;
import 'package:docker_client/widgets/custom-card.dart' show CustomCard;
import 'package:fluent_ui/fluent_ui.dart' show StatelessWidget, BuildContext, Widget, EdgeInsets, MainAxisAlignment, CrossAxisAlignment, TextStyle, Text, SizedBox, Column, Row;

class ContainerInfoCard extends StatelessWidget {
  final Container entity;
  const ContainerInfoCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(15.0),
        width: 400,
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
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text('Comando', style: TextStyle(color: AppTheme.textColor, fontSize: 13)),
                Text(entity.config!.entrypoint.toString(), style: TextStyle(color: AppTheme.accentTextColor, fontSize: 16)),
              ],
            )
          ],
        )
    );
  }
}
