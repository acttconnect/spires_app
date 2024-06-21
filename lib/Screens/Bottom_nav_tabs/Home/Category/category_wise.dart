import 'package:spires_app/Screens/Bottom_nav_tabs/Home/Category/category_wise_job.dart';
import '../../../../Constants/exports.dart';

class CategoryWise extends StatelessWidget {
  final int catId;
  final String catName;
  const CategoryWise({super.key, required this.catId, required this.catName});

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
                child: isJob.value
                    ? CategoryWiseJob(catId: catId, catName: catName)
                    : CategoryWiseIntern(catId: catId, catName: catName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

tabs(var isJob) {
  return Container(
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
                ? Text('Jobs', style: smallColorText)
                : Text('Jobs', style: smallText)),
          ),
          const VerticalDivider(color: Colors.black26),
          InkWell(
            onTap: () => isJob.value = false,
            child: Obx(() => isJob.value
                ? Text('Internships', style: smallText)
                : Text('Internships', style: smallColorText)),
          ),
        ],
      ),
    ),
  );
}
