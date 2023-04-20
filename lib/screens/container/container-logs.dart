import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-logs-provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerLogs extends StatelessWidget {
  final ContainerItem entity;
  final AddressesProvider addressesProvider;
  const ContainerLogs({Key? key, required this.entity, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContainerLogsProvider(addressesProvider, entity.id!),
      child: Consumer<ContainerLogsProvider>(
        builder: (__, provider, child) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextBox(
                        controller: TextEditingController(text: provider.tail),
                        onChanged: (txt) {
                          if (txt != null && !txt.isEmpty) {
                            provider.tail = txt;
                          } else {
                            provider.tail = '50';
                          }
                        },
                      ).expanded(),
                      Button(child: Text('Actualizar'), onPressed: provider.logs)
                    ],
                  ),
                  SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: provider.list.map((e) => Text(e, style: TextStyle(color: Colors.white),)).toList(),
                        ).expanded()
                      ],
                    ),
                  ).backgroundColor(Colors.grey).expanded()
                ],
              ).expanded()
            ],
          );
        },
      ),
    );
  }
}
