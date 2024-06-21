import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/job_model.dart';

class CategoryWiseJob extends StatelessWidget {
  final int catId;
  final String catName;
  CategoryWiseJob({super.key, required this.catId, required this.catName});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(
          () => c.isJobLoading.value
              ? cardShimmer(size)
              : FutureBuilder<JobModel>(
                  future: HomeUtils.showJobByCategory(catId),
                  builder: (context, snapshot) => snapshot.hasData
                      ? snapshot.data!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Job Available in $catName',
                                style: normalLightText,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) =>
                                  jobCard(snapshot, index, size, false),
                            )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) => cardShimmer(size),
                        ),
                ),
        ),
      ),
    );
  }
}
