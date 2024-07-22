import 'package:flutter/cupertino.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Drawer/programs_screen.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Nearby%20Jobs/map_jobs.dart';

import '../../Constants/exports.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    JobsUtils.allJobs();
    InternshipUtils.allInternship();
    LocationServices.getLocation();
    return Scaffold(
      backgroundColor: bgColor,
      body: Obx(
        () => IndexedStack(
          index: c.selectedIndex.value,
          children: [
            const Home(),
            // NearbyJobs(
            //   cityName: c.city.value,
            //   isCityWise: false,
            // ),
            // NearMapJobs(),
            const ProgramsScreen(),
            Profile(),
            const Internship(),
            const Jobs(),
            // const Profile(),
          ],
        ),
      ),
      bottomNavigationBar: customBottomBar(),
    );
  }

  Widget customBottomBar() {
    return Obx(
      () => NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(xsmallLightText.copyWith())
        ),
        child: NavigationBar(
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          elevation: 5,
          indicatorColor: primaryColor.withOpacity(0.05),
          backgroundColor: whiteColor,
          selectedIndex: c.selectedIndex.value,
          onDestinationSelected: (index) => c.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Colors.black38,
              ),
              selectedIcon: Icon(
                Icons.home,
                color: primaryColor,
              ),
              label: 'Home',
              //increase the size of the label
              // labelStyle: MaterialStateProperty.all(xsmallLightText.copyWith()),
              //no it don't have that property
            ),
            NavigationDestination(
              icon: Icon(
                Icons.school,
                color: Colors.black38,
              ),
              selectedIcon: Icon(
                Icons.school,
                color: primaryColor,
              ),
              label: 'Programs',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.black38,
              ),
              selectedIcon: Icon(
                Icons.account_circle_outlined,
                color: primaryColor,
              ),
              label: 'Account',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.work_history,
                color: Colors.black38,
              ),
              selectedIcon: Icon(
                Icons.work_history,
                color: primaryColor,
              ),
              label: 'Internship',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.business_center,
                color: Colors.black38,
              ),
              selectedIcon: Icon(
                Icons.business_center_rounded,
                color: primaryColor,
              ),
              label: 'Jobs',
            ),
            // NavigationDestination(
            //   icon: Icon(
            //     Icons.person,
            //     color: Colors.black38,
            //   ),
            //   selectedIcon: Icon(
            //     Icons.person,
            //     color: primaryColor,
            //   ),
            //   label: 'Profile',
            // ),
          ],
        ),
      ),
    );
  }
}
