import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-logs.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetails extends StatelessWidget {
  final VoidCallback back;
  final ContainerItem entity;
  final AddressesProvider addressesProvider;
  const ContainerDetails({Key? key, required this.back, required this.entity, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () => back(), icon: const Icon(FluentIcons.chevron_left)),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(entity.simplifiedName(), style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor)),
                        const SizedBox(width: 3),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: entity.simplifiedId())).then((value) {
                              displayInfoBar(context, builder: (ctx, close) {
                                return const InfoBar(
                                  title: Text('Se ha copiado al portapapeles'),
                                  isIconVisible: false,
                                  severity: InfoBarSeverity.info,
                                );
                              });
                            });
                          },
                          child: Row(
                            children: [
                              Text(entity.simplifiedId(), style: TextStyle(fontSize: 10, color: AppTheme.textColor)),
                              const SizedBox(width: 3),
                              const Icon(FluentIcons.clipboard_list_add, size: 10,)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            ContainerLogs(entity: entity, addressesProvider: addressesProvider,).expanded()
          ],
        ).expanded()
      ],
    );
  }
}
