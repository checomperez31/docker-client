import 'package:docker_client/providers/addresses_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

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
                          const Text('Listado de direcciones'),
                          Button(onPressed: () async {
                            String? data = await showAddAddress(context);
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
                                          Text(e),
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


  Future<String?> showAddAddress(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    final result = showDialog<String?>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('Agregar direccion', style: TextStyle(fontSize: 20)),
        content: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextBox(
                    controller: controller,
                  )
                ],
              )
            )
          ],
        ),
        actions: [
          Button(
            child: const Text('Agregar'),
            onPressed: () {
              Navigator.pop(context, controller.text);
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, null),
          ),
        ],
      )
    );
    return result;
  }
}