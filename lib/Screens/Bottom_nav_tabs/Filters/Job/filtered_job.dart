import 'package:spires_app/Constants/exports.dart';
import '../../../../Model/job_model.dart';

class FilteredJobs extends StatelessWidget {
  FilteredJobs({super.key});
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
          () => c.isJobLoading.value
              ? cardShimmer(size)
              : FutureBuilder<JobModel>(
                  future: JobsUtils.showJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data!.isEmpty) {
                        return Center(
                            child: Text('No Result found', style: normalText));
                      }
                      final List<Data> allJobs = snapshot.data!.data!;
                      List<Data> filteredJobs = allJobs;
                      if (c.jobType.isNotEmpty) {
                        filteredJobs = filteredJobs
                            .where((job) =>
                                c.jobType.contains(job.jobType) &&
                                int.parse(job.salary!.removeAllWhitespace
                                        .split('-')
                                        .first) >=
                                    c.minimumSalary.value &&
                                c.selectedCities.contains(job.location))
                            .toList();
                      }
                      if (filteredJobs.isEmpty) {
                        return Center(
                            child: Text('No results found', style: mediumText));
                      }
                      return ListView.builder(
                          itemCount: filteredJobs.length,
                          itemBuilder: (context, index) =>
                              filterJobCard(filteredJobs, index, size));
                    } else {
                      return loading;
                    }
                  }),
        ),
      ),
    );
  }
}

Widget filterJobCard(List<Data> filterData, int index, Size size) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.55,
                  child: Text(
                    item.jobTitle!,
                    style: mediumBoldText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
            Text(item.jobType!, style: smallLightText),
            const Spacer(),
            const Icon(Icons.payments, color: primaryColor, size: 16),
            const SizedBox(width: 8),
            Text('₹${int.parse(item.salary!) * 12} p.a.',
                style: smallLightText),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Image.asset(jobsfilled, height: 16),
            const SizedBox(width: 8),
            Text('${item.experience}+ years experience', style: smallLightText),
            const Spacer(),
            const Icon(Icons.location_on, color: primaryColor, size: 16),
            const SizedBox(width: 8),
            Text(item.location!, style: smallLightText),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            MyContainer(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.5, horizontal: defaultPadding),
              color: primaryColor.withOpacity(0.2),
              child: Text('Job', style: xsmallText),
            ),
            const Spacer(),
            InkWell(
              onTap: () => shareJobs(item.id!.toInt()),
              child: const Icon(Icons.share, size: 20),
            )
          ],
        ),
        const Divider(color: Colors.black26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.to(
                  () => FilteredJobDetails(snapshot: filterData, index: index)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('View Details', style: normalColorText),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
