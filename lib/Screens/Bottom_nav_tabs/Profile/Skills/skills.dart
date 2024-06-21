import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/skill_model.dart';

class Skills extends StatelessWidget {
  Skills({super.key});
  final c = Get.put(SkillController());
  final control = Get.put(MyController());
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
              SvgPicture.asset(skillIcon),
              const SizedBox(width: defaultPadding),
              Text('Skills', style: normalText),
              const Spacer(),
              InkWell(
                onTap: () => Get.to(() => AddSkills()),
                child: SvgPicture.asset(addLIcon),
              ),
            ],
          ),
          const Divider(color: Colors.black12, thickness: 1),
          Obx(
            () => c.isLoading.value
                ? skillLoading()
                : FutureBuilder<SkillModel>(
                    future: c.showSkills(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? snapshot.data!.data!.isEmpty
                            ? emptySkill()
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    skillCard(snapshot, index),
                              )
                        : skillLoading(),
                  ),
          ),
        ],
      ),
    );
  }

  emptySkill() {
    return Column(
      children: [
        Text(
          'Add your skill to boost your profile by 10%',
          style: smallLightText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Row skillCard(AsyncSnapshot<SkillModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item.skill!, style: normalColorText),
                const SizedBox(width: defaultPadding),
                InkWell(
                  onTap: () => Get.to(() => SkillLevel(
                      skill: item.skill!,
                      isEditSkill: true,
                      skillID: item.id!.toInt())),
                  child: SvgPicture.asset(editColorIcon, height: iconsize),
                ),
              ],
            ),
            Text(item.skillLevel!, style: smallLightText),
            const SizedBox(height: 4),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () => c.deleteSkills(item.id!.toInt(), item.skill!),
          child: SvgPicture.asset(deleteIcon, height: iconsize),
        ),
      ],
    );
  }

  skillLoading() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: lightBlackColor,
          highlightColor: whiteColor,
          child: Container(
            color: Colors.black12,
            height: 10,
            width: 50,
          ),
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: lightBlackColor,
          highlightColor: whiteColor,
          child: Container(
            color: Colors.black12,
            height: 10,
            width: 50,
          ),
        ),
      ],
    );
  }
}
