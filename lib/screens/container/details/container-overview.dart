import 'package:docker_client/screens/container/details/container-info-card.dart';
import 'package:docker_client/screens/container/details/container-overview-provider.dart' show ContainerOverviewProvider;
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
                  return provider.entity != null ? Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          CustomButton(
                              onPressed: () => provider.updateData(),
                              child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                          ),
                          if ( provider.entity!.state != null ) CustomCard(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tiempo de actividad', style: TextStyle(color: AppTheme.textColor)),
                                    Text(FormatUtils.formatDate(provider.entity!.state!.startedAt!, 'dd/MM/yyyy HH:mm').toString(), style: TextStyle(color: AppTheme.accentTextColor, fontSize: 17, fontWeight: FontWeight.bold)),
                                    Text(provider.entity!.state!.status!.uppercaseFirst(), style: TextStyle(color: AppTheme.textColor))
                                  ],
                                )
                              ],
                            ).padding(all: 10),
                          ),
                          SizedBox(height: 17),
                          Row(
                            children: [
                              ContainerInfoCard(entity: provider.entity!)
                            ],
                          )
                        ],
                      ).expanded()
                    ],
                  ): Placeholder();
                },
              ),
            )
        )
    );
  }
}
