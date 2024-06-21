import 'package:spires_app/Model/edu_model.dart';
import '../../../../Constants/exports.dart';

class Education extends StatelessWidget {
  Education({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => c.isEduLoading.value
          ? loadShimmer
          : Container(
              width: size.width,
              margin: const EdgeInsets.fromLTRB(
                  defaultPadding, defaultPadding, defaultPadding, 0),
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(degreeIcon),
                      const SizedBox(width: defaultPadding),
                      Text('Education', style: normalText),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.to(() => AddEducation()),
                        child: SvgPicture.asset(addLIcon),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  FutureBuilder<EduModel>(
                    future: ProfileUtils.showEducation(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.data!.isEmpty
                            ? emptyEdu()
                            : EduCard(snapshot: snapshot)
                        : loadShimmer,
                  ),
                ],
              ),
            ),
    );
  }

  emptyEdu() {
    return Column(
      children: [
        Text(
          'Add Education & boost your profile by 10%',
          style: smallLightText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class EduCard extends StatelessWidget {
  final AsyncSnapshot<EduModel> snapshot;
  EduCard({super.key, required this.snapshot});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final item = snapshot.data!.data!;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data!.data!.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(item[index].degree!, style: normalColorText),
              const SizedBox(width: defaultPadding),
              InkWell(
                onTap: () => Get.to(() => EditEducation(
                      collegeName: item[index].name!,
                      stream: item[index].stream!,
                      degree: item[index].degree!,
                      start: item[index].startDate!,
                      end: item[index].endDate!,
                      percent: item[index].percentage!,
                      eduId: item[index].id!.toInt(),
                    )),
                child: SvgPicture.asset(editColorIcon, height: iconsize),
              ),
              const Spacer(),
              InkWell(
                onTap: () => deleteDialog(item[index].id!.toInt()),
                child: SvgPicture.asset(deleteIcon, height: iconsize),
              ),
            ],
          ),
          Text(
            item[index].stream!,
            style: normalText,
          ),
          Text(
            item[index].name!,
            style: smallLightText,
          ),
          Text(
            '${item[index].startDate} - ${item[index].endDate}',
            style: smallLightText,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  deleteDialog(int eduId) {
    return Get.defaultDialog(
        title: 'Delete',
        middleText: 'Are you sure to delete education details?',
        confirm: myButton(
            onPressed: () => ProfileUtils.deleteEducation(eduId: eduId),
            label: 'Delete',
            color: primaryColor,
            style: normalWhiteText),
        cancel: myButton(
            onPressed: () => Get.back(),
            label: 'Cancel',
            color: whiteColor,
            style: normalLightText));
  }
}
