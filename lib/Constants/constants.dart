import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Drawer/programs_screen.dart';
import 'package:spires_app/Widgets/custom_dialog.dart';
import '../Screens/Bottom_nav_tabs/Drawer/help_centre.dart';

const appName = 'Spires Recruit';
const baseUrl = 'https://www.spiresrecruit.com/';
const apiUrl = '${baseUrl}api/';
const imgPath = 'https://spiresrecruit.com/uploads/images';
const defaultPadding = 12.00;
const defaultMargin = 12.00;
const defaultRadius = 6.00;
const defaultCardRadius = 12.00;
const xsmallTextsize = 11.00;
const smallTextsize = 12.00;
const normalTextsize = 14.00;
const mediumTextsize = 16.00;
const largeTextsize = 18.00;
const xLargeTextsize = 22.00;
const iconsize = 16.00;
final borderRadius = BorderRadius.circular(defaultRadius);
const defaultGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryColor,
    secondaryColor,
  ],
);
const customGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryColor,
    darkColor,
    lightColor,
  ],
);
const defaultShadow = [
  BoxShadow(
    offset: Offset(0.1, -1),
    color: Colors.black12,
    spreadRadius: 2,
    blurRadius: 2,
  )
];
const loading = Center(
  child: SizedBox(
    height: 35,
    width: 35,
    child: CircularProgressIndicator(
      strokeWidth: 3,
    ),
  ),
);

final loadShimmer = Container(
  margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
  height: 150,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: borderRadius,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Shimmer.fromColors(
            baseColor: bgColor,
            highlightColor: primaryColor,
            child: Container(
              color: lightColor,
              height: 15,
              width: 100,
            ),
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: bgColor,
            highlightColor: primaryColor,
            child: Container(
              color: lightColor,
              height: 15,
              width: 20,
            ),
          ),
          const SizedBox(width: 16),
          Shimmer.fromColors(
            baseColor: bgColor,
            highlightColor: primaryColor,
            child: Container(
              color: lightColor,
              height: 15,
              width: 20,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Shimmer.fromColors(
        baseColor: bgColor,
        highlightColor: primaryColor,
        child: Container(
          color: lightColor,
          height: 15,
          width: 90,
        ),
      ),
      const SizedBox(height: 8),
      Shimmer.fromColors(
        baseColor: bgColor,
        highlightColor: primaryColor,
        child: Container(
          color: lightColor,
          height: 15,
          width: 80,
        ),
      ),
      const SizedBox(height: 8),
      Shimmer.fromColors(
        baseColor: bgColor,
        highlightColor: primaryColor,
        child: Container(
          color: lightColor,
          height: 15,
          width: 70,
        ),
      ),
      const SizedBox(height: 4),
    ],
  ),
);
profileLoading() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
        baseColor: lightBlackColor,
        highlightColor: whiteColor,
        child: Container(
          color: Colors.grey.shade300,
          height: 10,
          width: 50,
        ),
      ),
      const SizedBox(height: 8),
      Shimmer.fromColors(
        baseColor: lightBlackColor,
        highlightColor: whiteColor,
        child: Container(
          color: Colors.grey.shade300,
          height: 10,
          width: 50,
        ),
      ),
    ],
  );
}

final controller = Get.put(MyController());

shareJobs(int jobId) {
  Share.share(
    'Checkout this job from Spires Recruit\nhttps://spiresrecruit.com/job/$jobId',
    subject: 'App Promotion',
    sharePositionOrigin:
        Rect.fromCircle(center: const Offset(0, 0), radius: 100),
  );
}

shareInternships(int internshipId) {
  Share.share(
      'Checkout this job from Spires Recruit\nhttps://spiresrecruit.com/internship/$internshipId');
}
List<ListTileModel> policyDropdownItems = [
  ListTileModel(
    label: 'Safety Tips',
    image: Icons.health_and_safety,
    onTap: () => launchUrl(Uri.parse('https://spiresrecruit.com/safety')),
  ),
  ListTileModel(
    label: 'Terms & Condition',
    image: Icons.gavel,
    onTap: () => launchUrl(Uri.parse('https://spiresrecruit.com/terms-of-use')),
  ),
  ListTileModel(
    label: 'Privacy Policy',
    image: Icons.policy,
    onTap: () => launchUrl(Uri.parse('https://spiresrecruit.com/privacy-policy')),
  ),
  ListTileModel(
    label: 'Security & Fraud',
    image: Icons.security,
    onTap: () => launchUrl(Uri.parse('https://spiresrecruit.com/security')),
  ),
  ListTileModel(
    label: 'Beware of Fraudster',
    image: Icons.compass_calibration,
    onTap: () => launchUrl(Uri.parse('https://spiresrecruit.com/beware-of-fraudsters')),
  ),
];

