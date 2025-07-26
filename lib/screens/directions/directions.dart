import 'package:docker_client/models/address.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-button.dart';
import 'package:docker_client/widgets/custom-card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import 'direction-form.dart';

class Directions extends StatelessWidget {
  const Directions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  CustomCard(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Listado de direcciones', style: TextStyle(color: AppTheme.accentTextColor, fontWeight: FontWeight.bold),),
                                CustomButton(
                                  child: Icon(Icons.terminal_sharp, size: 17),
                                  onPressed: () async {
                                    provider.test();
                                  }
                                ),
                                CustomButton(
                                  child: Icon(Icons.add, size: 17),
                                  onPressed: () async {
                                    Address? data = await DirectionForm.asDialog(context, null);
                                    provider.add( data );
                                  }
                                ),
                              ],
                            ).padding(vertical: 5),
                            ListView.builder(
                              itemCount: provider.addresses.length,
                              itemBuilder: (_, index) => ListTile(
                                title: Text('${provider.addresses[index].name ?? ''} ${provider.addresses[index].ip ?? ''}'),
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
                                      message: 'Editar',
                                      child: IconButton(
                                        onPressed: () async {
                                          Address? data = await DirectionForm.asDialog(context, provider.addresses[index]);
                                          provider.edit( index, data );
                                        },
                                        icon: const Icon(FluentIcons.pencil_reply),
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Eliminar direccion',
                                      child: IconButton(
                                        onPressed: () {
                                          provider.delete( index );
                                        },
                                        icon: const Icon(FluentIcons.delete),
                                      ),
                                    )
                                  ],
                                ): null,
                              ),
                            ).expanded()
                          ],
                        ).expanded()
                      ],
                    )
                  ).expanded()
                ],
              ).expanded(),
            ],
          ),
        )
    );
  }
}
