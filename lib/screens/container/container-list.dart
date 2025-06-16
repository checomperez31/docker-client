import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-actions.dart';
import 'package:docker_client/screens/container/container-list-dates.dart';
import 'package:docker_client/screens/container/container-list-details.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-list-status.dart';
import 'package:docker_client/screens/system/info-cards.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-badge.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerList extends StatelessWidget {
  final void Function(ContainerItem selected)? onSelect;
  const ContainerList({Key? key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            InfoCards(),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff191A23)
              ),
              child: Consumer<AddressesProvider>(
                builder: (actx, addressProvider, child) => ChangeNotifierProvider(
                  create: (_) => ContainerListProvider(addressProvider),
                  child: Consumer<ContainerListProvider>(
                      builder: (context, provider, child) => Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    children: [
                                      TextBox(
                                        style: TextStyle(color: AppTheme.accentTextColor),
                                        cursorColor: AppTheme.accentTextColor,
                                        decoration: WidgetStatePropertyAll(BoxDecoration(
                                            color: AppTheme.buttonBgColor
                                        )),
                                        onChanged: (query) => provider.setQuery(query),
                                      ),
                                    ],
                                  ).padding(right: 10).expanded(),
                                  Button(
                                      onPressed: addressProvider.usedAddress == null && !provider.loading? null: () {
                                        provider.loadData();
                                      },
                                      child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                                  )
                                ],
                              ).padding(vertical: 4, horizontal: 3),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Table(
                                              border: const TableBorder(
                                                  horizontalInside: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFF374151),
                                                      style: BorderStyle.solid
                                                  )
                                              ),
                                              children: [
                                                const TableRow(
                                                    children: [
                                                      TableCell(child: Text('Detalles', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9299A4)))),
                                                      TableCell(child: Text('Puertos', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9299A4)))),
                                                      TableCell(child: Text('Creación', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9299A4)))),
                                                      TableCell(child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9299A4)))),
                                                      TableCell(child: Text('', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9299A4)))),
                                                    ]
                                                ),
                                                ...provider.elements.map((e) => TableRow(
                                                    children: [
                                                      TableCell(
                                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                                          child: ContainerListDetails(entity: e).padding(vertical: 10)
                                                      ),
                                                      TableCell(
                                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: e.distinctPorts().map((e) => CustomBadge(
                                                              text: e,
                                                              background: const Color(0xFF1B2230),
                                                              borderColor: const Color(0xFF364050),
                                                            )).toList(),
                                                          )
                                                      ),
                                                      TableCell(
                                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                                          child: ContainerListDates(entity: e)
                                                      ),
                                                      TableCell(
                                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                                          child: ContainerListStatus(entity: e, showTime: false)
                                                      ),
                                                      TableCell(
                                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                                          child: ContainerListActions(
                                                            entity: e,
                                                            provider: provider,
                                                            onSelect: onSelect,
                                                          )
                                                      )
                                                    ]
                                                )).toList()
                                              ],
                                            ).padding(top: 5),
                                          )
                                      ).expanded()
                                    ],
                                  ).expanded()
                                ],
                              ).expanded()
                            ],
                          ).expanded(),
                        ],
                      )
                  ),
                ),
              ),
            ).expanded()
          ],
        ).expanded()
      ],
    ).padding(horizontal: 30, vertical: 8);
  }
}
