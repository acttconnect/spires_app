import 'package:spires_app/Model/job_model.dart';
import '../../../Constants/exports.dart';

class Jobs extends StatefulWidget {
  final bool? showAll;
  final bool? isDrawer;
  const Jobs({super.key, this.showAll, this.isDrawer});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        leading: IconButton(
          onPressed: () =>
              widget.isDrawer ?? false ? Get.back() : c.selectedIndex.value = 0,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => JobFilter()),
              icon: const Icon(Icons.filter_alt_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(
          () => c.isJobLoading.value
              ? cardShimmer(size)
              : FutureBuilder<JobModel>(
                  future: widget.showAll ?? false
                      ? JobsUtils.allJobs()
                      : JobsUtils.showJobs(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? snapshot.data!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Jobs Available',
                                style: normalLightText,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) =>
                                  jobCard(snapshot, index, size, false),
                            )
                      : loading,
                ),
        ),
      ),
    );
  }
}

Widget jobCard(
    AsyncSnapshot<JobModel> snapshot,
    int index,
    Size size,
    bool isNearby
    ) {
  final item = snapshot.data!.data![index];
  return Card(
    color: whiteColor,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(item.admin!.username!, style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  ),
                ],
              ),
              // Uncomment and update the below line if using CachedNetworkImage
              // CachedNetworkImage(
              //     imageUrl: '$imgPath/${item.admin!.logo!}',
              //     height: 65,
              //     width: 65),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(homeFilled, height: 16),
              const SizedBox(width: 8),
              Text(item.jobType!, style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              ),
              const Spacer(),
              const Icon(Icons.payments, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('₹${int.parse(item.salary!) * 12} p.a.', style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(jobsfilled, height: 16),
              const SizedBox(width: 8),
              Text('${item.experience}+ years experience', style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              ),
              const Spacer(),
              const Icon(Icons.location_on, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text(item.location!, style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MyContainer(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.5,
                  horizontal: defaultPadding,
                ),
                color: primaryColor.withOpacity(0.2),
                child: const Text('Job', style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => shareJobs(item.id!.toInt()),
                child: const Icon(Icons.share, size: 20),
              ),
            ],
          ),
          const Divider(color: Colors.black26),
          InkWell(
            onTap: () => Get.to(() => JobDetails(snapshot: snapshot, index: index)),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('View Details', style: normalColorText),
            ),
          ),
        ],
      ),
    ),
  );
}
