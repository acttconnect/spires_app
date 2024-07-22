import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/program_detail_test.dart';
import '../../../Constants/exports.dart';
import '../../../Utils/share_utils.dart';
import '../../Resumes/cv_two.dart';
import 'help_centre.dart';

class MyDrawer extends StatefulWidget {
  final Size size;

  const MyDrawer({super.key, required this.size});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  File? image;

  pickImageFrom(ImageSource source) async {
    XFile? pickedImg = await ImagePicker().pickImage(source: source);
    if (pickedImg != null) {
      image = File(pickedImg.path);
      Get.back();
      ProfileUtils.updateDP(imagePath: image!.path);
    } else {
      Fluttertoast.showToast(msg: 'No Files selected');
    }
  }

  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => Profile()),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  height: 100,
                  width: widget.size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(profileBanner), fit: BoxFit.cover),
                      color: bannerBgColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            profilePic(),
                            if (c.isSubscribed.value ||
                                MyController.subscribed == '1')
                              myButton(
                                onPressed: () => Get.to(() => ResumeScreen()),
                                label: 'Build Instant CV',
                                color: Colors.white12,
                                style: smallWhiteText,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: widget.size.width * 0.04),
                      Expanded(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${MyController.userFirstName} ${MyController.userLastName}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                  if (c.isSubscribed.value ||
                                      MyController.subscribed == '1')
                                    const Icon(
                                      Icons.workspace_premium,
                                      color: whiteColor,
                                    ),
                                ],
                              ),
                              Text(
                                MyController.userEmail,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: whiteColor,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              Text(
                                MyController.userPhone,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: whiteColor,
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // IconButton(
                      //   padding: const EdgeInsets.symmetric(vertical: 20),
                      //   onPressed: () => logoutfn(),
                      //   icon: const Icon(Icons.logout,
                      //       size: 25, color: whiteColor),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const Divider(),
              // SizedBox(
              //   height: 75,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       buildItem('Applications', Icons.widgets,
              //           () => Get.to(() => const AppliedData())),
              //       buildItem('Saved', Icons.beenhere,
              //           () => Get.to(() => const SavedData())),
              //       buildItem('Preference', Icons.tune,
              //           () => Get.to(() => Preferences(),
              //           ),
              //        ),
              //     ],
              //   ),
              // ),
              // const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () => Get.to(() => Profile()),
                      leading: const Icon(
                        CupertinoIcons.person_fill,
                        color: primaryColor,
                        size: 20,
                      ),
                      title: Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.to(
                          () => ProgramDetailTest(
                                imageUrl: 'assets/icons/1.png',
                                title: 'SkillUp 1.0',
                                description:
                                    'Description:SkillUp 1.0 is your comprehensive training program designed to equip you with the essential skills and knowledge needed to land your dream internship or entry-level job. Through interactive modules, practical exercises, and industry expert insights, you\'ll gain the confidence and competence to impress employers.',
                                benefits:
                                    "• Gain valuable skills through interactive modules & practical exercises.\n• Build confidence with mock interviews, interview tips, & resume workshops.\n• Connect with industry professionals & gain insights into your dream career.\n• Get access to exclusive internship listings with top companies.\n• Receive personalized guidance & support from our career coaches.",
                                faqs: const [
                                  {
                                    'question': 'Is SkillUp 1.0 free?',
                                    'answer':
                                        'Yes, SkillUp 1.0 is completely free to access for all Spires Recruit users.'
                                  },
                                  {
                                    'question':
                                        'What skills can I learn through SkillUp 1.0?',
                                    'answer':
                                        'SkillUp 1.0 offers a variety of modules covering in-demand skills such as communication, problem-solving, teamwork, digital marketing, social media marketing, data analysis, and more.'
                                  },
                                  {
                                    'question':
                                        'How do I get access to exclusive internship listings?',
                                    'answer':
                                        'By completing relevant SkillUp 1.0 modules and demonstrating your skills, you\'ll gain access to a curated list of internship opportunities from top companies.'
                                  },
                                  {
                                    'question':
                                        'Will I receive a certificate upon completion?',
                                    'answer':
                                        'Yes, upon successful completion of a SkillUp 1.0 learning path, you\'ll receive a digital certificate to showcase your acquired skills to potential employers.'
                                  },
                                ],
                                howItWorks:
                                    '1. Download the Spires Recruit app / website & create a free account.\n2. Select a learning path based on your career interests & desired skills.\n3. Work through interactive modules at your own pace, anytime, anywhere.\n4. Sharpen your skills with mock interviews & resume feedback.\n5. Network with companies and apply for exclusive internship opportunities.',
                              ),
                          transition: Transition.rightToLeftWithFade),
                      leading: Image.asset(
                        'assets/icons/skills.png',
                        color: primaryColor,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        'Skill Up 1.0',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.to(
                          () => ProgramDetailTest(
                                imageUrl: 'assets/icons/3.png',
                                title: 'Resume Workshop',
                                description:
                                    'Master the art of resume writing with our interactive Resume Workshop! Get expert guidance on building a compelling resume that stands out to hiring managers and lands you interviews.',
                                benefits:
                                    '• Learn proven resume writing strategies.\n• Optimize your resume for Applicant Tracking Systems (ATS).\n• Tailor your resume for specific job applications.\n• Gain confidence in your resume writing skills.\n• Get feedback from career experts.\n• Network with other job seekers.',
                                faqs: const [
                                  {
                                    'question': 'Is the Resume Workshop free?',
                                    'answer':
                                        'Yes, the Spires Recruit Resume Workshop is completely free to attend!'
                                  },
                                  {
                                    'question':
                                        'Who should attend the Resume Workshop?',
                                    'answer':
                                        'This workshop is beneficial for anyone seeking to improve their resume writing skills, from recent graduates to experienced professionals looking to make a career change.'
                                  },
                                  {
                                    'question':
                                        'What will I learn in the workshop?',
                                    'answer':
                                        'The workshop will cover a variety of topics, including resume structure, formatting, keyword optimization, crafting impactful achievements statements, and tailoring your resume for specific job applications.'
                                  },
                                  {
                                    'question':
                                        'How do I register for the workshop?',
                                    'answer':
                                        'Download the Spires Recruit app or visit our website (link) to find upcoming workshop dates and register.'
                                  },
                                ],
                                howItWorks:
                                    '• Sign up for the free workshop through the Spires Recruit app / website.\n• Join our live, interactive workshop led by career development professionals.\n• Engage in interactive exercises and discussions to learn resume best practices.\n• Have the opportunity to receive personalized feedback on your resume during the workshop or through follow-up resources.',
                              ),
                          transition: Transition.rightToLeftWithFade),
                      leading: Image.asset(
                        'assets/icons/curriculum-vitae.png',
                        color: primaryColor,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        'Resume Builder',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.to(
                          () => ProgramDetailTest(
                                imageUrl: 'assets/icons/4.png',
                                title: 'Interview Preparation',
                                description:
                                    'Prepare for your next job interview with our Interview Preparation program! Learn how to answer common interview questions, showcase your skills and experience, and make a positive impression on potential employers.',
                                benefits:
                                    '• Learn how to answer common interview questions.\n• Practice your responses to behavioral interview questions.\n• Develop strategies for showcasing your skills and experience.\n• Gain confidence in your ability to communicate effectively during interviews.\n• Receive feedback on your interview performance.\n• Network with other job seekers.',
                                faqs: const [
                                  {
                                    'question':
                                        'Is the Interview Preparation program free?',
                                    'answer':
                                        'Yes, the Spires Recruit Interview Preparation program is completely free to attend!'
                                  },
                                  {
                                    'question':
                                        'Who should attend the Interview Preparation program?',
                                    'answer':
                                        'This program is beneficial for anyone preparing for job interviews, from recent graduates to experienced professionals looking to improve their interview skills.'
                                  },
                                  {
                                    'question':
                                        'What will I learn in the program?',
                                    'answer':
                                        'The program will cover a variety of topics, including common interview questions, behavioral interview techniques, and strategies for showcasing your skills and experience.'
                                  },
                                  {
                                    'question':
                                        'How do I register for the program?',
                                    'answer':
                                        'Download the Spires Recruit app or visit our website (link) to find upcoming program dates and register.'
                                  },
                                ],
                                howItWorks:
                                    '• Sign up for the free program through the Spires Recruit app / website.\n• Join our live, interactive program led by career development professionals.\n• Engage in mock interviews and practice answering common interview questions.\n• Receive feedback on your interview performance and tips for improvement.\n• Have the opportunity to network with other job seekers and share best practices.',
                              ),
                          transition: Transition.rightToLeftWithFade),
                      leading: Image.asset(
                        'assets/icons/question.png',
                        color: primaryColor,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        'Interview Preparation',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.to(
                          () => ProgramDetailTest(
                                imageUrl: 'assets/icons/jsdh.png',
                                title: 'Coding Clubs',
                                description:
                                    'The Spires Recruit Coding Club is a community for developers who are passionate about building and improving the Spires Recruit platform. We welcome coders of all experience levels, from beginners to seasoned professionals.',
                                benefits:
                                    '• Work on real-world projects that utilize various coding skills and technologies.\n• Approach challenges creatively and find innovative solutions.\n• Get guidance and feedback from industry professionals.\n• Showcase your coding projects to potential employers.\n• Connect with other programmers who share your passion for coding.',
                                faqs: const [
                                  {
                                    'question':
                                        'Is there a cost to join the Spires Recruit Coding Club?',
                                    'answer':
                                        'No, the Spires Recruit Coding Club is completely free to join and participate in.'
                                  },
                                  {
                                    'question':
                                        'What coding experience level is required?',
                                    'answer':
                                        'The Spires Recruit Coding Club welcomes coders of all skill levels, from beginners to experienced programmers.'
                                  },
                                  {
                                    'question':
                                        'What programming languages are covered in the club?',
                                    'answer':
                                        'The Spires Recruit Coding Club covers a variety of popular programming languages, with the specific languages addressed depending on member interests and industry trends.'
                                  },
                                  {
                                    'question':
                                        'How do I find out about upcoming workshops and events?',
                                    'answer':
                                        'Announcements for upcoming workshops, challenges, and events will be posted within the Spires Recruit Coding Club forum and communicated through the Spires Recruit app.'
                                  },
                                ],
                                howItWorks:
                                    '• Sign up for the Spires Recruit Coding Club through the Spires Recruit app / website.\n• Participate in weekly coding challenges designed to test and enhance your skills.\n• Attend regular online workshops and Q&A sessions hosted by industry experts.\n• Join discussions, share solutions, and get help from fellow club members.\n• Connect with other coders through the forum and participate in virtual coding meetups.',
                              ),
                          transition: Transition.rightToLeftWithFade),
                      leading: Image.asset(
                        'assets/icons/coding.png',
                        color: primaryColor,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        'Coding Clubs',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.to(() => const HelpCentre(),
                          transition: Transition.rightToLeftWithFade),
                      leading: const Icon(
                        Icons.hub,
                        color: primaryColor,
                        size: 20,
                      ),
                      title: Text(
                        'Help Center',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.to(() => const UpdatePassword(),
                          transition: Transition.rightToLeftWithFade),
                      leading: const Icon(Icons.update, color: primaryColor),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => openPrivacyPolicy(),
                      leading: const Icon(Icons.update, color: primaryColor),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => openRefundPolicy(),
                      leading: const Icon(Icons.update, color: primaryColor),
                      title: Text(
                        'Refund Policy',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => openTermOfUse(),
                      leading: const Icon(Icons.update, color: primaryColor),
                      title: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => ShareUtils.shareAppLink(context,
                          'https://play.google.com/store/apps/details?id=com.atc.spires_app&hl=en-IN'),
                      leading: const Icon(
                        Icons.share,
                        color: primaryColor,
                        size: 20,
                      ),
                      title: Text(
                        'Share App',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => logoutfn(),
                      leading: const Icon(
                        Icons.logout,
                        color: primaryColor,
                        size: 20,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: ListView.builder(
              //       itemCount: myProfileList.length,
              //       physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         if (myProfileList[index].label == 'Policies') {
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 0),
              //             child: Theme(
              //               data: ThemeData(
              //                 dividerColor: whiteColor,
              //                 hintColor: primaryColor,
              //               ),
              //               child: ExpansionTile(
              //                 title: Text(
              //                   myProfileList[index].label,
              //                   style: TextStyle(
              //                     fontSize: 16,
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontFamily: fontFamily,
              //                   ),
              //                 ),
              //                 childrenPadding: const EdgeInsets.only(left: 20),
              //                 collapsedIconColor: Colors.grey,
              //                 iconColor: primaryColor,
              //                 leading: Icon(
              //                   myProfileList[index].image,
              //                   color: primaryColor,
              //                 ),
              //                 children: policyDropdownItems.map((item) {
              //                   return ListTile(
              //                     dense: true,
              //                     title: Text(item.label, style: normalText),
              //                     leading:
              //                         Icon(item.image, color: primaryColor),
              //                     onTap: item.onTap,
              //                   );
              //                 }).toList(),
              //               ),
              //             ),
              //           );
              //         } else {
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 3),
              //             child: buildTile(
              //               onTap: myProfileList[index].onTap,
              //               title: myProfileList[index].label,
              //               iconData: myProfileList[index].image,
              //             ),
              //           );
              //         }
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '$appName\nUnit of Act T Connect (P) Ltd.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(String title, IconData iconData, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: primaryColor,
            child: Icon(
              iconData,
              color: whiteColor,
            ),
          ),
          const SizedBox(height: 3),
          Text(title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontFamily: fontFamily,
              )),
        ],
      ),
    );
  }

  ListTile buildTile(
      {required void Function() onTap,
      required IconData iconData,
      required String title}) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      dense: true,
      tileColor: whiteColor,
      leading: Icon(
        iconData,
        color: primaryColor,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  profilePic() {
    return Obx(() => c.isDpLoading.value
        ? loadingProfileDP()
        : c.profileImg.value == ''
            ? Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Obx(
                      () => c.isDpLoading.value
                          ? loadingProfileDP()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset(
                                profileImage,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => showImagePickerDialog(),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: primaryColor,
                        child: Icon(Icons.edit, size: 18, color: whiteColor),
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Obx(
                      () => c.isDpLoading.value
                          ? loadingProfileDP()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: CachedNetworkImage(
                                imageUrl: c.profileImg.value.isURL
                                    ? c.profileImg.value
                                    : '$imgPath/${c.profileImg.value}',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => showImagePickerDialog(),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: primaryColor,
                        child: Icon(Icons.edit, size: 14, color: whiteColor),
                      ),
                    ),
                  ),
                ],
              ));
  }

  loadingProfileDP() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(image!),
          opacity: 0.3,
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  showImagePickerDialog() {
    return Get.defaultDialog(
      radius: 4,
      title: 'Choose Source',
      titleStyle: mediumBoldText,
      content: Column(
        children: [
          ListTile(
            dense: true,
            onTap: () => pickImageFrom(ImageSource.camera),
            title: Text('Camera', style: normalText),
            leading: const Icon(
              Icons.add_a_photo,
              color: primaryColor,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () => pickImageFrom(ImageSource.gallery),
            title: Text('Gallery', style: normalText),
            leading: const Icon(
              Icons.image,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> openRefundPolicy() async {
  final Uri url = Uri.parse('https://spiresrecruit.com/refund-policy');
  if (!await canLaunchUrl(url)) {
    throw Exception('Could not launch $url');
  } else {
    await launchUrl(url);
  }
}

Future<void> openTermOfUse() async {
  final Uri url = Uri.parse('https://spiresrecruit.com/terms-of-use');
  if (!await canLaunchUrl(url)) {
    throw Exception('Could not launch $url');
  } else {
    await launchUrl(url);
  }
}

Future<void> openPrivacyPolicy() async {
  final Uri url = Uri.parse('https://spiresrecruit.com/privacy-policy');
  if (!await canLaunchUrl(url)) {
    throw Exception('Could not launch $url');
  } else {
    await launchUrl(url);
  }
}
