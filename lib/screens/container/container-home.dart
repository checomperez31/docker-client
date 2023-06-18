import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-details.dart';
import 'package:docker_client/screens/container/container-list.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerHome extends StatefulWidget {
  final AddressesProvider addressesProvider;

  const ContainerHome({Key? key, required this.addressesProvider}) : super(key: key);

  @override
  State<ContainerHome> createState() => _ContainerHomeState();
}

class _ContainerHomeState extends State<ContainerHome> {
  ContainerItem? _selected;

  @override
  Widget build(BuildContext context) {
    return TabView(
        currentIndex: 0,
        tabs: [
          Tab(
            text: Text('Listado', style: TextStyle(color: AppTheme.accentTextColor)),
            body: ContainerList(
                addressesProvider: widget.addressesProvider,
                onSelect: (selected) {
                  _selected = selected;
                  setState(() {});
                }
            )
          )
        ]
    );
    /*if ( _selected == null ) {
      return ContainerList(addressesProvider: widget.addressesProvider, onSelect: (selected) {
        _selected = selected;
        setState(() {});
      });
    }
    return ContainerDetails(
      back: () => setState(() => _selected = null),
      entity: _selected!,
      addressesProvider: widget.addressesProvider
    );*/
  }
}
