import '../Constants/exports.dart';

Widget myListTile({
  required String label,
  required String img,
  required void Function() onTap,
}) {
  return ListTile(
    splashColor: secondaryColor,
    dense: true,
    leading: Image.asset(img, height: 30, color: secondaryColor),
    title: Text(label, style: normalLightText),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultCardRadius)),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
    onTap: onTap,
  );
}
