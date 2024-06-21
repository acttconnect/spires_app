import 'package:spires_app/Constants/exports.dart';

class ExperienceItem extends StatelessWidget {
  ExperienceItem({super.key});
  final c = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: c.allExpList.length,
      itemBuilder: (context, index) => experienceData(index),
    );
  }

  experienceData(int index) {
    final item = c.allExpList[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.designation.toUpperCase(),
            style: mediumColorText,
          ),
          const SizedBox(height: 4),
          Text(
            '${item.organization} • ${item.location}',
            style: normalLightText,
          ),
          Text(
            '${item.startDate} • ${item.endDate ?? 'currently working'}',
            style: normalLightText,
          ),
          const SizedBox(height: 4),
          Text(item.desc, style: xsmallLightText),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

