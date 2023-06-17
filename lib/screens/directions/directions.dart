import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/theme.dart';
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
                          Text('Listado de direcciones', style: TextStyle(color: AppTheme.accentTextColor, fontWeight: FontWeight.bold),),
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


  Future<String?> showAddAddress(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final result = showDialog<String?>(
      context: context,
      builder: (ctx) => Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: ContentDialog(
          title: Text('Agregar direccion', style: TextStyle(fontSize: 20, color: AppTheme.accentTextColor)),
          content: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextBox(
                        controller: controller,
                        style: TextStyle(color: AppTheme.accentTextColor),
                        cursorColor: AppTheme.accentTextColor,
                        decoration: BoxDecoration(
                            color: AppTheme.buttonBgColor
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            Navigator.pop(ctx, text);
                          }
                        },
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
                Navigator.pop(ctx, controller.text);
                // Delete file here
              },
            ),
            FilledButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(ctx, null),
            ),
          ],
        )
      )
    );
    return result;
  }
}
