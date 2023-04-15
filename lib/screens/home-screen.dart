import 'package:docker_client/models/menu_option.dart';
import 'package:docker_client/screens/container/container-list.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(options[index].title),
            Text('IP')
          ],
        ),
        automaticallyImplyLeading: false
      ),
      pane: NavigationPane(
        selected: index,
        displayMode: PaneDisplayMode.auto,
        onChanged: (i) => setState(() => index = i),
        items: [
          PaneItem(
            icon: Icon(options[0].icon),
            title: Text(options[0].title),
            body: ContainerList(),
          ),
          PaneItem(
            icon: Icon(options[1].icon),
            title: Text(options[1].title),
            body: Text('Contenedores2'),
          )
        ].cast<NavigationPaneItem>()
      ),
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
