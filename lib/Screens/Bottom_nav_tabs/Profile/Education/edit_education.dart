import '../../../../Constants/exports.dart';

class EditEducation extends StatelessWidget {
  final String collegeName;
  final String stream;
  final String degree;
  final String start;
  final String? end;
  final String percent;
  final int eduId;
  EditEducation(
      {super.key,
      required this.collegeName,
      required this.stream,
      required this.degree,
      required this.start,
      required this.end,
      required this.percent,
      required this.eduId});
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
    collegeController.text = collegeName;
    degreeController.text = degree;
    streamController.text = stream;
    startDateController.text = start;
    endDateController.text = end ?? '';
    percentController.text = percent;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Education Details'),
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
                          hintText: 'College',
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
                          hintText: 'Degree',
                          iconData: Icons.workspace_premium,
                        ),
                        CustomTextField(
                          controller: streamController,
                          hintText: 'Stream',
                          iconData: Icons.stream,
                        ),
                        CustomTextField(
                          controller: percentController,
                          hintText: 'Percentage',
                          iconData: Icons.grade,
                          isNumeric: true,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: defaultPadding),
                        ElevatedButton(
                          onPressed: () {
                            final isValid = eduKey.currentState!.validate();
                            if (isValid) {
                              ProfileUtils.editEducation(
                                  collegeName: collegeController.text,
                                  degree: degreeController.text,
                                  startDate: startDateController.text,
                                  endDate: endDateController.text,
                                  stream: streamController.text,
                                  percent: percentController.text,
                                  eduId: eduId);
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
