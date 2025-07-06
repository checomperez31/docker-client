import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-actions.dart';
import 'package:docker_client/screens/container/container-list-dates.dart';
import 'package:docker_client/screens/container/container-list-details.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-list-status.dart';
import 'package:docker_client/screens/system/info-cards.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-badge.dart';
import 'package:docker_client/widgets/custom-button.dart';
import 'package:docker_client/widgets/custom-card.dart';
import 'package:docker_client/widgets/custom-input.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerList extends StatelessWidget {
  final void Function(ContainerItem selected)? onSelect;
  const ContainerList({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            InfoCards(),
            SizedBox(height: 10),
            CustomCard(
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    height: 40,
                                    child: CustomInput(
                                      onChanged: (query) => provider.setQuery(query),
                                    )
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                      onPressed: addressProvider.usedAddress == null && !provider.loading? null: () {
                                        provider.loadData();
                                      },
                                      child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                                  ),
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
                                              border: TableBorder(
                                                  horizontalInside: BorderSide(
                                                      width: 1,
                                                      color: AppTheme.tableBorderColor,
                                                      style: BorderStyle.solid
                                                  )
                                              ),
                                              children: [
                                                TableRow(
                                                  children: [
                                                    TableCell(child: Text('Detalles', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                                    TableCell(child: Text('Puertos', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                                    TableCell(child: Text('Creación', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                                    TableCell(child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                                    TableCell(child: Text('', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
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
                                                ))
                                              ],
                                            ).padding(top: 5).backgroundColor(AppTheme.tableBgColor),
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
