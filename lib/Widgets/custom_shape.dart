import 'package:spires_app/Constants/exports.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Start from the bottom-left
    path.lineTo(
        size.width / 2 - 25, size.height - 50); // Move to the center-left
    path.lineTo(size.width / 2, size.height); // Create the triangular cutout
    path.lineTo(
        size.width / 2 + 25, size.height - 50); // Move to the center-right
    path.lineTo(size.width, size.height - 50); // Finish at the bottom-right
    path.lineTo(size.width, 0); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
