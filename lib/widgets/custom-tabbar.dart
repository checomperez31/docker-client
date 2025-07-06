import 'package:docker_client/theme.dart' show AppTheme;
import 'package:docker_client/widgets/custom-tabbar-provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;
import 'package:styled_widget/styled_widget.dart';

class CustomTabbar extends StatelessWidget {
  final List<CustomTab> tabs;
  const CustomTabbar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => CustomTabbarProvider(),
        child:  Consumer<CustomTabbarProvider>(builder: (cdpctx, provider, cdpchild) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: BoxBorder.all(
                                width: 1,
                                color: AppTheme.buttonBorderColor
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                            children: tabs.map((tab) {
                              var position = tabs.indexOf(tab);
                              return FluentTheme(
                                  data: FluentTheme.of(context).copyWith(
                                    buttonTheme: ButtonThemeData(
                                      defaultButtonStyle: ButtonStyle(
                                          backgroundColor: ButtonState.resolveWith((states) {
                                            if (position == provider.selectedTab) return AppTheme.blue;
                                            if (states.isHovering) return AppTheme.buttonBgHoveredColor;
                                            return AppTheme.buttonBgColor;
                                          }),
                                          textStyle: ButtonState.resolveWith((states) {
                                            if (states.isHovering) return TextStyle(color: AppTheme.accentTextColor);
                                            if (states.isDisabled || position != provider.selectedTab) return TextStyle(color: AppTheme.disabledTextColor);
                                            return TextStyle(color: AppTheme.textColor);
                                          }),
                                          foregroundColor: WidgetStatePropertyAll(AppTheme.buttonTextColor),
                                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                              borderRadius: BorderRadiusGeometry.only(
                                                bottomLeft: Radius.circular(position == 0 ? 6: 0),
                                                topLeft: Radius.circular(position == 0 ? 6: 0),
                                                topRight: Radius.circular(position == (tabs.length - 1) ? 6: 0),
                                                bottomRight: Radius.circular(position == (tabs.length - 1) ? 6: 0),
                                              ),
                                              side: BorderSide(
                                                  width: 1,
                                                  color: AppTheme.buttonBorderColor
                                              )
                                          ))
                                      ),
                                    ),
                                  ),
                                  child: Button(
                                    child: Row(
                                      children: [
                                        tab.icon,
                                        SizedBox(width:8),
                                        tab.text
                                      ],
                                    ).padding(horizontal: 15),
                                    onPressed: () => provider.selectedTab = position,
                                  )
                              );
                            }).toList()
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    child: tabs[provider.selectedTab].child,
                  ).expanded()
                ],
              ).expanded()
            ],
          );
        })
    );
  }
}


class CustomTab extends StatelessWidget {
  final Widget child;
  final Text text;
  final Icon icon;
  const CustomTab({super.key, required this.child, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

