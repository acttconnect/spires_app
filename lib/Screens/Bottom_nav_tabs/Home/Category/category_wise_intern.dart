import 'package:spires_app/Model/internship_model.dart';
import '../../../../Constants/exports.dart';

class CategoryWiseIntern extends StatelessWidget {
  final int catId;
  final String catName;
  CategoryWiseIntern({super.key, required this.catId, required this.catName});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(
          () => c.isInternshipLoading.value
              ? cardShimmer(size)
              : FutureBuilder<InternshipModel>(
                  future: HomeUtils.getInternshipByCategory(catId),
                  builder: (context, snapshot) => snapshot.hasData
                      ? snapshot.data!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Internship Available in $catName',
                                style: normalLightText,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) =>
                                  internshipCard(snapshot, index, size),
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
