import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/directions/direction-selector.provider.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class DirectionSelector extends StatelessWidget {
  final AddressesProvider addressesProvider;

  const DirectionSelector({Key? key, required this.addressesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Seleccionar dirección', style: TextStyle(fontSize: 19, color: AppTheme.accentTextColor)),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => DirectionSelectorProvider(addressesProvider),
          child: Consumer<DirectionSelectorProvider>(
            builder: (ctx, provider, child) => Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    RawKeyboardListener(
                        focusNode: FocusNode(),
                        child: TextBox(
                          style: TextStyle(color: AppTheme.accentTextColor),
                          cursorColor: AppTheme.accentTextColor,
                          decoration: WidgetStatePropertyAll(BoxDecoration(
                              color: AppTheme.buttonBgColor
                          )),
                          autofocus: true,
                          onChanged: (query) => provider.setQuery(query),
                          onSubmitted: (str) {
                            String? address = provider.submitData();
                            if (address != null) {
                              addressesProvider.use(address);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      onKey: (event)  {
                          if ( event.runtimeType == RawKeyDownEvent ) {
                            provider.pressedKeyOnSearch(event.data.logicalKey.keyLabel, event.data.logicalKey.keyId);
                          }
                      },
                    ),
                    ...provider.elements.map((e) => ListTile.selectable(
                      title: Text(e),
                      selected: e == provider.preselectedElement,
                      onPressed: () {
                        addressesProvider.use(e);
                        Navigator.pop(context);
                      },
                    )).toList()
                  ],
                ).expanded()
              ],
            ),
          ),
        ),
      ),
      actions: [
        FilledButton(
          child: const Text('Cerrar'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  static Future<String?> asDialog(BuildContext context, AddressesProvider provider) {
    return showDialog<String?>(
        context: context,
        builder: (ctx) => DirectionSelector(addressesProvider: provider)
    );
  }
}
