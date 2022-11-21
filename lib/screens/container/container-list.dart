import 'package:docker_client/screens/container/container-list-provider.dart';
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
                            TableCell(child: Text('ID')),
                            TableCell(child: Text('Names')),
                            TableCell(child: Text('Image')),
                          ]
                        ),
                        ...provider.elements.map((e) => TableRow(
                          children: [
                            TableCell(child: Text(e.id ?? 'Sin ID')),
                            TableCell(child: Column(
                              children: e.names?.map((e) => Text(e ?? 'Sin nombre')).toList() ?? [],
                            )),
                            TableCell(child: Text(e.image ?? 'Sin imagen')),
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
