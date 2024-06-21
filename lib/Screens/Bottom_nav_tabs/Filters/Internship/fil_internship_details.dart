import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:spires_app/Constants/exports.dart';
import '../../../../Model/internship_model.dart';

class FilteredInternshipDetails extends StatelessWidget {
  final List<Data> snapshot;
  final int index;
  FilteredInternshipDetails(
      {super.key, required this.snapshot, required this.index});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final item = snapshot[index];
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
          HtmlWidget(item.admin!.description!),
          const SizedBox(height: 8),
          Text(
            'About the Internship',
            style: mediumBoldText,
          ),
          HtmlWidget(item.aboutInternship!),
          const SizedBox(height: 8),
          Text(
            'Skills & Qualification',
            style: mediumBoldText,
          ),
          Text(item.skill!, style: smallLightText),
          const SizedBox(height: 8),
          Text(
            'Who can apply',
            style: mediumBoldText,
          ),
          HtmlWidget(item.whoCanApply!),
          const SizedBox(height: 8),
          Text(
            'Perks',
            style: mediumBoldText,
          ),
          Text(item.perks!, style: smallLightText),
          const SizedBox(height: 8),
          Text(
            'Numbers of openings',
            style: mediumBoldText,
          ),
          Text(item.openings!.toString(), style: smallLightText),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.hourglass_top, size: 16, color: lightBlackColor),
              const SizedBox(width: 8),
              Text('Posted on ${item.startFrom}', style: smallLightText),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.timer, size: 16, color: lightBlackColor),
              const SizedBox(width: 8),
              Text('Last date to Apply : ${item.lastDate}',
                  style: smallLightText),
            ],
          ),
          const SizedBox(height: 8),
          c.isInternshipApplied.value
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
                  onPressed: () => isValidToApply()
                      ? InternshipUtils.applyForInternship(
                          internId: item.id!.toInt())
                      : Container(),
                  child: Text('Apply Now', style: normalWhiteText),
                ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
