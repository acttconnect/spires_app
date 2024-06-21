import '../../../../Constants/exports.dart';

class AddResume extends StatefulWidget {
  const AddResume({super.key});

  @override
  State<AddResume> createState() => _AddResumeState();
}

class _AddResumeState extends State<AddResume> {
  final c = Get.put(MyController());
  Future<String?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      String filePath = result.files.single.path!;
      ProfileUtils.uploadCV(filePath);
      return filePath;
    }
    Fluttertoast.showToast(msg: 'No Files selected');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
      ),
      body: Obx(
        () => c.isCVLoading.value
            ? loading
            : Column(
                children: [
                  const SizedBox(height: 65),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius * 2,
                      color: whiteColor,
                    ),
                    margin: const EdgeInsets.all(defaultMargin * 3),
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Uploader',
                            style: largeBoldText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Supported file formats : PDF',
                          style: smallLightText,
                        ),
                        Text(
                          'Maximun file size 2 MB.',
                          style: smallLightText,
                        ),
                        Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.cloud_upload,
                                size: 60,
                                color: primaryColor,
                              ),
                              const SizedBox(height: 24),
                              myButton(
                                onPressed: () => pickPDF(),
                                label: 'Upload CV',
                                color: primaryColor,
                                style: normalWhiteText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
