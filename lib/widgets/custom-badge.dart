import 'package:fluent_ui/fluent_ui.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color background;
  final Color textColor;
  final Color? borderColor;

  const CustomBadge({super.key, required this.text, required this.background, this.fontSize = 12, this.textColor = Colors.white, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(fontSize),
          border: borderColor != null ? Border.all(width: 1, color: borderColor!): null
      ),
      padding: EdgeInsets.symmetric(horizontal: fontSize * 0.8, vertical: fontSize * 0.1),
      child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
    );
  }
}
