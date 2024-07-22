import 'package:spires_app/Screens/Bottom_nav_tabs/Filters/Internship/internship_filter.dart';
import '../../../Constants/exports.dart';
import 'package:spires_app/Model/internship_model.dart';

class Internship extends StatefulWidget {
  final bool? allInternship;
  final bool? isDrawer;
  const Internship({super.key, this.allInternship, this.isDrawer});

  @override
  State<Internship> createState() => _InternshipState();
}

class _InternshipState extends State<Internship> {
  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internship'),
        leading: IconButton(
          onPressed: () =>
              widget.isDrawer ?? false ? Get.back() : c.selectedIndex.value = 0,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () => Get.to(() => InternshipFilter()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(
          () => c.isInternshipLoading.value
              ? cardShimmer(size)
              : FutureBuilder<InternshipModel>(
                  future: widget.allInternship ?? false
                      ? InternshipUtils.allInternship()
                      : InternshipUtils.showInternship(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? snapshot.data!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Internships Available',
                                style: normalLightText,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) =>
                                  internshipCard(snapshot, index, size),
                            )
                      : loading),
        ),
      ),
    );
  }
}

Widget internshipCard(
    AsyncSnapshot<InternshipModel> snapshot,
    int index,
    Size size,
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
                      item.internshipTitle!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(item.admin!.username!, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  )),
                ],
              ),
              InkWell(
                onTap: () => shareInternships(item.id!.toInt()),
                child: const Icon(Icons.share, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(homeFilled, height: 16),
              const SizedBox(width: 8),
              Text(item.internshipType!, style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
              const Spacer(),
              const Icon(Icons.location_on, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('${item.location}', style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.play_circle, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('Starts Immediately', style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
              const Spacer(),
              const Icon(Icons.calendar_month, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('${item.duration!} Months', style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.payments, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('₹${item.stipend!}/month', style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
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
                child: Text('Internship with job offer', style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                )),
              ),
              const Spacer(),
              // Example of share icon; adjust as per your design
              InkWell(
                onTap: () => shareInternships(item.id!.toInt()),
                child: const Icon(Icons.share, size: 20),
              ),
            ],
          ),
          const Divider(
            height: 10,
              color: Colors.black26),
          InkWell(
            onTap: () => Get.to(() => InternshipDetails(snapshot: snapshot, index: index)),
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

