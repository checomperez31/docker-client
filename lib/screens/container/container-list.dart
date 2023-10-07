import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-actions.dart';
import 'package:docker_client/screens/container/container-list-details.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-list-status.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerList extends StatelessWidget {
  final void Function(ContainerItem selected)? onSelect;
  const ContainerList({Key? key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Consumer<AddressesProvider>(
            builder: (actx, addressProvider, child) => ChangeNotifierProvider(
              create: (_) => ContainerListProvider(addressProvider),
              child: Consumer<ContainerListProvider>(
                builder: (context, provider, child) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                            onPressed: addressProvider.usedAddress == null && !provider.loading? null: () {
                              provider.loadData();
                            },
                            child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                        )
                      ],
                    ),
                    Table(
                      border: TableBorder(
                          horizontalInside: BorderSide(
                              width: 1,
                              color: AppTheme.textColor,
                              style: BorderStyle.solid
                          )
                      ),

                      children: [
                        TableRow(
                            children: [
                              TableCell(child: Text('Detalles', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                              TableCell(child: Text('Puertos', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                              TableCell(child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                              TableCell(child: Text('', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                            ]
                        ),
                        ...provider.elements.map((e) => TableRow(
                            children: [
                              TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: ContainerListDetails(entity: e)
                              ),
                              TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: e.ports?.map((e) => Text('${e.public} -> ${e.private}', style: TextStyle(color: AppTheme.textColor),)).toList() ?? [],
                                  )
                              ),
                              TableCell(
                                  child: ContainerListStatus(entity: e)
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
                    )
                  ],
                ).padding(horizontal: 5).expanded(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
