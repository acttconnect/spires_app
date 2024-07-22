import 'package:spires_app/Model/job_model.dart';
import '../../../Constants/exports.dart';

class JobCard extends StatelessWidget {
  JobCard({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => c.selectedIndex.value = 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jobs",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                InkWell(
                  onTap: () => c.selectedIndex.value = 4,
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 240,
            width: double.infinity,
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
                                    // enlargeCenterPage: true,
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
        ],
      ),
    );
  }
}
