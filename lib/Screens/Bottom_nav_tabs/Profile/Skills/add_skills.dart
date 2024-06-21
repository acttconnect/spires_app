import '../../../../Constants/exports.dart';

class AddSkills extends StatelessWidget {
  AddSkills({super.key});
  final skillController = TextEditingController();
  final c = Get.put(SkillController());
  @override
  Widget build(BuildContext context) {
    c.showAllSkills();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Skills'),
      ),
      body: Obx(
        () => c.dataLoading.value
            ? loading
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: skillController,
                        onChanged: (val) {
                          c.count.value = val.length;
                          c.getfilteredSkills(c.skills, val);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Type your skills',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => c.count.value == 0
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: c.skills.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => Get.to(
                                      () => SkillLevel(skill: c.skills[index])),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: defaultMargin),
                                    padding:
                                        const EdgeInsets.all(defaultMargin),
                                    color: whiteColor,
                                    child: Text(
                                      c.skills[index],
                                      style: normalText,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: c.filteredSkills.length,
                                itemBuilder: (context, index) => c
                                        .filteredSkills.isEmpty
                                    ? const Center(
                                        child: Text('No Skills found'),
                                      )
                                    : InkWell(
                                        onTap: () => Get.to(() => SkillLevel(
                                            skill: c.filteredSkills[index])),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: defaultMargin),
                                          padding: const EdgeInsets.all(
                                              defaultMargin),
                                          color: whiteColor,
                                          child: Text(
                                            c.filteredSkills[index],
                                            style: normalText,
                                          ),
                                        ),
                                      ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
