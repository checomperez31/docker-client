import 'package:docker_client/screens/container/container-list-actions.dart';
import 'package:docker_client/screens/container/container-list-status.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetailsHeader extends StatelessWidget {
  const ContainerDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContainersProvider>(
        builder: (context, provider, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider.selected!.simplifiedName(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(provider.selected!.image!, style: TextStyle(fontSize: 13, color: AppTheme.secondaryTextColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ( provider.selected!.address != null ) Text(provider.selected!.address!, style: TextStyle(fontSize: 12, color: AppTheme.secondaryTextColor)),
                    Text(provider.selected!.simplifiedPort(), style: TextStyle(fontSize: 12, color: AppTheme.secondaryTextColor)),
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
                              style: TextStyle(fontSize: 12, color: AppTheme.secondaryTextColor)),
                          const SizedBox(width: 3),
                          const Icon(
                            FluentIcons.clipboard_list_add,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                    ContainerListStatus(entity: provider.selected!, showTime: false, statusSize: 10,)
                  ],
                ).padding(left: 10),
              ],
            ),
            Row(
              children: [
                IconButton(onPressed: () => provider.unselect(), icon: Icon(FluentIcons.mini_contract_mirrored, size: 17, color: AppTheme.accentTextColor)),
                IconButton(onPressed: () => provider.close(), icon: Icon(FluentIcons.chrome_close, size: 17, color: AppTheme.accentTextColor)),
              ],
            )
          ],
        ).padding(horizontal: 10, top: 7, bottom: 3)
    );
  }
}
