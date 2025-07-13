import 'package:docker_client/screens/container/details/overviewcards/container-cpu-card.dart';
import 'package:docker_client/screens/container/details/overviewcards/container-health-card.dart';
import 'package:docker_client/screens/container/details/overviewcards/container-info-card.dart';
import 'package:docker_client/screens/container/details/container-overview-provider.dart' show ContainerOverviewProvider;
import 'package:docker_client/screens/container/details/overviewcards/container-memory-card.dart';
import 'package:docker_client/screens/container/details/overviewcards/container-network-card.dart';
import 'package:docker_client/screens/container/details/overviewcards/container-network-stats-card.dart';
import 'package:docker_client/screens/container/details/overviewcards/container-uptime-card.dart' show ContainerUptimeCard;
import 'package:docker_client/theme.dart';
import 'package:docker_client/utils/format-utils.dart' show FormatUtils;
import 'package:docker_client/widgets/custom-button.dart';
import 'package:docker_client/widgets/custom-card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerOverview extends StatelessWidget {
  const ContainerOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (ctx, addressesProvider, addressChild) => Consumer<ContainersProvider>(
            builder: (context, containersProvider, child) => ChangeNotifierProvider(
              create: (_) => ContainerOverviewProvider( containersProvider ),
              child: Consumer<ContainerOverviewProvider> (
                builder: (__, provider, child) {
                  return provider.entity != null ? SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                    onPressed: () => provider.updateData(),
                                    child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                                )
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                if ( provider.entity!.state != null ) ContainerCpuCard(entity: provider.entity!, stats: provider.entityStats).expanded(),
                                SizedBox(width: 8),
                                if ( provider.entity!.state != null ) ContainerMemoryCard(entity: provider.entity!, stats: provider.entityStats).expanded(),
                                SizedBox(width: 8),
                                if ( provider.entity!.state != null ) ContainerNetworkStatsCard(entity: provider.entity!, stats: provider.entityStats).expanded(),
                                SizedBox(width: 8),
                                if ( provider.entity!.state != null ) ContainerUptimeCard(entity: provider.entity!).expanded(),
                              ],
                            ),
                            SizedBox(height: 17),
                            Row(
                              children: [
                                ContainerInfoCard(entity: provider.entity!).expanded(),
                                SizedBox(width: 8),
                                ContainerNetworkCard(entity: provider.entity!).expanded()
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                ContainerHealthCard(entity: provider.entity!).expanded(),
                              ],
                            ),
                          ],
                        ).expanded()
                      ],
                    ).padding(right: 10),
                  ): Row(
                    children: [
                      Text('Cargando informacion')
                    ],
                  );
                },
              ),
            )
        )
    );
  }
}
