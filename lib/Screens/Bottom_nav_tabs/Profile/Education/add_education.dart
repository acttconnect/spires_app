import '../../../../Constants/exports.dart';

class AddEducation extends StatelessWidget {
  AddEducation({super.key});
  final collegeController = TextEditingController();
  final degreeController = TextEditingController();
  final streamController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final percentController = TextEditingController();
  final eduKey = GlobalKey<FormState>();
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    c.startDate.value = DateTime(1999);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Details'),
      ),
      body: Obx(
        () => c.isEduLoading.value
            ? loading
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Form(
                    key: eduKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: collegeController,
                          hintText: 'College/School name',
                          iconData: Icons.apartment,
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
                            Expanded(
                              child: CustomTextField(
                                controller: endDateController,
                                hintText: 'End Date',
                                iconData: Icons.calendar_month,
                                isDate: true,
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: degreeController,
                          hintText: 'Degree/Education',
                          iconData: Icons.workspace_premium,
                        ),
                        CustomTextField(
                          controller: streamController,
                          hintText: 'Stream/Branch',
                          iconData: Icons.stream,
                        ),
                        CustomTextField(
                          controller: percentController,
                          hintText: 'Percentage',
                          iconData: Icons.grade,
                          keyboardType: TextInputType.number,
                          isNumeric: true,
                        ),
                        const SizedBox(height: defaultPadding),
                        ElevatedButton(
                          onPressed: () {
                            final isValid = eduKey.currentState!.validate();
                            if (isValid) {
                              ProfileUtils.addEducation(
                                  collegeName: collegeController.text,
                                  degree: degreeController.text,
                                  startDate: startDateController.text,
                                  endDate: endDateController.text,
                                  stream: streamController.text,
                                  percent: percentController.text);
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
}
