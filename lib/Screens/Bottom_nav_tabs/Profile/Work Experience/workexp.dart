import 'package:spires_app/Model/exp_model.dart';
import '../../../../Constants/exports.dart';

class WorkExp extends StatelessWidget {
  WorkExp({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
              SvgPicture.asset(workExpIcon),
              const SizedBox(width: defaultPadding),
              Text('Work Experience', style: normalText),
              const Spacer(),
              InkWell(
                onTap: () => Get.to(() => AddExp()),
                child: SvgPicture.asset(addLIcon),
              ),
            ],
          ),
          const Divider(color: Colors.black12, thickness: 1),
          Obx(
            () => c.isExpLoading.value
                ? loadShimmer
                : FutureBuilder<ExpModel>(
                    future: ProfileUtils.showExperience(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.data!.isEmpty
                            ? emptyExp()
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context, index) =>
                                    ExpCard(snapshot: snapshot, index: index),
                              )
                        : loadShimmer,
                  ),
          ),
        ],
      ),
    );
  }

  emptyExp() {
    return Column(
      children: [
        Text(
          'Add Experience & boost your profile by 10%',
          style: smallLightText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ExpCard extends StatelessWidget {
  final AsyncSnapshot<ExpModel> snapshot;
  final int index;
  const ExpCard({super.key, required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    final item = snapshot.data!.data![index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(item.designation!, style: normalColorText),
            const SizedBox(width: defaultPadding),
            InkWell(
              onTap: () => Get.to(() => EditExp(
                    profile: item.designation!,
                    organisation: item.organization!,
                    location: item.location!,
                    startDate: item.startDate!,
                    endDate: item.endDate ?? '',
                    workDesc: item.description!,
                    expId: item.id!.toInt(),
                  )),
              child: SvgPicture.asset(editColorIcon, height: iconsize),
            ),
            const Spacer(),
            InkWell(
              onTap: () => deleteDialog(item.id!.toInt()),
              child: SvgPicture.asset(deleteIcon, height: iconsize),
            ),
          ],
        ),
        Text(
          item.organization!,
          style: smallLightText,
        ),
        Text(
          item.location!,
          style: smallLightText,
        ),
        Text(
          '${item.startDate} - ${item.endDate ?? 'currently working'}',
          style: smallLightText,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  deleteDialog(int expId) {
    return Get.defaultDialog(
      title: 'Delete',
      middleText: 'Are you sure to delete experience details?',
      confirm: myButton(
          onPressed: () => ProfileUtils.deleteExperience(expId: expId),
          label: 'Delete',
          color: primaryColor,
          style: normalWhiteText),
      cancel: myButton(
          onPressed: () => Get.back(),
          label: 'Cancel',
          color: whiteColor,
          style: normalLightText),
    );
  }
}
