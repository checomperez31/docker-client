import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import 'direction-form.dart';

class Directions extends StatelessWidget {
  const Directions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Listado de direcciones', style: TextStyle(color: AppTheme.accentTextColor, fontWeight: FontWeight.bold),),
                      Button(onPressed: () async {
                        String? data = await DirectionForm.asDialog(context);
                        provider.add( data );
                      }, child: const Text('Agregar'))
                    ],
                  ).padding(vertical: 5),
                  ListView.builder(
                    itemCount: provider.addresses.length,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(provider.addresses[index]),
                      trailing: provider.addresses[index] != provider.usedAddress ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Tooltip(
                            message: 'Usar direccion',
                            child: IconButton(
                              onPressed: () {
                                provider.use( provider.addresses[index] );
                              },
                              icon: const Icon(FluentIcons.device_run),
                            ),
                          ),
                          Tooltip(
                            message: 'Eliminar direccion',
                            child: IconButton(
                              onPressed: () {
                                provider.delete( provider.addresses[index] );
                              },
                              icon: const Icon(FluentIcons.delete),
                            ),
                          )
                        ],
                      ): null,
                    ),
                  ).expanded()
                ],
              ).expanded(),
            ],
          ),
        )
    );
  }
}
