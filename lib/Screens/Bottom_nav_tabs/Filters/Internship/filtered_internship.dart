import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/internship_model.dart';

class FilteredInternship extends StatelessWidget {
  FilteredInternship({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(
          () => c.isInternshipLoading.value
              ? cardShimmer(size)
              : FutureBuilder<InternshipModel>(
                  future: InternshipUtils.showInternship(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data!.isEmpty) {
                        return Center(
                            child: Text('No Result found', style: normalText));
                      }
                      final List<Data> allInternship = snapshot.data!.data!;
                      List<Data> filteredInternship = allInternship;
                      if (c.internshipType.isNotEmpty) {
                        filteredInternship = filteredInternship
                            .where((e) =>
                                c.internshipType.contains(e.internshipType) &&
                                int.parse(e.stipend!.removeAllWhitespace
                                        .split('-')
                                        .first) >=
                                    c.minimumSalary.value &&
                                c.selectedCities.contains(e.location))
                            .toList();
                      }
                      if (filteredInternship.isEmpty) {
                        return Center(
                            child: Text('No results found', style: mediumText));
                      }
                      return ListView.builder(
                          itemCount: filteredInternship.length,
                          itemBuilder: (context, index) => filterInternshipCard(
                              filteredInternship, index, size));
                    } else {
                      return loading;
                    }
                  }),
        ),
      ),
    );
  }

  Widget filterInternshipCard(List<Data> filterData, int index, Size size) {
    final item = filterData[index];
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.only(
          bottom: defaultMargin, left: defaultMargin, right: defaultMargin),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          activelyHiring(),
          const SizedBox(height: 4),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.internshipTitle!, style: normalBoldText),
                  const SizedBox(height: 4),
                  Text(item.admin!.username!, style: normalLightText),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(homeFilled, height: 16),
              const SizedBox(width: 8),
              Text(item.internshipType!, style: smallLightText),
              const Spacer(),
              const Icon(Icons.location_on, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('${item.location}', style: smallLightText),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.play_circle, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('Starts Immediately', style: smallLightText),
              const Spacer(),
              const Icon(Icons.calendar_month, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('${item.duration!} Months', style: smallLightText),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.payments, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('₹${item.stipend!}/month', style: smallLightText),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MyContainer(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding * 0.5, horizontal: defaultPadding),
                color: primaryColor.withOpacity(0.2),
                child: Text('Internship with job offer', style: xsmallText),
              ),
              const Spacer(),
              InkWell(
                onTap: () => shareInternships(item.id!.toInt()),
                child: const Icon(Icons.share, size: 20),
              ),
            ],
          ),
          const Divider(
            color: Colors.black26,
          ),
          InkWell(
            onTap: () => Get.to(() =>
                FilteredInternshipDetails(snapshot: filterData, index: index)),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('View Details', style: normalColorText),
            ),
          )
        ],
      ),
    );
  }
}
