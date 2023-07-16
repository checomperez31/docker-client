import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/screens/container/details/container-logs-provider.dart';
import 'package:docker_client/utils/datetime-picker.dart';
import 'package:styled_widget/styled_widget.dart';

class ContainerLogs extends StatelessWidget {
  const ContainerLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressesProvider>(
        builder: (ctx, addressesProvider, addressChild) => Consumer<ContainersProvider>(
            builder: (context, containersProvider, child) => ChangeNotifierProvider(
              create: (_) => ContainerLogsProvider(addressesProvider, containersProvider),
              child: Consumer<ContainerLogsProvider> (
                builder: (__, provider, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 220,
                                  child: DateTimePicker(
                                    initialValue: provider.since,
                                    onChange: (dt) {
                                      provider.since = dt;
                                    },
                                  )
                              ),
                              SizedBox(
                                  width: 220,
                                  child: DateTimePicker(
                                    initialValue: provider.until,
                                    onChange: (dt) {
                                      provider.until = dt;
                                    },
                                  )
                              ),
                              SizedBox(
                                width: 80,
                                child: TextBox(
                                  controller: TextEditingController(text: provider.tail),
                                  onChanged: (txt) {
                                    if (txt.isNotEmpty) {
                                      provider.tail = txt;
                                    } else {
                                      provider.tail = '50';
                                    }
                                  },
                                  onSubmitted: (string) => provider.logs(),
                                ),
                              ),
                              Button(onPressed: () => provider.logs(), child: const Icon(FluentIcons.sync))
                            ],
                          ),
                          SingleChildScrollView(
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
                          ).backgroundColor(Colors.grey).expanded()
                        ],
                      ).expanded()
                    ],
                  );
                },
              ),
            )
        )
    );
  }
}
