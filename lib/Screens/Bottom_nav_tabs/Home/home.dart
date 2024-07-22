import 'package:spires_app/Model/logo_model.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Nearby%20Jobs/map_jobs.dart';
import 'package:spires_app/Screens/Resumes/cv_two.dart';
import '../../../Constants/exports.dart';
import '../../../Utils/banner.dart';
import '../Drawer/programs_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final c = Get.put(MyController());
  final c1 = Get.put(NearbyJobController());
  @override
  void initState() {
    super.initState();
    c1.getJobs();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      key: _scaffoldKey,
      drawer: MyDrawer(size: size),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              //physics: const PageScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 55),
                  BannerCarousel(size: size),
                  // FindYourJob(),
                  SizedBox(height: defaultPadding),
                  JobCard(),
                  SizedBox(height: defaultPadding),
                  InternshipCard(),
                  SizedBox(height: defaultPadding),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Programs",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const ProgramsScreen()),
                            child: Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider(
                      items: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child:ProgramCard(
                            imageUrl: 'assets/icons/1.png',
                            title: 'SkillUp 1.0',
                            description:
                            'Description:SkillUp 1.0 is your comprehensive training program designed to equip you with the essential skills and knowledge needed to land your dream internship or entry-level job. Through interactive modules, practical exercises, and industry expert insights, you\'ll gain the confidence and competence to impress employers.',
                            benefits:
                            "• Gain valuable skills through interactive modules & practical exercises.\n• Build confidence with mock interviews, interview tips, & resume workshops.\n• Connect with industry professionals & gain insights into your dream career.\n• Get access to exclusive internship listings with top companies.\n• Receive personalized guidance & support from our career coaches.",
                            onShare: () {
                              // Handle share action
                            },
                            faqs: [
                              {
                                'question': 'Is SkillUp 1.0 free?',
                                'answer': 'Yes, SkillUp 1.0 is completely free to access for all Spires Recruit users.'
                              },
                              {
                                'question': 'What skills can I learn through SkillUp 1.0?',
                                'answer': 'SkillUp 1.0 offers a variety of modules covering in-demand skills such as communication, problem-solving, teamwork, digital marketing, social media marketing, data analysis, and more.'
                              },
                              {
                                'question': 'How do I get access to exclusive internship listings?',
                                'answer': 'By completing relevant SkillUp 1.0 modules and demonstrating your skills, you\'ll gain access to a curated list of internship opportunities from top companies.'
                              },
                              {
                                'question': 'Will I receive a certificate upon completion?',
                                'answer': 'Yes, upon successful completion of a SkillUp 1.0 learning path, you\'ll receive a digital certificate to showcase your acquired skills to potential employers.'
                              },
                            ],
                            howItWorks:
                            '1. Download the Spires Recruit app / website & create a free account.\n2. Select a learning path based on your career interests & desired skills.\n3. Work through interactive modules at your own pace, anytime, anywhere.\n4. Sharpen your skills with mock interviews & resume feedback.\n5. Network with companies and apply for exclusive internship opportunities.',
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child:  ProgramCard(
                            imageUrl: 'assets/icons/3.png',
                            title: 'Resume Workshop',
                            description:
                            'Master the art of resume writing with our interactive Resume Workshop! Get expert guidance on building a compelling resume that stands out to hiring managers and lands you interviews.',
                            benefits: '• Learn proven resume writing strategies.\n• Optimize your resume for Applicant Tracking Systems (ATS).\n• Tailor your resume for specific job applications.\n• Gain confidence in your resume writing skills.\n• Get feedback from career experts.\n• Network with other job seekers.',
                            faqs: [
                              {
                                'question': 'Is the Resume Workshop free?',
                                'answer': 'Yes, the Spires Recruit Resume Workshop is completely free to attend!'
                              },
                              {
                                'question': 'Who should attend the Resume Workshop?',
                                'answer': 'This workshop is beneficial for anyone seeking to improve their resume writing skills, from recent graduates to experienced professionals looking to make a career change.'
                              },
                              {
                                'question': 'What will I learn in the workshop?',
                                'answer': 'The workshop will cover a variety of topics, including resume structure, formatting, keyword optimization, crafting impactful achievements statements, and tailoring your resume for specific job applications.'
                              },
                              {
                                'question': 'How do I register for the workshop?',
                                'answer': 'Download the Spires Recruit app or visit our website (link) to find upcoming workshop dates and register.'
                              },
                            ],
                            onShare: () {
                              // Handle share action
                            },
                            howItWorks: '• Sign up for the free workshop through the Spires Recruit app / website.\n• Join our live, interactive workshop led by career development professionals.\n• Engage in interactive exercises and discussions to learn resume best practices.\n• Have the opportunity to receive personalized feedback on your resume during the workshop or through follow-up resources.',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child:   ProgramCard(
                            imageUrl: 'assets/icons/2.png',
                            title: 'Interview Preparation',
                            description:'Nail your next interview with Spires Recruit\'s comprehensive Interview Preparation section! This interactive tool equips you with the knowledge and confidence to shine in any interview setting.',
                            benefits: '• Boost confidence and reduce interview anxiety.\n• Learn effective strategies for answering common interview questions.\n• Practice your responses with interactive mock interview tools.\n• Receive personalized feedback to identify areas for improvement.\n• Gain insights into different interview formats and company cultures',
                            faqs: [
                              {
                                'question': 'What types of interview formats are covered?',
                                'answer': 'Spires Recruit covers various interview formats, including phone interviews, video interviews, and traditional in-person interviews.'
                              },
                              {
                                'question': 'How does the mock interview simulator work?',
                                'answer': 'The simulator provides a virtual interviewer and presents you with common interview questions. You can record your response and receive automated feedback on your body language, verbal delivery, and answer content.'
                              },
                              {
                                'question': 'Are there interview tips for different industries?',
                                'answer': 'Yes, we offer tailored interview prep resources for various industries, helping you understand industry-specific questions and expectations.'
                              },
                              {
                                'question': 'How can I access the Interview Preparation section?',
                                'answer': 'The Interview Preparation section is available within the Spires Recruit app. Download the app for free and explore all our resources designed to help you land your dream job!'
                              },
                            ],
                            onShare: () {
                              // Handle share action
                            },
                            howItWorks: '• Access a vast library of interview questions categorized by industry, job title & difficulty level.\n• Utilize our AI-powered mock interview simulator to practice your responses in a realistic setting.\n• Review detailed feedback reports on your mock interviews, highlighting strengths & areas for development./n• Watch informative video tutorials & read articles from industry professionals on interview best practices.',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child:   ProgramCard(
                            imageUrl: 'assets/icons/jsdh.png',
                            title: 'Coding Clubs',
                            description:'The Spires Recruit Coding Club is a community for developers who are passionate about building and improving the Spires Recruit platform. We welcome coders of all experience levels, from beginners to seasoned professionals.',
                            benefits: '• Work on real-world projects that utilize various coding skills and technologies.\n• Approach challenges creatively and find innovative solutions.\n• Get guidance and feedback from industry professionals.\n• Showcase your coding projects to potential employers.\n• Connect with other programmers who share your passion for coding.',
                            faqs: [
                              {
                                'question': 'Is there a cost to join the Spires Recruit Coding Club?',
                                'answer': 'No, the Spires Recruit Coding Club is completely free to join and participate in.'
                              },
                              {
                                'question': 'What coding experience level is required?',
                                'answer': 'The Spires Recruit Coding Club welcomes coders of all skill levels, from beginners to experienced programmers.'
                              },
                              {
                                'question': 'What programming languages are covered in the club?',
                                'answer': 'The Spires Recruit Coding Club covers a variety of popular programming languages, with the specific languages addressed depending on member interests and industry trends.'
                              },
                              {
                                'question': 'How do I find out about upcoming workshops and events?',
                                'answer': 'Announcements for upcoming workshops, challenges, and events will be posted within the Spires Recruit Coding Club forum and communicated through the Spires Recruit app.'
                              },
                            ],
                            onShare: () {
                              // Handle share action
                            },
                            fit: BoxFit.fill,
                            howItWorks: '• Sign up for the Spires Recruit Coding Club through the Spires Recruit app / website.\n• Participate in weekly coding challenges designed to test and enhance your skills.\n• Attend regular online workshops and Q&A sessions hosted by industry experts.\n• Join discussions, share solutions, and get help from fellow club members.\n• Connect with other coders through the forum and participate in virtual coding meetups.',
                          ),
                        ),
                        // Add more ProgramCard widgets as needed
                      ],
                      options: CarouselOptions(
                        height: 278,
                        autoPlay: true,
                        viewportFraction: 1,
                        autoPlayInterval:
                        const Duration(seconds: 8),
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
                  const FeaturedCategory(),
                  buildTopCompanies(),
                  const Reviews(),
                ],
              ),
            ),
            buildAppBar(),
          ],
        ),
      ),
    );
  }

  Container buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      color: whiteColor,
      child: Row(
        children: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(Icons.menu, color: Colors.black, size: 24),
            // icon: Image.asset('assets/images/menu.jpg', height: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Text.rich(
              TextSpan(
                text: 'Welcome!\n', // Default text
                style: normalLightText, // Default style
                children: [
                  TextSpan(
                    text: '${MyController.userFirstName} ${MyController.userLastName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Different style
                      color: Colors.black, // Change color as needed
                      fontSize: 16.0, // Adjust font size if necessary
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () => Get.to(() => NearMapJobs()),
            child: const Icon(
                Icons.my_location_outlined,
                color: Colors.black54,
                size: 24
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => Get.to(() => const NotificationScreen()),
            child: const Icon(Icons.notifications_outlined,
                color: Colors.black54, size: 24
            ),
          ),
        ],
      ),
    );
  }


  // Widget buildBanner(Size size) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
  //     decoration: BoxDecoration(borderRadius: borderRadius),
  //     width: double.infinity,
  //     height: size.height * 0.2,
  //     child: Stack(
  //       children: [
  //         Align(
  //           alignment: Alignment.topCenter,
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 8),
  //             height: size.height * 0.04,
  //             decoration: BoxDecoration(
  //               color: secondaryColor.withOpacity(0.3),
  //               borderRadius: const BorderRadius.only(
  //                   topLeft: Radius.circular(defaultRadius),
  //                   topRight: Radius.circular(defaultRadius)),
  //             ),
  //             child: Row(
  //               children: [
  //                 c.location.value == ''
  //                     ? Container()
  //                     : const Icon(Icons.location_on, color: primaryColor),
  //                 const SizedBox(width: 4),
  //                 Obx(() => Expanded(
  //                     child: Text(c.location.value, style: smallLightText))),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Container(
  //             decoration: const BoxDecoration(
  //               color: bannerBgColor,
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(defaultRadius),
  //                 bottomRight: Radius.circular(defaultRadius),
  //               ),
  //             ),
  //             height: size.height * 0.16,
  //             width: size.width,
  //             child: Align(
  //               alignment: Alignment.centerLeft,
  //               child: Container(
  //                 padding: const EdgeInsets.all(8.0),
  //                 width: double.infinity,
  //                 child: Obx(
  //                   () => Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       c.isSubscribed.value || MyController.subscribed == '1'
  //                           ? Text(
  //                               "Congratulations!!!\nto unlock premium benefits",
  //                               style: normalWhiteText,
  //                               textAlign: TextAlign.left,
  //                             )
  //                           : Text(
  //                               "Upgrade to Premium\nto unlock more benefits",
  //                               style: normalWhiteText,
  //                               textAlign: TextAlign.left,
  //                             ),
  //                       const SizedBox(height: defaultPadding),
  //                       c.isSubscribed.value || MyController.subscribed == '1'
  //                           ? myButton(
  //                               onPressed: () => Get.to(() => ResumeScreen()),
  //                               color: Colors.white24,
  //                               label: 'Build Instant CV',
  //                               style: normalWhiteText,
  //                             )
  //                           : myButton(
  //                               onPressed: () =>
  //                                   Get.to(() => const UpgradeNow()),
  //                               color: primaryColor,
  //                               label: 'Upgrade Now',
  //                               style: normalWhiteText,
  //                             ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.bottomRight,
  //           child: Image.asset(homeBanner, height: 200),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  buildTopCompanies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: primaryColor.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding, left: defaultPadding),
                child: Text(
                  "Top Companies trust us",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder<LogoModel>(
                future: HomeUtils.getLogo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loading; // Return a loading indicator while data is being fetched
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Handle error state
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data!.isEmpty) {
                    return Text('No data available'); // Handle no data state
                  } else {
                    return Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      height: 70,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 70,
                          viewportFraction: 0.38,
                          autoPlay: true, // Enable automatic sliding
                          autoPlayInterval: Duration(
                              seconds: 3), // Set the interval for sliding
                          autoPlayAnimationDuration: Duration(
                              milliseconds:
                                  800), // Set the duration of sliding animation
                          autoPlayCurve:
                              Curves.fastOutSlowIn, // Set the animation curve
                        ),
                        items: snapshot.data!.data!.map((logo) {
                          return Card(
                            elevation: 4,
                            color: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: borderRadius,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: '$imgPath/${logo.logo}',
                              width: 115,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              )

              // const Divider(color: Colors.black26),
              // IntrinsicHeight(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Column(
              //         children: [
              //           Text('1 K+', style: xLargeBoldColorText),
              //           Text('Companies Hiring', style: smallText),
              //           const Divider(color: Colors.black26),
              //           Text('1 K+', style: xLargeBoldColorText),
              //           Text('Active Users', style: smallText),
              //         ],
              //       ),
              //       Column(
              //         children: [
              //           Text('100+', style: xLargeBoldColorText),
              //           Text('New openings everyday', style: smallText),
              //           const Divider(color: Colors.black26),
              //           Text('50+', style: xLargeBoldColorText),
              //           Text('College Tieups', style: smallText),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}