List<ListTileModel> myProfileList = [
  ListTileModel(
    label: 'For Internship',
    image: Icons.work_history,
    onTap: () => Get.to(() => const Internship(isDrawer: true),
        transition: Transition.rightToLeftWithFade),
  ),
  ListTileModel(
    label: 'For Jobs',
    image: Icons.business_center,
    onTap: () => Get.to(() => const Jobs(isDrawer: true),
        transition: Transition.rightToLeftWithFade),
  ),
  ListTileModel(
      label: 'Notification',
      image: Icons.notifications,
      onTap: () => Get.to(() => const NotificationScreen(),
          transition: Transition.rightToLeftWithFade)),
  ListTileModel(
      label: 'Programs',
      image: Icons.widgets,
      onTap: () => Get.to(() => const ProgramsScreen(),
          transition: Transition.rightToLeftWithFade)),
  ListTileModel(
      label: 'Help Centre',
      image: Icons.hub,
      onTap: () => Get.to(() => const HelpCentre(),
          transition: Transition.rightToLeftWithFade)),
  ListTileModel(
      label: 'Discover Us',
      image: Icons.diversity_3,
      onTap: () => launchUrl(
        Uri.parse('https://spiresrecruit.com/about-us'),
      )),
  // ExpansionTile for Policy
  ListTileModel(
    label: 'Policies',
    image: Icons.policy,
    onTap: () {}, // No onTap for the parent tile
    isDropdownItem: true,
  ),
  ListTileModel(
      label: 'Update Password',
      image: Icons.update,
      onTap: () => Get.to(() => const UpdatePassword(),
          transition: Transition.rightToLeftWithFade)),
  ListTileModel(
    label: 'Logout',
    image: Icons.logout,
    onTap: () => logoutfn(),
  ),
];

bool isValidToApply() {
  if (controller.progressValue.value >= 70) {
    if (controller.isEmailVerified.value || MyController.veriEmail == '1') {
      if (controller.isPhoneVerified.value || MyController.veriPhone == '1') {
        return true;
      } else {
        return true;
      }
    } else {
      return true;
    }
  } else {
    customDialog(
        title: 'Attention',
        middleText: 'Please update your profile more than 70% to apply');
    Fluttertoast.showToast(
        msg: 'Please update your profile more than 70% to apply');
    return false;
  }
}

logoutfn() {
  Get.defaultDialog(
    radius: defaultRadius,
    title: 'Confirm Logout',
    middleText: 'Are you sure you want to logout?',
    confirmTextColor: whiteColor,
    confirm: myButton(
      onPressed: () => SharedPrefs.logout(),
      label: 'Logout',
      color: primaryColor,
      style: normalWhiteText,
    ),
    cancel: myButton(
      onPressed: () => Get.back(),
      label: 'Cancel',
      color: primaryColor,
      style: normalWhiteText,
    ),
  );
}

cardShimmer(Size size) {
  return Container(
    padding: const EdgeInsets.fromLTRB(defaultPadding * 2, defaultPadding * 2,
        defaultPadding * 2, defaultPadding),
    margin: const EdgeInsets.only(bottom: defaultMargin),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: borderRadius,
    ),
    width: size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Shimmer.fromColors(
          highlightColor: Colors.grey.shade300,
          baseColor: whiteColor,
          child: Container(
            height: 12,
            width: 120,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: borderRadius,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  highlightColor: Colors.grey.shade300,
                  baseColor: whiteColor,
                  child: const MyContainer(
                    height: 12,
                    width: 100,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Shimmer.fromColors(
                  highlightColor: Colors.grey.shade300,
                  baseColor: whiteColor,
                  child: const MyContainer(
                    height: 12,
                    width: 75,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
            Shimmer.fromColors(
              highlightColor: Colors.grey.shade300,
              baseColor: whiteColor,
              child: const MyContainer(
                height: 20,
                width: 40,
                color: whiteColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Image.asset(homeFilled, height: 16),
            const SizedBox(width: 8),
            Shimmer.fromColors(
              highlightColor: Colors.grey.shade300,
              baseColor: whiteColor,
              child: const MyContainer(
                height: 12,
                width: 50,
                color: whiteColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.play_circle, color: primaryColor, size: 16),
            const SizedBox(width: 8),
            Shimmer.fromColors(
              highlightColor: Colors.grey.shade300,
              baseColor: whiteColor,
              child: const MyContainer(
                height: 12,
                width: 50,
                color: whiteColor,
              ),
            ),
            const SizedBox(width: 24),
            const Icon(Icons.calendar_month, color: primaryColor, size: 16),
            const SizedBox(width: 8),
            Shimmer.fromColors(
              highlightColor: Colors.grey.shade300,
              baseColor: whiteColor,
              child: const MyContainer(
                height: 12,
                width: 50,
                color: whiteColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.payments, color: primaryColor, size: 16),
            const SizedBox(width: 8),
            Shimmer.fromColors(
              highlightColor: Colors.grey.shade300,
              baseColor: whiteColor,
              child: const MyContainer(
                height: 12,
                width: 50,
                color: whiteColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          highlightColor: Colors.grey.shade300,
          baseColor: whiteColor,
          child: const MyContainer(
            height: 12,
            width: 50,
            color: whiteColor,
          ),
        ),
        const Divider(
          color: Colors.black26,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
            highlightColor: Colors.grey.shade300,
            baseColor: whiteColor,
            child: const MyContainer(
              height: 12,
              width: 50,
              color: whiteColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Container activelyHiring() {
  return Container(
    padding: const EdgeInsets.symmetric(
        vertical: defaultPadding * 0.4, horizontal: defaultPadding * 0.5),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: primaryColor),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.add_task, size: 16, color: primaryColor),
        const SizedBox(width: 8),
        Text('Actively hiring', style: smallText),
      ],
    ),
  );
}
