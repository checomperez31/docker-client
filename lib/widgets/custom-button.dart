import 'package:fluent_ui/fluent_ui.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Widget child;

  const CustomButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Button(onPressed: onPressed, child: child),
    );
  }
}
