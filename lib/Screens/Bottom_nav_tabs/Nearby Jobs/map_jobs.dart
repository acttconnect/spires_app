// ignore_for_file: must_be_immutable

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/nearby_job_model.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Nearby%20Jobs/google_map_jobs.dart';

class NearMapJobs extends StatelessWidget {
  NearMapJobs({super.key});

  final c = Get.put(NearbyJobController());

  final control = Get.put(MyController());

  double lat = LocationServices.latitude;

  double long = LocationServices.longitude;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Jobs'),
        leading: IconButton(
          onPressed: () => control.selectedIndex.value = 0,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => control.isLocationLoading.value
              ? loading
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FutureBuilder<NearbyJobModel>(
                    future:
                        JobsUtils.nearbyJobs(lat, long, c.radius.value.toInt()),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.data!.isEmpty
                            ? emptyCard(size)
                            : Column(
                                children: [
                                  locationCard(size),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.data!.length,
                                    itemBuilder: (context, index) =>
                                        nearbyJobCard(
                                            snapshot, index, size, false),
                                  ),
                                ],
                              )
                        : loading,
                  ),
                ),
        ),
      ),
    );
  }

  Column buildDistanceSlider() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding * 2, right: defaultRadius * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Radius (in km.)',
                style: normalText,
              ),
              // Text('${rad.value.toString()} km', style: mediumBoldText),
              Slider(
                  min: 1,
                  max: 6000,
                  label: 'Radius(in km.)',
                  thumbColor: primaryColor,
                  activeColor: primaryColor,
                  value: c.radius.value,
                  onChanged: (double val) {
                    c.radius.value = val;
                    // rad.value = val.round();
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Widget emptyCard(Size size) {
    return Column(
      children: [
        locationCard(size),
        Text(
          'No Nearby Jobs Available',
          style: normalLightText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  SizedBox enableLocation(Size size) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please enable your location services',
            style: normalLightText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          myButton(
            onPressed: () => LocationServices.getLocation(),
            label: 'Enable Location',
            color: primaryColor,
            style: smallWhiteText,
          )
        ],
      ),
    );
  }

  MyContainer locationCard(Size size) {
    return MyContainer(
      color: whiteColor,
      margin: const EdgeInsets.all(defaultMargin),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.my_location, color: primaryColor),
              const SizedBox(width: 12),
              SizedBox(
                width: size.width * 0.75,
                child: Text(
                  'Showing nearby jobs based on: \n${control.location.value}',
                  style: smallText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nearbyJobCard(AsyncSnapshot<NearbyJobModel> snapshot, int index,
      Size size, bool isNearby) {
    final item = snapshot.data!.data![index];
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
              Text('${item.experience}+ years experience',
                  style: smallLightText),
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
                onTap: () => Get.to(() => GoogleMapsJob(
                    lat: double.parse(item.admin!.latitude!),
                    long: double.parse(item.admin!.longitude!),
                    title: item.admin!.username!,
                    snippet: item.jobTitle!,
                    jobId: item.id!)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Image.asset(mapIcon, height: 25),
                      const SizedBox(width: 6),
                      Text('View on Google Map', style: normalColorText),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () =>
                    Get.to(() => JobDetails(snapshot: snapshot, index: index)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('View Details', style: normalColorText),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class JobDetails extends StatelessWidget {
  final AsyncSnapshot<NearbyJobModel> snapshot;
  final int index;
  JobDetails({super.key, required this.snapshot, required this.index});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final item = snapshot.data!.data![index];
    c.isJobSaved.value = item.isSaved! == 'true';
    c.isJobApplied.value = item.isApplied! == 'true';
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: Obx(
        () => c.isJobLoading.value
            ? loading
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainCard(item, size),
                    const Divider(color: Colors.black26),
                    detailCard(item)
                  ],
                ),
              ),
      ),
    );
  }

  Container mainCard(Data item, Size size) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
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
              Text('${item.experience}+ years experience',
                  style: smallLightText),
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
              c.isJobSaved.value
                  ? InkWell(
                      onTap: () => JobsUtils.unSaveJob(jobId: item.id!.toInt()),
                      child: const Icon(Icons.bookmark_add,
                          size: 18, color: primaryColor),
                    )
                  : InkWell(
                      onTap: () => JobsUtils.saveJob(jobId: item.id!.toInt()),
                      child: const Icon(Icons.bookmark_outline,
                          size: 18, color: primaryColor),
                    ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => shareJobs(item.id!.toInt()),
                child: const Icon(Icons.share, size: 18),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget detailCard(Data item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${item.admin!.username!.toUpperCase()}',
            style: mediumBoldText,
          ),
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse('https://${item.admin!.website}'));
            },
            child: Row(
              children: [
                Text('Website', style: smallColorText),
                const SizedBox(width: 8),
                const Icon(
                  Icons.link,
                  size: 18,
                  color: primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          HtmlWidget(
            item.admin!.description!,
          ),
          const SizedBox(height: 8),
          Text(
            'About the Job',
            style: mediumBoldText,
          ),
          const SizedBox(height: 4),
          HtmlWidget(item.aboutJob!),
          const SizedBox(height: 8),
          Text(
            'Skills Required',
            style: mediumBoldText,
          ),
          const SizedBox(height: 4),
          Text(item.skills!, style: smallLightText),
          const SizedBox(height: 8),
          Text(
            'Salary',
            style: mediumBoldText,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Probabtion:',
                style: normalBoldText,
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: 'Probation',
                    middleText:
                        'Probation is a period of trial where the employer gives you time to learn the skills required for the job, which helps you and the employer check whether you are suitable for the role.',
                  );
                },
                child: const Icon(Icons.help_outline,
                    size: 18, color: primaryColor),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text('Duration: ${item.probationDuration!} Months',
              style: smallLightText),
          const SizedBox(height: 4),
          Text('Salary during probabtion: ₹${item.probationSalary!}/month',
              style: smallLightText),
          const SizedBox(height: 4),
          Text(
            'After Probabtion',
            style: normalBoldText,
          ),
          const SizedBox(height: 4),
          Text('Annual CTC: ${int.parse(item.salary!) * 12} p.a.',
              style: smallLightText),
          const SizedBox(height: 4),
          Text(
            'Numbers of openings',
            style: mediumBoldText,
          ),
          const SizedBox(height: 4),
          Text(item.openings!.toString(), style: smallLightText),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.hourglass_top, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('Posted on ${item.postDate}', style: smallLightText),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.timer, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('Last date to apply : ${item.lastDate}',
                  style: smallLightText),
            ],
          ),
          const SizedBox(height: 8),
          c.isJobApplied.value
              ? MyContainer(
                  padding: const EdgeInsets.all(defaultRadius),
                  width: double.infinity,
                  color: Colors.green,
                  child: Center(
                    child: Text('Already Applied',
                        style: normalWhiteText, textAlign: TextAlign.center),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    isValidToApply()
                        ? JobsUtils.applyForJob(jobId: item.id!.toInt())
                        : Container();
                  },
                  child: Text('Apply Now', style: normalWhiteText),
                ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
