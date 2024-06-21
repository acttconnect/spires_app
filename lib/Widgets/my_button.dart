import '../Constants/exports.dart';

Widget myButton({
  required void Function() onPressed,
  required String label,
  required Color color,
  required TextStyle style,
}) {
  return SizedBox(
    height: 30,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: style,
      ),
    ),
  );
}
