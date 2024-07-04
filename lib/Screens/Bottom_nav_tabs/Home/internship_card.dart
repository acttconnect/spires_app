import 'package:spires_app/Model/internship_model.dart';
import '../../../Constants/exports.dart';

class InternshipCard extends StatelessWidget {
  InternshipCard({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultMargin),
      color: primaryColor.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Internships",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () => c.selectedIndex.value = 2,
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 255,
            width: size.width,
            child: Obx(
              () => c.isInternshipLoading.value
                  ? cardShimmer(size)
                  : FutureBuilder<InternshipModel>(
                      future: InternshipUtils.showInternship(),
                      builder: (context, snapshot) => snapshot.hasData
                          ? snapshot.data!.data!.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Internships Available',
                                    style: normalLightText,
                                  ),
                                )
                              : CarouselSlider.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index, realIndex) =>
                                      internshipCard(snapshot, index, size),
                                  options: CarouselOptions(
                                    height: 278,
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    autoPlayInterval:
                                        const Duration(seconds: 8),
                                  ),
                                )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) =>
                                  cardShimmer(size),
                            )),
            ),
          ),
          const SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
