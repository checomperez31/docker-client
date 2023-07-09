import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/container-list.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ContainerHome extends StatelessWidget {
  final AddressesProvider addressesProvider;

  const ContainerHome({Key? key, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContainersProvider>(
        builder: (context, provider, child) => ContainerList(
          addressesProvider: addressesProvider,
          onSelect: (selected) {
            provider.add( selected );
          }
        )
    );
  }
}
