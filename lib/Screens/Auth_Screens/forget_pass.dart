import 'package:spires_app/Constants/exports.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final emailController = TextEditingController();
  final forgetKey = GlobalKey<FormState>();
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: MyContainer(
        color: whiteColor,
        margin: const EdgeInsets.all(defaultMargin),
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: forgetKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text('Forgot your Password ?', style: largeBoldText),
              const SizedBox(height: defaultPadding),
              Text('We will get back to your account', style: smallLightText),
              const SizedBox(height: defaultPadding),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your registered mail id',
                iconData: Icons.mail_lock,
                isEmail: true,
              ),
              const SizedBox(height: defaultPadding),
              Center(
                child: Obx(
                  () => c.isLoginLoading.value
                      ? loading
                      : myButton(
                          onPressed: () {
                            final isValid = forgetKey.currentState!.validate();
                            if (isValid) {
                              AuthUtils.forgetPass(email: emailController.text);
                            }
                          },
                          label: 'Confirm',
                          color: primaryColor,
                          style: normalWhiteText),
                ),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
