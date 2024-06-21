import '../../../../Constants/exports.dart';

class SkillLevel extends StatelessWidget {
  final String skill;
  final bool? isEditSkill;
  final int? skillID;
  SkillLevel({super.key, required this.skill, this.isEditSkill, this.skillID});
  final c = Get.put(SkillController());
  @override
  Widget build(BuildContext context) {
    List<String> skillLevels = ['Beginner', 'Intermediate', 'Advanced'];
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Skill Level'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Obx(
          () => c.isLoading.value
              ? loading
              : Column(
                  children: [
                    MyContainer(
                      color: lightBlackColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding,
                          horizontal: defaultPadding * 2),
                      child: Text(skill, style: mediumWhiteText),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'How would you rate yourself in $skill',
                      style: smallText,
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: skillLevels.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding),
                        child: RoundedContainer(
                          padding: const EdgeInsets.all(defaultPadding),
                          onTap: () => isEditSkill ?? false
                              ? c.editSkills(
                                  skill, skillLevels[index], skillID ?? 0)
                              : c.addSkills(skill, skillLevels[index]),
                          borderColor: primaryColor,
                          isImage: false,
                          child: Text(skillLevels[index],
                              textAlign: TextAlign.center,
                              style: normalColorText),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
