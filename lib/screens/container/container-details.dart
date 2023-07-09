import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-logs.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetails extends StatelessWidget {

  const ContainerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (ctx, addressesProvider, addressChild) => Consumer<ContainersProvider>(
            builder: (context, provider, child) => Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => provider.unselect(), icon: const Icon(FluentIcons.chevron_left)),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(provider.selected!.simplifiedName(),
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor)),
                                    const SizedBox(width: 3),
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: provider.selected!.simplifiedId())).then((value) {
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
                                          Text(provider.selected!.simplifiedId(),
                                              style: TextStyle(fontSize: 10, color: AppTheme.textColor)),
                                          const SizedBox(width: 3),
                                          const Icon(
                                            FluentIcons.clipboard_list_add,
                                            size: 10,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        ContainerLogs(
                          entity: provider.selected!,
                          addressesProvider: addressesProvider,
                        ).expanded()
                      ],
                    ).expanded()
                  ],
                ).backgroundColor(AppTheme.scaffoldColor)
        )
    );
  }
}
