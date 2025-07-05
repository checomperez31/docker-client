import 'package:docker_client/preferences/preferences.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/home-screen.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: true,
      );
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(350, 400));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(false);
      await windowManager.setSkipTaskbar(false);
      await windowManager.setTitle('Cliente de docker');
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();
    return FluentApp(
      title: 'Docker client',
      debugShowCheckedModeBanner: false,
      themeMode: appTheme.mode,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AddressesProvider()),
          ChangeNotifierProvider(create: (context) => ContainersProvider()),
        ],
        child: const HomeScreen(),
      ),
      theme: FluentThemeData(
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      darkTheme: FluentThemeData(
        accentColor: appTheme.color,
        scaffoldBackgroundColor: AppTheme.scaffoldColor,
        acrylicBackgroundColor: Colors.green,
        activeColor: Colors.purple,
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: AppTheme.scaffold2Color,
          selectedTextStyle: ButtonState.all(TextStyle(color: AppTheme.accentTextColor)),
          unselectedTextStyle: ButtonState.all(TextStyle(color: AppTheme.textColor)),
          //Cannot view changes
          // itemHeaderTextStyle: TextStyle(color: Colors.red)
          // unselectedIconColor: ButtonState.all(AppTheme.textColor),
          // selectedIconColor: ButtonState.all(Colors.red),
          // Changes background button color
          // tileColor: ButtonState.all(Colors.red)
        ),
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 5.0 : 0.0,
        ),
        iconTheme: IconThemeData(color: AppTheme.textColor),
        buttonTheme: ButtonThemeData(
          defaultButtonStyle: ButtonStyle(
              backgroundColor: ButtonState.resolveWith((states) {
                if (states.isHovering) return AppTheme.buttonBgHoveredColor;
                return AppTheme.buttonBgColor;
              }),
              textStyle: ButtonState.resolveWith((states) {
                if (states.isHovering) return TextStyle(color: AppTheme.accentTextColor);
                if (states.isDisabled) return TextStyle(color: AppTheme.disabledTextColor);
                return TextStyle(color: AppTheme.textColor);
              }),
              foregroundColor: WidgetStatePropertyAll(AppTheme.buttonTextColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(6)),
                side: BorderSide(
                  width: 1,
                  color: AppTheme.buttonBorderColor
                )
              )) 
          ),
        ),
        tooltipTheme: TooltipThemeData(textStyle: TextStyle(color: AppTheme.textColor), decoration: BoxDecoration(color: AppTheme.buttonBgColor, borderRadius: BorderRadius.circular(8))),
        typography: Typography.raw(
          caption: TextStyle(color: AppTheme.textColor),
          body: TextStyle(color: AppTheme.accentTextColor),
        ),
        dividerTheme: DividerThemeData(decoration: BoxDecoration(color: AppTheme.textColor)),
        dialogTheme: ContentDialogThemeData(
            decoration: BoxDecoration(color: AppTheme.scaffoldColor, borderRadius: BorderRadius.circular(8)),
            actionsDecoration: BoxDecoration(color: AppTheme.scaffoldColor, borderRadius: BorderRadius.circular(8)),
            actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 20)
        ),
      ),
    );
  }
}
