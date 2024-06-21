import '../Constants/exports.dart';

class ListTileModel {
  final String label;
  final IconData image;
  final void Function() onTap;

  ListTileModel(
      {required this.label, required this.image, required this.onTap});
}
