import 'package:spires_app/Model/job_model.dart';
import '../../../Constants/exports.dart';

class JobCard extends StatelessWidget {
  JobCard({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: defaultMargin),
      color: primaryColor.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jobs",
                  style: mediumBoldText,
                ),
                InkWell(
                  onTap: () => c.selectedIndex.value = 3,
                  child: Text(
                    "View All",
                    style: smallLightText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 240,
            width: size.width,
            child: Obx(
              () => c.isJobLoading.value
                  ? cardShimmer(size)
                  : FutureBuilder<JobModel>(
                      future: JobsUtils.showJobs(),
                      builder: (context, snapshot) => snapshot.hasData
                          ? snapshot.data!.data!.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Jobs Available',
                                    style: normalLightText,
                                  ),
                                )
                              : CarouselSlider.builder(
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index, realIndex) =>
                                      jobCard(snapshot, index, size, false),
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    height: 256,
                                    autoPlayInterval:
                                        const Duration(seconds: 8),
                                  ),
                                )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  cardShimmer(size),
                            ),
                    ),
            ),
          ),
          const SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
