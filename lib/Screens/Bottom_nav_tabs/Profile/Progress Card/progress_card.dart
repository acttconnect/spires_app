import '../../../../Constants/exports.dart';

class ProgressCard extends StatelessWidget {
  ProgressCard({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    MyController.veriEmail == '1'
        ? c.emailPoints.value = 15.00
        : c.emailPoints.value = 0.00;
    MyController.veriPhone == '1'
        ? c.phonePoints.value = 15.00
        : c.phonePoints.value = 0.00;
    return Container(
      width: size.width,
      color: primaryColor.withOpacity(0.2),
      height: size.height * 0.2,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          buildProgress(size),
          buildPhoneCard(size),
          buildEmailCard(size),
          const SizedBox(width: 8)
        ],
      ),
    );
  }

  Container buildProgress(Size size) {
    c.getProgressValue();
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      width: size.width * 0.3,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Obx(
                () => SleekCircularSlider(
                  initialValue: c.progressValue.value,
                  appearance: CircularSliderAppearance(
                    size: 80,
                    spinnerDuration: 3000,
                    customColors: c.progressValue.value == 100.0
                        ? CustomSliderColors(
                            progressBarColor: Colors.green.shade600,
                            trackColor: Colors.black12,
                          )
                        : CustomSliderColors(
                            progressBarColor: primaryColor,
                            trackColor: Colors.black12,
                          ),
                  ),
                  innerWidget: (percentage) {
                    return Center(
                      child: Obx(
                        () => Text(
                          '${c.progressValue.value}%',
                          style: c.progressValue.value == 100.00
                              ? smallGreenText
                              : smallColorText,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            c.progressValue.value == 100.00
                ? Text(
                    'Congratulations!!! Your Profile is complete.',
                    style: smallGreenText,
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'We suggest you to have a complete profile. ',
                    style: xsmallText,
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }

  Container buildPhoneCard(Size size) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      width: size.width * 0.3,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text('+ 15%', style: xsmallGreenText),
            ),
            c.isPhoneVerified.value || MyController.veriPhone == '1'
                ? CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.8),
                    child:
                        const Icon(Icons.verified, color: whiteColor, size: 20),
                  )
                : CircleAvatar(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: const Icon(Icons.phone_android,
                        color: primaryColor, size: 20),
                  ),
            const Spacer(),
            Text(
              'Recruiters contact verified numbers',
              style: xsmallText,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            c.isPhoneVerified.value || MyController.veriPhone == '1'
                ? Container(
                    height: 20,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: borderRadius,
                    ),
                    child: Text(
                      'Verified',
                      textAlign: TextAlign.center,
                      style: smallWhiteText,
                    ),
                  )
                : InkWell(
                    onTap: () => ProfileUtils.getOtp(MyController.userPhone),
                    child: Obx(
                      () => c.isotpLoading.value
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Container(
                              height: 20,
                              width: size.width * 0.2,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: borderRadius,
                              ),
                              child: Text(
                                'Verify',
                                textAlign: TextAlign.center,
                                style: smallColorText,
                              ),
                            ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Container buildEmailCard(Size size) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      width: size.width * 0.3,
      child: Obx(
        () => Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text('+ 15%', style: xsmallGreenText),
            ),
            c.isEmailVerified.value || MyController.veriEmail == '1'
                ? CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.8),
                    child: const Icon(Icons.verified_rounded,
                        color: whiteColor, size: 20),
                  )
                : CircleAvatar(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: const Icon(Icons.email_outlined,
                        color: primaryColor, size: 20),
                  ),
            const Spacer(),
            Text(
              'Recruiters contact verified email',
              style: xsmallText,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            c.isEmailVerified.value || MyController.veriEmail == '1'
                ? Container(
                    height: 20,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: borderRadius,
                    ),
                    child: Text(
                      'Verified',
                      textAlign: TextAlign.center,
                      style: smallWhiteText,
                    ),
                  )
                : InkWell(
                    onTap: () => ProfileUtils.getEmailVerification(),
                    child: Obx(
                      () => c.isemailLoading.value
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Container(
                              height: 20,
                              width: size.width * 0.2,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: borderRadius,
                              ),
                              child: Text(
                                'Verify',
                                textAlign: TextAlign.center,
                                style: smallColorText,
                              ),
                            ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
