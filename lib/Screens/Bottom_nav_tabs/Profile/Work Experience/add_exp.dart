import '../../../../Constants/exports.dart';

class AddExp extends StatelessWidget {
  AddExp({super.key});
  final profileController = TextEditingController();
  final organisationController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final workDescController = TextEditingController();
  final expKey = GlobalKey<FormState>();
  final c = Get.put(MyController());
  final RxBool isWfh = false.obs;
  final RxBool isWorking = false.obs;
  @override
  Widget build(BuildContext context) {
    c.startDate.value = DateTime(1999);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: Obx(
        () => c.isExpLoading.value
            ? loading
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Form(
                    key: expKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: profileController,
                          hintText: 'Designation',
                          iconData: Icons.account_circle,
                        ),
                        CustomTextField(
                          controller: organisationController,
                          hintText: 'Organisation',
                          iconData: Icons.apartment,
                        ),
                        Obx(
                          () => CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: isWfh.value,
                            onChanged: (newvalue) {
                              isWfh.value = newvalue!;
                            },
                            title: Text('Is work from home',
                                style: normalLightText),
                          ),
                        ),
                        CustomTextField(
                          controller: locationController,
                          hintText: 'Location',
                          iconData: Icons.location_on,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: startDateController,
                                hintText: 'Start Date',
                                iconData: Icons.calendar_month,
                                isDate: true,
                                isStartDate: true,
                              ),
                            ),
                            const SizedBox(width: defaultPadding),
                            Obx(
                              () => Visibility(
                                visible: !isWorking.value,
                                child: Expanded(
                                  child: CustomTextField(
                                    controller: endDateController,
                                    hintText: 'End Date',
                                    iconData: Icons.calendar_month,
                                    isDate: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: isWorking.value,
                            onChanged: (newvalue) {
                              isWorking.value = newvalue!;
                            },
                            title: Text('I am currently working here',
                                style: normalLightText),
                          ),
                        ),
                        proTips(size),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          controller: workDescController,
                          maxLines: 5,
                          maxLength: 250,
                          validator: (val) =>
                              val!.isEmpty ? 'This is required' : null,
                          decoration: const InputDecoration(
                            hintText: 'Work Description',
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        ElevatedButton(
                          onPressed: () {
                            final isValid = expKey.currentState!.validate();
                            if (isValid) {
                              ProfileUtils.addExperience(
                                  designation: profileController.text,
                                  organisation: organisationController.text,
                                  location: locationController.text,
                                  start: startDateController.text,
                                  end: isWorking.value
                                      ? ''
                                      : endDateController.text,
                                  desc: workDescController.text,
                                  isWFH: isWfh.value);
                            }
                          },
                          child: Text('Save', style: mediumWhiteText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Container proTips(Size size) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pro Tips:', style: normalBoldText),
          const SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Icon(Icons.circle, size: 10),
              ),
              const SizedBox(width: defaultPadding),
              SizedBox(
                width: size.width - 75,
                child: Text(
                  'Mention key internship responsibilities in max 3-4 points',
                  style: normalLightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Icon(Icons.circle, size: 10),
              ),
              const SizedBox(width: defaultPadding),
              SizedBox(
                width: size.width - 75,
                child: Text(
                  'Use action verbs: Built, Led, Drove, , Learnt, Conceptualized etc',
                  style: normalLightText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
