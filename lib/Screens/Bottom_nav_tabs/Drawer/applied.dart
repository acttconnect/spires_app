import 'package:spires_app/Constants/exports.dart';

class AppliedData extends StatelessWidget {
  const AppliedData({super.key});

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
                child: isJob.value ? AppliedJobs() : AppliedInternship(),
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
                        ? Text('Applied Jobs', style: smallColorText)
                        : Text('Applied Jobs', style: smallText)),
                  ),
                  const VerticalDivider(color: Colors.black26),
                  InkWell(
                    onTap: () => isJob.value = false,
                    child: Obx(() => isJob.value
                        ? Text('Applied Internships', style: smallText)
                        : Text('Applied Internships', style: smallColorText)),
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
