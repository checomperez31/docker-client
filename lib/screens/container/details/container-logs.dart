import 'package:docker_client/theme.dart';
import 'package:docker_client/widgets/custom-button.dart';
import 'package:docker_client/widgets/custom-card.dart';
import 'package:docker_client/widgets/custom-input.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/details/container-logs-provider.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerLogs extends StatelessWidget {
  const ContainerLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (ctx, addressesProvider, addressChild) => Consumer<ContainersProvider>(
            builder: (context, containersProvider, child) => ChangeNotifierProvider(
              create: (_) => ContainerLogsProvider( containersProvider ),
              child: Consumer<ContainerLogsProvider> (
                builder: (__, provider, child) {
                  return CustomCard(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Checkbox(
                                  content: Text('Timestamps'),
                                  checked: provider.timestamps,
                                  onChanged: (bool? value) => provider.timestamps = value ?? false,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                    width: 180,
                                    height: 40,
                                    child: CustomInput(
                                      controller: TextEditingController(text: provider.tail),
                                      keyboardType: TextInputType.number,
                                      onChanged: (txt) {
                                        if (txt.isNotEmpty) {
                                          try {
                                            int.parse(txt);
                                            provider.tail = txt;
                                          } catch(e) {
                                            provider.tail = '50';
                                          }
                                        } else {
                                          provider.tail = '50';
                                        }
                                      },
                                      onFieldSubmitted: (string) => provider.logs(),
                                    )
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                    onPressed: () => provider.logs(),
                                    child: provider.loading ? const SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)):const Icon(FluentIcons.sync)
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(color: Color(0xff1F2937), width: 1),
                                  color: Color(0xff191B27)
                              ),
                              child: SingleChildScrollView(
                                controller: provider.scroll,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: provider.logList.map((e) => SelectableText.rich(TextSpan(
                                          mouseCursor: MouseCursor.defer,
                                          children: [
                                            if ( e.timestamp != null ) TextSpan(text: e.timestamp!, style: const TextStyle(color: Color(0xff3ceae3))),
                                            if ( e.log != null ) TextSpan(text: e.log!, style: const TextStyle(color: Colors.white)),
                                          ]
                                      ))).toList(),
                                    ).expanded()
                                  ],
                                ),
                              ),
                            ).expanded()
                          ],
                        ).expanded()
                      ],
                    ),
                  );
                },
              ),
            )
        )
    );
  }
}
