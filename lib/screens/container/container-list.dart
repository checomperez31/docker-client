import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/utils/format-utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ContainerList extends StatelessWidget {
  const ContainerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ChangeNotifierProvider(
          create: (_) => ContainerListProvider(),
          child: Consumer<ContainerListProvider>(
            builder: (context, provider, child) => Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(child: Text('Refresh'), onPressed: () {
                          provider.loadData();
                        })
                      ],
                    ),
                    Table(
                      children: [
                        const TableRow(
                          children: [
                            // TableCell(child: Text('ID')),
                            TableCell(child: Text('Container', style: TextStyle(fontWeight: FontWeight.bold))),
                            TableCell(child: Text('Ports', style: TextStyle(fontWeight: FontWeight.bold))),
                            TableCell(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                            TableCell(child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                          ]
                        ),
                        ...provider.elements.map((e) => TableRow(
                          children: [
                            // TableCell(child: Text(e.id ?? 'Sin ID')),
                            TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: '),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: e.names?.map((e) => Text(e ?? 'Sin nombre')).toList() ?? [],
                                    ),
                                    if ( e.image != null ) Text('Imagen: ${e.image}')
                                  ]
                                )
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: e.ports?.map((e) => Text('${e.public} -> ${e.private}')).toList() ?? [],
                              )
                            ),
                            TableCell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if ( e.created != null ) Text( FormatUtils.formatSeconds( e.created ) ),
                                  if ( e.state != null ) Text(e.state!),
                                  if ( e.status != null ) Text(e.status!),
                                ]
                              )
                            ),
                            TableCell(
                                child: Row(
                                  children: [
                                    Button(child: Text('Hola 1'), onPressed: () {}),
                                    Button(child: Text('Hola 2'), onPressed: () {})
                                  ],
                                )
                            )
                          ]
                        )).toList()
                      ],
                    )
                  ],
                )
            ),
          ),
        )
      ],
    );
  }
}
