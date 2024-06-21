import '../../../../Constants/exports.dart';

class MobileVerify extends StatelessWidget {
  MobileVerify({super.key});
  final pinController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    margin: const EdgeInsets.all(defaultMargin),
    textStyle: mediumText,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(color: primaryColor),
    ),
  );
  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => c.isotpLoading.value
            ? loading
            : Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: defaultMargin * 2,
                    vertical: defaultPadding * 12),
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 2),
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: whiteColor,
                    border: Border.all(color: Colors.black12)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Let's verify your phone number",
                          style: largeText, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 350,
                        child: Text(
                          'We have sent an SMS to your whatsapp with a code to a number',
                          style: normalLightText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text('+91 ${MyController.userPhone}', style: mediumText),
                      const SizedBox(height: 15),
                      Pinput(
                        controller: pinController,
                        defaultPinTheme: defaultPinTheme,
                        autofocus: true,
                        onChanged: (value) {
                          c.myotp.value = value;
                        },
                        onSubmitted: (value) => c.myotp.value = value,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the OTP ?",
                            style: smallLightText,
                          ),
                          TextButton(
                              onPressed: () =>
                                  ProfileUtils.getOtp(MyController.userPhone),
                              child: const Text('Resend')),
                        ],
                      ),
                      Obx(
                        () => c.isotpLoading.value
                            ? loading
                            : GestureDetector(
                                onTap: () {
                                  if (c.otp.value == c.myotp.value) {
                                    ProfileUtils.getPhoneVerification();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Incorrect OTP, Please try again');
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    'Verify Number',
                                    style: mediumWhiteText,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
