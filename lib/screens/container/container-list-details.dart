import 'package:docker_client/models/container_item.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListDetails extends StatelessWidget {
  final ContainerItem entity;
  const ContainerListDetails({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...entity.names!.map((e) {
                  String res = e;
                  if ( e.startsWith('/') ) res = e.substring(1);
                  return Text(res, style: const TextStyle(fontWeight: FontWeight.bold));
                }).toList(),
                if ( entity.image != null ) Text(entity.image!, style: const TextStyle(
                    fontSize: 12, color: Color(0xFF777777))
                )
              ],
            )
          )
        ],
      )
    );
  }
}
