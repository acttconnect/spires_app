import 'package:spires_app/Constants/exports.dart';

class JobFilter extends StatelessWidget {
  JobFilter({super.key});
  final c = Get.put(MyController());
  final cc = Get.put(NearbyJobController());
  final chipName = [
    'Show All',
    'Atleast 2 Lakhs',
    'Atleast 4 Lakhs',
    'Atleast 6 Lakhs',
    'Atleast 8 Lakhs',
    'Atleast 10 Lakhs'
  ];
  final miniSalary = [0, 200000, 400000, 600000, 800000, 1000000];
  @override
  Widget build(BuildContext context) {
    cc.getCities();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              jobType(c.isOffice, c.isPart, c.isFull, c.isRemote),
              MyContainer(
                padding: const EdgeInsets.all(defaultPadding * 1.5),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ANNUAL SALARY', style: normalText),
                    const SizedBox(height: 8),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chipName.length,
                      itemBuilder: (context, index) => ChipChoiceButton(
                        chipName: chipName[index],
                        minSalary: miniSalary[index],
                        index: index,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),
              MyContainer(
                padding: const EdgeInsets.all(defaultPadding * 1.5),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SELECT CITY (Choose Atleast one)', style: normalText),
                    const SizedBox(height: 8),
                    Obx(
                      () => cc.isDataLoading.value
                          ? loading
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cc.cities.length,
                              itemBuilder: (context, index) =>
                                  cityChip(cc.cities[index].cityName, size),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3,
                                mainAxisSpacing: 8,
                              ),
                            ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),
              myButton(
                  onPressed: () {
                    if (c.jobType.isNotEmpty) {
                      Get.to(() => FilteredJobs());
                    } else {
                      Fluttertoast.showToast(msg: 'Please select a job type');
                    }
                  },
                  label: 'Apply',
                  color: primaryColor,
                  style: normalWhiteText)
            ],
          ),
        ),
      ),
    );
  }

  Obx jobType(RxBool isoffice, RxBool isPart, RxBool isFull, RxBool isRemote) {
    return Obx(
      () => MyContainer(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text('JOB TYPE', style: normalText),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                    value: isoffice.value,
                    onChanged: (val) {
                      val!
                          ? c.jobType.add('In-office')
                          : c.jobType.remove('In-office');
                      isoffice.value = val;
                    }),
                Text('In-office', style: smallLightText)
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: isPart.value,
                    onChanged: (val) {
                      val!
                          ? c.jobType.add('Part Time')
                          : c.jobType.remove('Part Time');
                      isPart.value = val;
                    }),
                Text('Part Time', style: smallLightText)
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: isFull.value,
                    onChanged: (val) {
                      val!
                          ? c.jobType.add('Full Time')
                          : c.jobType.remove('Full Time');
                      isFull.value = val;
                    }),
                Text('Full Time', style: smallLightText)
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: isRemote.value,
                    onChanged: (val) {
                      val!
                          ? c.jobType.add('Remote')
                          : c.jobType.remove('Remote');
                      isRemote.value = val;
                    }),
                Text('Remote', style: smallLightText)
              ],
            ),
          ],
        ),
      ),
    );
  }

  cityChip(String label, Size size) {
    return Obx(
      () => Wrap(
        children: [
          ChoiceChip(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            label: c.selectedCities.contains(label)
                ? SizedBox(
                    width: size.width * 0.18,
                    child: Text(label, style: smallWhiteText),
                  )
                : SizedBox(
                    width: size.width * 0.18,
                    child: Text(label, style: smallText),
                  ),
            onSelected: (value) => value
                ? c.selectedCities.add(label)
                : c.selectedCities.remove(label),
            selected: c.selectedCities.contains(label),
            selectedColor: primaryColor,
          ),
        ],
      ),
    );
  }
}

class ChipChoiceButton extends StatelessWidget {
  ChipChoiceButton(
      {super.key,
      required this.chipName,
      required this.minSalary,
      required this.index});
  final String chipName;
  final int minSalary;
  final int index;
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        c.selectedSalary.value = index;
        c.minimumSalary.value = minSalary;
      },
      child: Obx(
        () => c.selectedSalary.value == index
            ? MyContainer(
                color: primaryColor,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(4),
                child: Text(chipName,
                    style: smallWhiteText, textAlign: TextAlign.center),
              )
            : MyContainer(
                color: Colors.black12,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(4),
                child: Center(
                  child: Text(chipName,
                      style: smallText, textAlign: TextAlign.center),
                ),
              ),
      ),
    );
  }
}
