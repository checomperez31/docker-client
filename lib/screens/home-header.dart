import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/directions/direction-selector.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeHeader extends StatelessWidget {
  final String option;
  const HomeHeader({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<AddressesProvider>(
      builder: (context, provider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff1F51C1)
                ),
                child: const Icon(FluentIcons.server_enviroment, color: Colors.white, size: 19),
              ),
              const SizedBox(width: 8),
              Text('Docker Manager', style: TextStyle(color: AppTheme.accentTextColor, fontWeight: FontWeight.bold, fontSize: 17),),
            ],
          ),
          Button(child: Text(provider.usedAddress ?? 'Seleccionar direccion', style: TextStyle(color: AppTheme.accentTextColor)), onPressed: () => DirectionSelector.asDialog(context, provider)),
        ],
      )
  );
}
