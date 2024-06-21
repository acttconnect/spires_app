import '../../../Constants/exports.dart';

class EducationItem extends StatelessWidget {
  EducationItem({super.key});
  final c = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: c.allEduList.length,
      itemBuilder: (context, index) => educationData(index),
    );
  }

  educationData(int index) {
    final item = c.allEduList[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.degree.toUpperCase(),
            style: mediumColorText,
          ),
          const SizedBox(height: 4),
          Text(
            '${item.stream} • ${item.collegName}',
            style: normalLightText,
          ),
          Text(
            '${item.startDate} • ${item.endDate}',
            style: smallLightText,
          ),
          const SizedBox(height: 4),
          Text(item.percent, style: smallLightText),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
