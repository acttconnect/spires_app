import 'package:spires_app/Screens/Bottom_nav_tabs/Home/companies.dart';

import '../../../Constants/exports.dart';

class FindYourJob extends StatelessWidget {
  FindYourJob({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              "Find Your Need",
              style: mediumBoldText,
            ),
          ),
          Row(
            children: [
              internship(size),
              const SizedBox(width: defaultPadding),
              Column(
                children: [
                  fullTime(size),
                  const SizedBox(height: defaultPadding),
                  allJobs(size),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget internship(Size size) {
    return InkWell(
      onTap: () =>
          Get.to(() => const Internship(allInternship: true, isDrawer: true)),
      child: Container(
        height: size.height * 0.16,
        width: size.width / 2 - defaultPadding * 2,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 104, 190, 230),
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                c.allInternship.value.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: largeWhiteText,
              ),
            ),
            Text(
              "All Internships",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: normalWhiteText,
            ),
          ],
        ),
      ),
    );
  }

  Widget fullTime(Size size) {
    return InkWell(
      onTap: () => Get.to(() => const Companies()),
      child: Container(
        height: size.height * 0.08 - (defaultPadding * 0.5),
        width: size.width / 2 - defaultPadding,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "20+",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: largeWhiteText,
            ),
            Text(
              "Trusted Companies",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: normalWhiteText,
            ),
          ],
        ),
      ),
    );
  }

  InkWell allJobs(Size size) {
    return InkWell(
      onTap: () => Get.to(() => const Jobs(showAll: true, isDrawer: true)),
      child: Container(
        height: size.height * 0.08 - (defaultPadding * 0.5),
        width: size.width / 2 - defaultPadding,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                c.allJob.value.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: largeWhiteText,
              ),
            ),
            Text(
              "All Jobs",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: normalWhiteText,
            ),
          ],
        ),
      ),
    );
  }
}
