import 'package:spires_app/Constants/exports.dart';

class InternshipFilter extends StatelessWidget {
  InternshipFilter({super.key});
  final c = Get.put(MyController());
  final cc = Get.put(NearbyJobController());
  final chipName = [
    'Show All',
    'Atleast 2000',
    'Atleast 4000',
    'Atleast 6000',
    'Atleast 8000',
    'Atleast 10000'
  ];
  final miniSalary = [0, 2000, 4000, 6000, 8000, 10000];
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
              internshipType(c.isIOffice, c.isIPart, c.isIFull, c.isIRemote),
              MyContainer(
                padding: const EdgeInsets.all(defaultPadding * 1.5),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Monthly Stipend'.toUpperCase(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: chipName.length,
                      itemBuilder: (context, index) => ChipChoiceButton(
                        chipName: chipName[index],
                        minSalary: miniSalary[index],
                        index: index,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 3),
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
                    Text('SELECT CITY', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    ),
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
                    if (c.internshipType.isNotEmpty) {
                      Get.to(() => FilteredInternship());
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please select a internship type');
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

  cityChip(String label, Size size) {
    return Obx(
      () => Wrap(
        children: [
          ChoiceChip(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            label: c.selectedCities.contains(label)
                ? SizedBox(
                    width: size.width * 0.17,
                    child: Text(label, style: smallWhiteText),
                  )
                : SizedBox(
                    width: size.width * 0.17,
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

  Obx internshipType(
      RxBool isoffice, RxBool isPart, RxBool isFull, RxBool isRemote) {
    return Obx(
      () => MyContainer(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text('INTERNSHIP TYPE', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                    value: isoffice.value,
                    onChanged: (val) {
                      val!
                          ? c.internshipType.add('In-office')
                          : c.internshipType.remove('In-office');
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
                          ? c.internshipType.add('Part Time')
                          : c.internshipType.remove('Part Time');
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
                          ? c.internshipType.add('Full Time')
                          : c.internshipType.remove('Full Time');
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
                          ? c.internshipType.add('Remote')
                          : c.internshipType.remove('Remote');
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
}
