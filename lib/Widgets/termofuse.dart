import '../Constants/exports.dart';

class TermOfUse extends StatelessWidget {
  const TermOfUse({super.key});

  final TextStyle defaultStyle =
      const TextStyle(color: lightBlackColor, fontSize: smallTextsize);
  final TextStyle linkStyle = const TextStyle(
    color: secondaryColor,
    fontSize: smallTextsize,
  );

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: 'I agree to the '),
          TextSpan(
            text: 'Terms of Use',
            style: linkStyle,
          ),
          TextSpan(text: ' & '),
          TextSpan(
            text: 'Privacy Policy',
            style: linkStyle,
          ),
        ],
      ),
    );
  }
}
