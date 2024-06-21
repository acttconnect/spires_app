import 'package:spires_app/Constants/exports.dart';

customDialog({required String title, required String middleText}) {
  return Get.defaultDialog(
    title: title,
    middleText: middleText,
    textConfirm: 'OK',
    onConfirm: () => Get.back(),
  );
}
