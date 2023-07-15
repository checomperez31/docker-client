import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/directions/direction-selector.dart';

class HomeHeader extends StatelessWidget {
  final String option;
  const HomeHeader({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<AddressesProvider>(
      builder: (context, provider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(option, style: TextStyle(color: AppTheme.accentTextColor, fontWeight: FontWeight.bold),),
          TextButton(child: Text(provider.usedAddress ?? 'Seleccionar direccion', style: TextStyle(color: AppTheme.accentTextColor)), onPressed: () => DirectionSelector.asDialog(context, provider)),
        ],
      )
  );
}
