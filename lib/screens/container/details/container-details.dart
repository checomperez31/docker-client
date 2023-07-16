import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/details/container-details-header.dart';
import 'package:docker_client/screens/container/details/container-logs.dart';
import 'package:docker_client/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetails extends StatelessWidget {

  const ContainerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (ctx, addressesProvider, addressChild) => Consumer<ContainersProvider>(
            builder: (context, provider, child) => Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        const ContainerDetailsHeader(),
                        const ContainerLogs().expanded()
                      ],
                    ).expanded()
                  ],
                ).backgroundColor(AppTheme.scaffoldColor)
        )
    );
  }
}
