import 'package:fluent_ui/fluent_ui.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/theme.dart';

class ContainerBottomOption extends StatelessWidget {
  final ContainerItem option;
  final ContainersProvider provider;
  const ContainerBottomOption({Key? key, required this.option, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppTheme.secondaryTextColor),
          top: BorderSide(color: AppTheme.secondaryTextColor)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            style: ButtonStyle(
              padding: ButtonState.all(EdgeInsets.only(top: 4, bottom: 4, left: 10, right: provider.selected == option ? 10: 0))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(option.simplifiedName(), style: TextStyle(color: provider.selected == option ? Colors.white: AppTheme.secondaryTextColor)),
                Row(
                  children: [
                    if ( option.address != null ) Text(option.address!, style: TextStyle(fontSize: 11, color: provider.selected == option ? AppTheme.accentTextColor: AppTheme.textColor)),
                    Text('-', style: TextStyle(fontSize: 11, color: provider.selected == option ? AppTheme.accentTextColor: AppTheme.textColor)),
                    Text(option.simplifiedPort(), style: TextStyle(fontSize: 11, color: provider.selected == option ? AppTheme.accentTextColor: AppTheme.textColor)),
                  ],
                )
              ],
            ),
            onPressed:() => provider.select( option )
          ).padding(vertical: 0),
          if ( provider.selected != option ) IconButton(icon: Icon(FluentIcons.chrome_close, size: 10, color: AppTheme.accentTextColor), onPressed: () => provider.remove( option ))
        ],
      ),
    ).backgroundColor(AppTheme.buttonBgColor).border(left: 2, top: 2, color: Colors.red);
  }
}
