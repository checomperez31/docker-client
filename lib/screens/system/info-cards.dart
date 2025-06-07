import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/screens/system/info-cards-provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class InfoCards extends StatelessWidget {
  const InfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
      builder: (actx, addressProvider, child) => ChangeNotifierProvider(
        create: (_) => InfoCardsProvider(addressProvider),
        child: Consumer<InfoCardsProvider>(
            builder: (context, provider, child) => provider.info != null ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  backgroundColor: const Color(0xFF1F48B6),
                  child: SizedBox(
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Contenedores', style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0x41FFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                              child: const Icon(FluentIcons.file_system, color: Colors.white, size: 15),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${provider.info!.containers}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Text('${provider.info!.images}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)).padding(bottom: 3),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${provider.info!.containersRunning}'),
                            Text('${provider.info!.containersPaused}'),
                            Text('${provider.info!.containersStopped}'),
                          ],
                        )
                      ],
                    ),
                  )
                ).expanded(),
                const SizedBox(width: 15),
                Card(
                  backgroundColor: Color(0xFF0B835E),
                  child: SizedBox(
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Recursos', style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0x41FFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                              child: const Icon(FluentIcons.chart_series, color: Colors.white, size: 15),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${provider.info!.cores}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            const Text('cores', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)).padding(bottom: 3),
                          ],
                        ),
                        Text('${provider.info!.calculatedMemory()}'),
                      ],
                    ),
                  )
                ).expanded(),
                const SizedBox(width: 15),
                Card(
                  backgroundColor: const Color(0xFF5E28B6),
                  child: SizedBox(
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Sistema', style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0x41FFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                              child: const Icon(FluentIcons.system, color: Colors.white, size: 15),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${provider.info!.osType}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Text('${provider.info!.architecture}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)).padding(bottom: 3),
                          ],
                        ),
                        Text('${provider.info!.os}'),
                      ],
                    ),
                  )
                ).expanded()
              ],
            ): Container()
        ),
      ),
    );
  }
}
