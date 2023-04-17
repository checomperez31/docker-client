import 'package:docker_client/models/container_item.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListDetails extends StatelessWidget {
  final ContainerItem entity;
  const ContainerListDetails({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name(s): ', style: TextStyle(fontWeight: FontWeight.bold)),
              if ( entity.names != null ) Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: entity.names!.map((e) {
                    String res = e;
                    if ( e.startsWith('/') ) res = e.substring(1);
                    return Text( res );
                  }).toList(),
                ),
              ),
              if ( entity.image != null ) Text('Imagen: ${entity.image}', style: const TextStyle(
                  fontSize: 12, color: Color(0xFF777777))
              )
            ]
        )
      ],
    );
  }
}
