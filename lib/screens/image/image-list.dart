import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/image/image-list-actions.dart';
import 'package:docker_client/screens/image/image-list-provider.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ImageList extends StatelessWidget {
  final AddressesProvider addressesProvider;
  const ImageList({Key? key, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ChangeNotifierProvider(
            create: (_) => ImageListProvider(addressesProvider),
            child: Consumer<ImageListProvider>(
              builder: (context, provider, child) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: 'Actualizar',
                        child: Button(
                            onPressed: addressesProvider.usedAddress == null && !provider.loading? null: () {
                              provider.loadData();
                            },
                            child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                        )
                      ),
                      Tooltip(
                          message: 'Eliminar imagenes sin Tag',
                          child: Button(
                              onPressed: addressesProvider.usedAddress == null && !provider.loading? null: () {
                                provider.loadData();
                              },
                              child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.remove)
                          )
                      )
                    ],
                  ),
                  Table(
                    border: const TableBorder(
                        horizontalInside: BorderSide(
                            width: 1,
                            color: Colors.grey,
                            style: BorderStyle.solid
                        )
                    ),

                    children: [
                      TableRow(
                          children: [
                            // TableCell(child: Text('ID')),
                            TableCell(child: Text('Tags', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                            TableCell(child: Text('Created', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                            TableCell(child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
                            TableCell(child: Text('', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentTextColor))),
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
                                child: Text(FormatUtils.formatSeconds( e.created, isNull: 'NA' ), style: TextStyle(color: AppTheme.textColor),)
                            ),
                            TableCell(
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
                      )).toList()
                    ],
                  )
                ],
              ).padding(horizontal: 5).expanded(),
            ),
          )
        ],
      ),
    );
  }
}
