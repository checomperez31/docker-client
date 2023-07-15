import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final String option;
  const HomeHeader({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<AddressesProvider>(
      builder: (context, provider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$option ${provider.usedAddress ?? ''}'),
          if ( provider.usedAddress != null ) ComboBox(
            popupColor: Colors.red,
            focusColor: Colors.blue,
            iconEnabledColor: Colors.yellow,
            style: TextStyle(color: Colors.purple),

            value: provider.usedAddress,
            items: provider.addresses.map((e) => ComboBoxItem(
                value: e,
                child: Text(e, style: TextStyle(color: AppTheme.accentTextColor))
            )).toList(),
            onChanged: (option) {
              if ( option != null ) {
                provider.use( option );
              }
            },
          ),
        ],
      )
  );
}
