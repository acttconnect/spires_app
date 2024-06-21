import 'package:spires_app/Constants/exports.dart';

class SavedData extends StatelessWidget {
  const SavedData({super.key});

  @override
  Widget build(BuildContext context) {
    var isJob = true.obs;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            tabs(isJob),
            Obx(
              () => Expanded(
                child: isJob.value ? SavedJobs() : SavedInternship(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  tabs(var isJob) {
    return Row(
      children: [
        const SizedBox(width: defaultPadding),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: borderRadius,
            ),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            margin: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: borderRadius,
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => isJob.value = true,
                    child: Obx(() => isJob.value
                        ? Text('Saved Jobs', style: smallColorText)
                        : Text('Saved Jobs', style: smallText)),
                  ),
                  const VerticalDivider(color: Colors.black26),
                  InkWell(
                    onTap: () => isJob.value = false,
                    child: Obx(() => isJob.value
                        ? Text('Saved Internships', style: smallText)
                        : Text('Saved Internships', style: smallColorText)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
