import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-actions.dart';
import 'package:docker_client/screens/container/container-list-details.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-list-status.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ContainerList extends StatelessWidget {
  final AddressesProvider addressesProvider;
  const ContainerList({Key? key, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ChangeNotifierProvider(
            create: (_) => ContainerListProvider(addressesProvider),
            child: Consumer<ContainerListProvider>(
              builder: (context, provider, child) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button(
                                onPressed: addressesProvider.usedAddress == null? null: () {
                                  provider.loadData();
                                },
                                child: const Text('Actualizar')
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
                            const TableRow(
                                children: [
                                  // TableCell(child: Text('ID')),
                                  TableCell(child: Text('Detalles', style: TextStyle(fontWeight: FontWeight.bold))),
                                  TableCell(child: Text('Puertos', style: TextStyle(fontWeight: FontWeight.bold))),
                                  TableCell(child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold))),
                                  TableCell(child: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
                                ]
                            ),
                            ...provider.elements.map((e) => TableRow(
                                children: [
                                  // TableCell(child: Text(e.id ?? 'Sin ID')),
                                  TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.middle,
                                      child: ContainerListDetails(entity: e)
                                  ),
                                  TableCell(
                                      verticalAlignment: TableCellVerticalAlignment.middle,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: e.ports?.map((e) => Text('${e.public} -> ${e.private}')).toList() ?? [],
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
                                      )
                                  )
                                ]
                            )).toList()
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
