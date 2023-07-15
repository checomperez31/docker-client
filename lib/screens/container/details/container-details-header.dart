import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/providers/containers_provider.dart';

class ContainerDetailsHeader extends StatelessWidget {
  final ContainersProvider provider;
  const ContainerDetailsHeader({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () => provider.unselect(), icon: const Icon(FluentIcons.mini_contract_mirrored)),
      ],
    );
  }
}
