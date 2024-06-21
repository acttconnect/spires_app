import 'package:spires_app/Model/logo_model.dart';
import 'package:spires_app/Screens/Resumes/cv_two.dart';
import '../../../Constants/exports.dart';

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
              physics: const PageScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 55),
                  buildBanner(size),
                  FindYourJob(),
                  JobCard(),
                  InternshipCard(),
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
            icon: Image.asset('assets/images/menu.jpg', height: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Text(
                'Hello, ${MyController.userFirstName} ${MyController.userLastName}',
                style: normalLightText),
          ),
          const Spacer(),
          InkWell(
            onTap: () => Get.to(() => const NotificationScreen()),
            child: const Icon(Icons.notifications_outlined,
                color: primaryColor, size: 20),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => Get.to(() => const Faqs()),
            child:
                const Icon(Icons.help_outline, color: primaryColor, size: 20),
          ),
        ],
      ),
    );
  }

  Widget buildBanner(Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(borderRadius: borderRadius),
      width: double.infinity,
      height: size.height * 0.2,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: size.height * 0.04,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(defaultRadius),
                    topRight: Radius.circular(defaultRadius)),
              ),
              child: Row(
                children: [
                  c.location.value == ''
                      ? Container()
                      : const Icon(Icons.location_on, color: primaryColor),
                  const SizedBox(width: 4),
                  Obx(() => Expanded(child: Text(c.location.value, style: smallLightText))),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: bannerBgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(defaultRadius),
                  bottomRight: Radius.circular(defaultRadius),
                ),
              ),
              height: size.height * 0.16,
              width: size.width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        c.isSubscribed.value || MyController.subscribed == '1'
                            ? Text(
                                "Congratulations!!!\nto unlock premium benefits",
                                style: normalWhiteText,
                                textAlign: TextAlign.left,
                              )
                            : Text(
                                "Upgrade to Premium\nto unlock more benefits",
                                style: normalWhiteText,
                                textAlign: TextAlign.left,
                              ),
                        const SizedBox(height: defaultPadding),
                        c.isSubscribed.value || MyController.subscribed == '1'
                            ? myButton(
                                onPressed: () => Get.to(() => ResumeScreen()),
                                color: Colors.white24,
                                label: 'Build Instant CV',
                                style: normalWhiteText,
                              )
                            : myButton(
                                onPressed: () =>
                                    Get.to(() => const UpgradeNow()),
                                color: primaryColor,
                                label: 'Upgrade Now',
                                style: normalWhiteText,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(homeBanner, height: 200),
          ),
        ],
      ),
    );
  }

  buildTopCompanies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: primaryColor.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding, left: defaultPadding),
                child: Text(
                  "Top Companies trust us",
                  style: mediumBoldText,
                ),
              ),
              FutureBuilder<LogoModel>(
                future: HomeUtils.getLogo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loading; // Return a loading indicator while data is being fetched
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Handle error state
                  } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                    return Text('No data available'); // Handle no data state
                  } else {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      height: 70,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 70,
                          viewportFraction: 0.38,
                          autoPlay: true, // Enable automatic sliding
                          autoPlayInterval: Duration(seconds: 3), // Set the interval for sliding
                          autoPlayAnimationDuration: Duration(milliseconds: 800), // Set the duration of sliding animation
                          autoPlayCurve: Curves.fastOutSlowIn, // Set the animation curve
                        ),
                        items: snapshot.data!.data!.map((logo) {
                          return CachedNetworkImage(
                            imageUrl: '$imgPath/${logo.logo}',
                            width: 115,
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
