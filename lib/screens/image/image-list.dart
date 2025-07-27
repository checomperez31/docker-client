import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/image/image-list-actions.dart';
import 'package:docker_client/screens/image/image-list-provider.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:docker_client/widgets/custom-button.dart' show CustomButton;
import 'package:docker_client/widgets/custom-card.dart';
import 'package:docker_client/widgets/custom-input.dart' show CustomInput;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ImageList extends StatelessWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            CustomCard(
              child: Consumer<AddressesProvider>(
                  builder: (actx, addressProvider, child) => ChangeNotifierProvider(
                    create: (_) => ImageListProvider(addressProvider),
                    child: Consumer<ImageListProvider>(
                      builder: (context, provider, child) => Row(
                        children: [
                          Column(
                            children: [
                              Row(
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
                                  Tooltip(
                                    message: 'Actualizar',
                                    child: CustomButton(
                                      onPressed: addressProvider.usedAddress == null && !provider.loading? null: () {
                                        provider.loadData();
                                      },
                                      child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Tooltip(
                                    message: 'Eliminar imagenes sin Tag',
                                    child: CustomButton(
                                      onPressed: addressProvider.usedAddress == null && !provider.loadingPrune? null: () {
                                        provider.prune();
                                      },
                                      child: provider.loadingPrune ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.remove)
                                    )
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                            TableCell(child: Text('Tags', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                            TableCell(child: Text('Created', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                            TableCell(child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                            TableCell(child: Text('', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.tableHeaderColor))),
                                          ]
                                      ),
                                      ...provider.elements.map((e) => TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment: TableCellVerticalAlignment.middle,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(e.simplifiedTag(), style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor)),
                                                Text('Containers: ${e.containers}', style: TextStyle(fontSize: 12, color: AppTheme.textColor))
                                              ],
                                            ).padding(vertical: 5)
                                          ),
                                          TableCell(
                                            verticalAlignment: TableCellVerticalAlignment.middle,
                                            child: Text(e.simplifiedCreated(), style: TextStyle(color: AppTheme.textColor),)
                                          ),
                                          TableCell(
                                            verticalAlignment: TableCellVerticalAlignment.middle,
                                            child: Text(FormatUtils.formatBytes( e.size, isNull: 'NA' ), style: TextStyle(color: AppTheme.textColor),)
                                          ),
                                          TableCell(
                                            verticalAlignment: TableCellVerticalAlignment.middle,
                                            child: ImageListActions(
                                              entity: e,
                                              provider: provider,
                                            )
                                          )
                                        ]
                                      ))
                                    ],
                                  ),
                                ),
                              ).expanded()
                            ],
                          ).expanded()
                        ],
                      ),
                    ),
                  )
              )
            ).expanded()
          ],
        ).expanded(),
      ],
    ).padding(horizontal: 30, vertical: 8);
  }
}
