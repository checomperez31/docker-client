import 'package:docker_client/models/menu_option.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/container/container-home.dart';
import 'package:docker_client/screens/container/container-list.dart';
import 'package:docker_client/screens/directions/directions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  int index = 0;
  String title = '';

  List<MenuOption> options = [
    MenuOption(title: 'Contenedores', icon: FluentIcons.content_settings),
    MenuOption(title: 'Imagenes', icon: FluentIcons.apps_content),
    MenuOption(title: 'Direcciones', icon: FluentIcons.m_s_lists_connected),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
      builder: (context, provider, child) => NavigationView(
        appBar: NavigationAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(options[index].title),
                if ( provider.usedAddress != null ) ComboBox(
                  value: provider.usedAddress,
                  items: provider.addresses.map((e) => ComboBoxItem(value: e, child: Text(e))).toList(),
                  onChanged: (option) {
                    if ( option != null ) {
                      provider.use( option );
                    }
                  },
                ),
                /*if ( provider.usedAddress != null ) Text(provider.usedAddress!)*/
              ],
            ),
            automaticallyImplyLeading: false
        ),
      pane: NavigationPane(
            selected: index,
            displayMode: PaneDisplayMode.compact,
            onChanged: (i) => setState(() => index = i),
            items: [
              PaneItem(
                icon: Icon(options[0].icon),
                title: Text(options[0].title),
                body: ContainerHome(addressesProvider: provider),
              ),
              PaneItem(
                icon: Icon(options[1].icon),
                title: Text(options[1].title),
                body: Text('Aquí van a ir las imágenes'),
              ),
              PaneItem(
                icon: Icon(options[2].icon),
                title: Text(options[2].title),
                body: Directions(),
              )
            ].cast<NavigationPaneItem>()
        ),
      )
    );
  }

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
