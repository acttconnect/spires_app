import 'dart:io';

import 'package:flutter/material.dart';
import '../../../Constants/exports.dart';
import '../../Resumes/cv_two.dart';

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
                onTap: () => Get.to(() => const Profile()),
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
                            if (c.isSubscribed.value || MyController.subscribed == '1')
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
                      Expanded( // This Expanded widget will fill the remaining space
                        child: Obx(
                              () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
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
                                  if (c.isSubscribed.value || MyController.subscribed == '1')
                                    const Icon(
                                      Icons.workspace_premium,
                                      color: whiteColor,
                                    ),
                                ],
                              ),
                              Text(
                                MyController.userPhone,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: whiteColor,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              Text(
                                MyController.userEmail,
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
                      IconButton(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        onPressed: () => logoutfn(),
                        icon: const Icon(Icons.logout, size: 25, color: whiteColor),
                      ),
                    ],
                  ),

                ),
              ),
              SizedBox(height: 10,),
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
              //           () => Get.to(() => Preferences())),
              //     ],
              //   ),
              // ),
              // const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: myProfileList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (myProfileList[index].label == 'Policies') {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Theme(
                            data: ThemeData(
                              dividerColor: whiteColor,
                              hintColor: primaryColor,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                myProfileList[index].label,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              childrenPadding: const EdgeInsets.only(left: 20),
                              collapsedIconColor: Colors.grey,
                              iconColor: primaryColor,
                              leading: Icon(
                                myProfileList[index].image,
                                color: primaryColor,
                              ),
                              children: policyDropdownItems.map((item) {
                                return ListTile(
                                  dense: true,
                                  title: Text(item.label, style: normalText),
                                  leading:
                                      Icon(item.image, color: primaryColor),
                                  onTap: item.onTap,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: buildTile(
                            onTap: myProfileList[index].onTap,
                            title: myProfileList[index].label,
                            iconData: myProfileList[index].image,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
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
        height: 100,
        width: 100,
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
                imageUrl: '$imgPath/${c.profileImg.value}',
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
    height: 120,
    width: 130,
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