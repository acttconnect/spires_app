import '../Constants/exports.dart';

class ListTileModel {
  final String label;
  final IconData image;
  final void Function() onTap;
  final bool isDropdownItem;



  ListTileModel(
      {required this.label, required this.image, required this.onTap, this.isDropdownItem = false});
}
