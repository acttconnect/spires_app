import '../../../../Constants/exports.dart';
import '../../../../Model/profile_model.dart';

class CvCard extends StatelessWidget {
  CvCard({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(cvIcon),
              const SizedBox(width: defaultPadding),
              Text('Resume', style: normalText),
            ],
          ),
          const Divider(color: Colors.black12, thickness: 1),
          Obx(
            () => c.isCVLoading.value
                ? profileLoading()
                : FutureBuilder<ProfileModel>(
                    future: ProfileUtils.showProfile(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.message!.cv == null
                            ? emptyCV()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(pdfIcon, height: 40),
                                  const SizedBox(width: defaultPadding),
                                  InkWell(
                                    onTap: () => Get.to(() => ViewCV(
                                        pdfUrl:
                                            '$imgPath/${snapshot.data!.message!.cv}')),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.6,
                                          child: Text(
                                            "${snapshot.data!.message!.cv}",
                                            style: smallLightText,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.message!.cvUpdatedAt!,
                                          style: smallLightText,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => ProfileUtils.deleteCV(),
                                    child: SvgPicture.asset(deleteIcon,
                                        height: iconsize),
                                  ),
                                ],
                              )
                        : profileLoading(),
                  ),
          ),
        ],
      ),
    );
  }

  emptyCV() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Upload your CV and boost your profile by 15 %',
              style: smallLightText),
          const SizedBox(height: 8),
          myButton(
              onPressed: () => Get.to(() => const AddResume()),
              label: '+ Upload CV',
              color: primaryColor,
              style: normalWhiteText),
        ],
      ),
    );
  }
}
