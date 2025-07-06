import 'package:docker_client/screens/container/container-list-status.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-button.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetailsHeader extends StatelessWidget {
  const ContainerDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContainersProvider>(
        builder: (context, provider, child) => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomButton(
                            onPressed: () => provider.close(), child: Icon(FluentIcons.back, size: 17, color: AppTheme.accentTextColor)
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(width: 1, height: 30, color: AppTheme.secondaryTextColor),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(provider.selected!.simplifiedName(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                SizedBox(width: 8),
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
                                  child:Icon(
                                    FluentIcons.clipboard_list_add,
                                    size: 12,
                                    color: AppTheme.accentTextColor,
                                  )
                                ),
                                SizedBox(width: 8),
                                ContainerListStatus(entity: provider.selected!, showTime: false, statusSize: 10),
                              ],
                            ),
                            Row(
                              children: [
                                Text(provider.selected!.image!, style: TextStyle(fontSize: 13, color: AppTheme.secondaryTextColor)),
                                SizedBox(width: 8),
                                Text(provider.selected!.simplifiedPort(), style: TextStyle(fontSize: 12, color: AppTheme.secondaryTextColor)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: () => provider.unselect(), icon: Icon(FluentIcons.mini_contract_mirrored, size: 17, color: AppTheme.accentTextColor)),
                          ],
                        ),
                        if ( provider.selected!.address != null ) Text(provider.selected!.address!, style: TextStyle(fontSize: 12, color: AppTheme.secondaryTextColor)),
                      ],
                    )
                  ],
                ),
              ],
            ).expanded(),
          ],
        ).padding(horizontal: 10, top: 7, bottom: 3).backgroundColor(AppTheme.scaffold2Color)
    );
  }
}
