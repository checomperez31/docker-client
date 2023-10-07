import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/container-list.dart';

class ContainerHome extends StatelessWidget {

  const ContainerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContainersProvider>(
        builder: (context, provider, child) => ContainerList(
          onSelect: (selected) {
            provider.add( selected );
          }
        )
    );
  }
}
