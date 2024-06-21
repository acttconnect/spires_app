import 'package:spires_app/Model/profile_model.dart';
import '../../../../Constants/exports.dart';

class AboutMeCard extends StatelessWidget {
  AboutMeCard({super.key});
  final c = Get.put(MyController());
  final aboutMeController = TextEditingController();
  final aboutMeEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.fromLTRB(
          defaultPadding, defaultPadding, defaultPadding, 0),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Obx(
        () => c.isAboutLoading.value
            ? profileLoading()
            : FutureBuilder<ProfileModel>(
                future: ProfileUtils.showProfile(),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data!.message!.description == null ||
                            snapshot.data!.message!.description == ''
                        ? emptyAboutMe()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(aboutMeIcon),
                                  const SizedBox(width: defaultPadding),
                                  Text('About Me', style: normalText),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => aboutMeEditDialog(
                                        snapshot.data!.message!.description!),
                                    child: SvgPicture.asset(editCIcon,
                                        height: iconsize),
                                  ),
                                ],
                              ),
                              const Divider(
                                  color: Colors.black12, thickness: 1),
                              Text(snapshot.data!.message!.description!,
                                  style: smallLightText)
                            ],
                          )
                    : profileLoading(),
              ),
      ),
    );
  }

  Widget emptyAboutMe() {
    c.aboutMePoints.value = 0.00;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(aboutMeIcon),
              const SizedBox(width: defaultPadding),
              Text('About Me', style: normalText),
            ],
          ),
          const Divider(color: Colors.black12, thickness: 1),
          Text('Add about yourself and boost your profile by 10 %',
              style: smallLightText),
          const SizedBox(height: 8),
          myButton(
              onPressed: () => aboutMeAddDialog(),
              label: '+ About me',
              color: primaryColor,
              style: normalWhiteText),
        ],
      ),
    );
  }

  aboutMeAddDialog() {
    return Get.defaultDialog(
      radius: 8,
      title: 'About Me',
      content: Obx(
        () => c.isAboutLoading.value
            ? loading
            : Column(
                children: [
                  TextFormField(
                    controller: aboutMeController,
                    minLines: 8,
                    maxLines: 12,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: bgColor,
                      hintText: 'Write about yourself',
                    ),
                  ),
                  myButton(
                      onPressed: () => aboutMeController.text.isNotEmpty
                          ? ProfileUtils.addAboutMe(
                              aboutMe: aboutMeController.text)
                          : Fluttertoast.showToast(
                              msg: 'Please write about yourself'),
                      label: 'Save',
                      color: primaryColor,
                      style: normalWhiteText)
                ],
              ),
      ),
    );
  }

  aboutMeEditDialog(String data) {
    aboutMeEditController.text = data;
    return Get.defaultDialog(
      radius: 8,
      title: 'About Me',
      content: Obx(
        () => c.isAboutLoading.value
            ? loading
            : Column(
                children: [
                  TextFormField(
                    controller: aboutMeEditController,
                    minLines: 8,
                    maxLines: 12,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: bgColor,
                      hintText: 'Write about yourself',
                    ),
                  ),
                  myButton(
                      onPressed: () => aboutMeEditController.text.isNotEmpty
                          ? ProfileUtils.editAboutMe(
                              aboutMe: aboutMeEditController.text)
                          : Fluttertoast.showToast(
                              msg: 'Please write about yourself'),
                      label: 'Save',
                      color: primaryColor,
                      style: normalWhiteText)
                ],
              ),
      ),
    );
  }
}
