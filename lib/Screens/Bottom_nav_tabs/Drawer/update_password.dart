import 'package:spires_app/Constants/exports.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final passController = TextEditingController();
  final newPassController = TextEditingController();
  final updateKey = GlobalKey<FormState>();
  final c = Get.put(MyController());
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
      ),
      body: MyContainer(
        color: whiteColor,
        margin: const EdgeInsets.all(defaultMargin),
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: updateKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text('Want to Update Password ?', style: largeBoldText),
              const SizedBox(height: defaultPadding),
              Text('Enter the details below', style: smallLightText),
              const SizedBox(height: defaultPadding),
              TextFormField(
                obscureText: isPassword,
                controller: passController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (val.length < 6) {
                    return 'Enter atleast 6 letter password';
                  } else if (val != c.authPass.value) {
                    return 'Password did not matched with your old password';
                  } else if (val == newPassController.text) {
                    return 'Old Password cannot match with new password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Old password',
                  prefixIcon: const Icon(Icons.security),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: isPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              CustomTextField(
                controller: newPassController,
                hintText: 'Enter New password',
                iconData: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: defaultPadding),
              Center(
                child: Obx(
                  () => c.isLoginLoading.value
                      ? loading
                      : myButton(
                          onPressed: () {
                            final isValid = updateKey.currentState!.validate();
                            if (isValid) {
                              AuthUtils.updatePass(
                                  newPass: newPassController.text);
                            }
                          },
                          label: 'Update Password',
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
