import 'package:fluent_ui/fluent_ui.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Widget child;
  final double size;
  final EdgeInsetsGeometry? padding;

  const CustomButton({super.key, this.onPressed, required this.child, this.size = 40, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Button(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: padding != null ? WidgetStatePropertyAll(padding): null
        ),
        child: child,
      ),
    );
  }
}
