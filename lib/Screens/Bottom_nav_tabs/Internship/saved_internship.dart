import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/internship_model.dart';

class SavedInternship extends StatelessWidget {
  SavedInternship({super.key});
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
                  future: InternshipUtils.showSavedInternship(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? snapshot.data!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Internships Saved',
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
