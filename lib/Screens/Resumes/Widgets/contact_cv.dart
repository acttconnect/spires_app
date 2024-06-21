import '../../../Constants/exports.dart';

class ContactCV extends StatelessWidget {
  ContactCV({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: '$imgPath/${c.profileImg}',
          height: size.height * 0.2,
          width: size.width * 0.4,
          fit: BoxFit.cover,
        ),
        buildTitle('contact', largeWhiteText),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(mailIcon, height: 15),
                  const SizedBox(width: 8),
                  Text('Email : ', style: smallWhiteText)
                ],
              ),
              const SizedBox(height: 4),
              Text(MyController.userEmail,
                  style: smallWhiteText, softWrap: true),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(callIcon, height: 15),
                  const SizedBox(width: 8),
                  Text('Mobile : ', style: smallWhiteText)
                ],
              ),
              const SizedBox(height: 4),
              Text(MyController.userPhone,
                  style: smallWhiteText, softWrap: true),
            ],
          ),
        ),
      ],
    );
  }
}

buildTitle(String label, TextStyle style) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          color: primaryColor,
          height: 2,
          width: 35,
        ),
        const SizedBox(width: 8),
        Text(label.toUpperCase(), style: style)
      ],
    ),
  );
}
