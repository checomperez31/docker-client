import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/details/container-details-header.dart';
import 'package:docker_client/screens/container/details/container-details-provider.dart';
import 'package:docker_client/screens/container/details/container-logs.dart';
import 'package:docker_client/screens/container/details/container-overview.dart';
import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-tabbar.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerDetails extends StatelessWidget {

  const ContainerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (ctx, addressesProvider, addressChild) => Consumer<ContainersProvider>(
            builder: (cpctx, provider, child) => ChangeNotifierProvider(
              create: (cpctx) => ContainerDetailsProvider(),
              child:  Consumer<ContainerDetailsProvider>(
                  builder: (cdpctx, cdpprovider, cdpchild) {
                    return  Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            const ContainerDetailsHeader(),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 5),
                              child: CustomTabbar(
                                tabs: [
                                  CustomTab(
                                      text: Text('Detalles'),
                                      icon: Icon(FluentIcons.charticulator_line),
                                      child: ContainerOverview()
                                  ),
                                  CustomTab(
                                      text: Text('Logs'),
                                      icon: Icon(FluentIcons.code),
                                      child: const ContainerLogs()
                                  )
                                ],
                              ),
                            ).expanded(),
                          ],
                        ).expanded()
                      ],
                    ).backgroundColor(AppTheme.scaffoldColor);
                  }
              ),
            )
        )
    );
  }
}
