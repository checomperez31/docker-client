import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-list-provider.dart';
import 'package:docker_client/screens/container/container-logs.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetails extends StatelessWidget {
  final VoidCallback back;
  final ContainerItem entity;
  final AddressesProvider addressesProvider;
  const ContainerDetails({Key? key, required this.back, required this.entity, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Row(
              children: [
                Button(onPressed: () => back(), child: const Text('Volver'))
              ],
            ),
            ContainerLogs(entity: entity, addressesProvider: addressesProvider,).expanded()
          ],
        ).expanded()
      ],
    );
  }
}
