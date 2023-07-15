import 'package:docker_client/models/menu_option.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/container-details.dart';
import 'package:docker_client/screens/container/container-home.dart';
import 'package:docker_client/screens/directions/directions.dart';
import 'package:docker_client/screens/home-header.dart';
import 'package:docker_client/screens/image/image-list.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:window_manager/window_manager.dart';

import '../theme.dart';

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
      builder: (ctx, addressProvider, addressChild) {
        return Consumer<ContainersProvider>(
            builder: (context, provider, child) => Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        NavigationView(
                          appBar: NavigationAppBar(
                            height: 40,
                            title: HomeHeader(option: options[index].title),
                            automaticallyImplyLeading: false,
                          ),
                          pane: NavigationPane(
                              selected: index,
                              displayMode: PaneDisplayMode.compact,
                              onChanged: (i) => setState(() => index = i),
                              items: [
                                PaneItem(
                                  icon: Icon(options[0].icon),
                                  title: Text(options[0].title),
                                  body: ContainerHome(addressesProvider: addressProvider),
                                ),
                                PaneItem(
                                    icon: Icon(options[1].icon),
                                    title: Text(options[1].title),
                                    body: ImageList(addressesProvider: addressProvider)
                                ),
                                PaneItem(
                                  icon: Icon(options[2].icon),
                                  title: Text(options[2].title),
                                  body: Directions(),
                                )
                              ].cast<NavigationPaneItem>()
                          ),
                        ),
                        if ( provider.selected != null ) const ContainerDetails()
                      ],
                    ).expanded(),
                    if ( provider.containers.isNotEmpty ) Row(
                      children: [
                        ScrollConfiguration(
                            behavior: MyCustomScrollBehavior(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              reverse: true,
                              child: Row(
                                children: provider.containers.map((container) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(child: Text(container.simplifiedName(), style: TextStyle(color: AppTheme.accentTextColor)), onPressed:() => provider.select( container )),
                                    IconButton(icon: Icon(FluentIcons.chrome_close, size: 8), onPressed: () => provider.remove( container ))
                                  ],
                                ).backgroundColor(AppTheme.buttonBgColor)).toList(),
                              ),
                            ).expanded()
                        )
                      ],
                    ).backgroundColor(AppTheme.scaffoldColor)
                  ],
                ).expanded()
              ],
            )
        );
      }
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

class MyCustomScrollBehavior extends FluentScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    // etc.
  };
}
