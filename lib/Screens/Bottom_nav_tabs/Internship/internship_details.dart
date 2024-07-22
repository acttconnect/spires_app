import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../Constants/exports.dart';
import '../../../Model/internship_model.dart';

class InternshipDetails extends StatelessWidget {
  final AsyncSnapshot<InternshipModel> snapshot;
  final int index;
  InternshipDetails({super.key, required this.snapshot, required this.index});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final item = snapshot.data!.data![index];
    c.isInternshipSaved.value = item.isSaved!;
    c.isInternshipApplied.value = item.isApplied!;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Internship Details'),
      ),
      body: Obx(
        () => c.isInternshipLoading.value
            ? loading
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainCard(item),
                    const Divider(color: Colors.black26),
                    detailCard(item)
                  ],
                ),
              ),
      ),
    );
  }

  Container mainCard(Data item) {
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.internshipTitle!, style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(item.admin!.username!, style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(homeFilled, height: 16),
              const SizedBox(width: 8),
              Text(item.internshipType!, style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              ),
              const Spacer(),
              const Icon(Icons.location_on, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('${item.location}', style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ), ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.play_circle, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              const Text('Starts Immediately', style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ), ),
              const Spacer(),
              const Icon(Icons.calendar_month, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('${item.duration!} Months', style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ), ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.payments, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text('₹${item.stipend!}/month', style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ), ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MyContainer(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding * 0.5, horizontal: defaultPadding),
                color: primaryColor.withOpacity(0.2),
                child: const Text('Internship with job offer', style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ), ),
              ),
              const Spacer(),
              c.isInternshipSaved.value
                  ? InkWell(
                      onTap: () => InternshipUtils.unSaveInternship(
                          internId: item.id!.toInt()),
                      child: const Icon(Icons.bookmark_add,
                          size: 18, color: primaryColor),
                    )
                  : InkWell(
                      onTap: () => InternshipUtils.saveInternship(
                          internID: item.id!.toInt()),
                      child: const Icon(Icons.bookmark_outline,
                          size: 18, color: primaryColor),
                    ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => shareInternships(item.id!.toInt()),
                child: const Icon(Icons.share, size: 18),
              ),
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            )
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
          HtmlWidget(item.admin!.description!),
          const SizedBox(height: 8),
          const Text(
            'About the Internship',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            )
          ),
          HtmlWidget(item.aboutInternship!),
          const SizedBox(height: 8),
          const Text(
            'Skills & Qualification',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            )
          ),
          Text(item.skill!, style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          )),
          const SizedBox(height: 8),
          const Text(
            'Who can apply',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            )
          ),
          HtmlWidget(item.whoCanApply!),
          const SizedBox(height: 8),
          const Text(
            'Perks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            )
          ),
          Text(item.perks!, style: smallLightText),
          const SizedBox(height: 8),
          const Text(
            'Numbers of openings',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            )
          ),
          Text(item.openings!.toString(), style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          )),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.hourglass_top, size: 16, color: lightBlackColor),
              const SizedBox(width: 8),
              Text('Posted on ${item.startFrom}',
                style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.timer, size: 16, color: lightBlackColor),
              const SizedBox(width: 8),
              Text('Last date to Apply : ${item.lastDate}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          c.isInternshipApplied.value
              ? const MyContainer(
                  padding: EdgeInsets.all(defaultRadius),
                  width: double.infinity,
                  color: Colors.green,
                  child: Center(
                    child: Text('Already Applied',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            fontFamily: 'Poppins'
                        ), textAlign: TextAlign.center),
                  ),
                )
              : ElevatedButton(
                  onPressed: () => isValidToApply()
                      ? InternshipUtils.applyForInternship(
                          internId: item.id!.toInt())
                      : Container(),
                  child: const Text('Apply Now', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                    fontFamily: 'Poppins',
                  ),),
                ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
