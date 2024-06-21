import '../Constants/exports.dart';

class BuildTitle extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const BuildTitle({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      child: Row(
        children: [
          Text(title, style: normalText),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: Text('View All', style: smallLightText),
          ),
        ],
      ),
    );
  }
}
