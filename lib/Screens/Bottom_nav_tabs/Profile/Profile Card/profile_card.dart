import 'dart:io';
import 'package:spires_app/Screens/Resumes/cv_two.dart';
import '../../../../Constants/exports.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
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
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 225,
      width: size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(profileBanner), fit: BoxFit.cover),
          color: bannerBgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profilePic(),
                c.isSubscribed.value || MyController.subscribed == '1'
                    ? Column(
                        children: [
                          myButton(
                            onPressed: () => Get.to(() => ResumeScreen()),
                            label: 'Build Instant CV',
                            color: Colors.white12,
                            style: smallWhiteText,
                          ),
                          const SizedBox(height: 8),
                          // myButton(
                          //   onPressed: () => launchUrl(Uri.parse(
                          //       'https://spiresrecruit.com/cv/${MyController.id}')),
                          //   label: 'Browse more CV',
                          //   color: Colors.white12,
                          //   style: smallWhiteText,
                          // ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                            '${MyController.userFirstName} ${MyController.userLastName}',
                            style: mediumWhiteText),
                        const SizedBox(width: 8),
                        c.isSubscribed.value || MyController.subscribed == '1'
                            ? const Icon(
                                Icons.workspace_premium,
                                color: whiteColor,
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(MyController.userPhone, style: smallWhiteText),
                    Row(
                      children: [
                        Text(MyController.userEmail, style: smallWhiteText),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => logoutfn(),
                  icon: const Icon(Icons.logout, size: 25, color: whiteColor),
                )
              ],
            ),
          ),
        ],
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
                    height: 120,
                    width: 120,
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
                    right: 4,
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


// profilePic() {
//     return Obx(
//       () => c.isDpLoading.value
//           ? loadingProfileDP()
//           : FutureBuilder<ProfileModel>(
//               future: ProfileUtils.showProfile(),
//               builder: (context, snapshot) => snapshot.hasData
//                   ? snapshot.data!.message!.image == null ||
//                           snapshot.data!.message!.image == ''
//                       ? Stack(
//                           children: [
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Obx(
//                                 () => c.isDpLoading.value
//                                     ? loadingProfileDP()
//                                     : ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(120),
//                                         child: Image.asset(
//                                           profileImage,
//                                           width: 120,
//                                           height: 120,
//                                           fit: BoxFit.cover,
//                                         )),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: InkWell(
//                                 onTap: () => showImagePickerDialog(),
//                                 child: const CircleAvatar(
//                                   radius: 16,
//                                   child: Icon(Icons.edit,
//                                       size: 18, color: whiteColor),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Stack(
//                           children: [
//                             Container(
//                               height: 120,
//                               width: 120,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Obx(
//                                 () => c.isDpLoading.value
//                                     ? loadingProfileDP()
//                                     : ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(130),
//                                         child: CachedNetworkImage(
//                                           imageUrl:
//                                               '$imgPath/${snapshot.data!.message!.image}',
//                                           width: 120,
//                                           height: 120,
//                                           fit: BoxFit.cover,
//                                         )),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 4,
//                               child: InkWell(
//                                 onTap: () => showImagePickerDialog(),
//                                 child: const CircleAvatar(
//                                   radius: 16,
//                                   child: Icon(Icons.edit,
//                                       size: 18, color: whiteColor),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                   : loadingProfileDP(),
//             ),
//     );
//   }