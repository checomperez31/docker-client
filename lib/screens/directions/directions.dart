import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

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
              Expanded(
                  child: Column(
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
                      ),
                      ...provider.addresses.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(e, style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textColor),),
                                          if ( e != provider.usedAddress ) Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Button(
                                                onPressed: () {
                                                  provider.use( e );
                                                },
                                                child: const Text('Usar')
                                              ),
                                              Button(
                                                onPressed: () {
                                                  provider.delete( e );
                                                },
                                                child: const Text('Eliminar')
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const Divider()
                                    ],
                                  )
                              )
                            ],
                          ),
                        );
                      }).toList()
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
