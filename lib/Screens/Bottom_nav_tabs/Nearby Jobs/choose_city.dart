import '../../../Constants/exports.dart';

class ChooseCity extends StatelessWidget {
  ChooseCity({super.key});
  final c = Get.put(NearbyJobController());
  final cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    c.getCities();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select City'),
      ),
      body: Obx(
        () => c.isDataLoading.value
            ? loading
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cityController,
                        onChanged: (val) {
                          c.count.value = val.length;
                          c.getFilteredCities(val);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Type your city name',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() =>
                          c.count.value == 0 ? allCities() : filteredCities())
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  ListView filteredCities() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: c.filteredCities.length,
      itemBuilder: (context, index) => c.filteredCities.isEmpty
          ? const Center(
              child: Text('No Result found'),
            )
          : InkWell(
              onTap: () => Get.to(() => NearbyJobs(
                  cityName: c.filteredCities[index].cityName,
                  isCityWise: true)),
              child: Container(
                margin: const EdgeInsets.only(bottom: defaultMargin),
                padding: const EdgeInsets.all(defaultMargin),
                color: whiteColor,
                child: Text(
                  c.filteredCities[index].cityName,
                  style: normalText,
                ),
              ),
            ),
    );
  }

  ListView allCities() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: c.cities.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Get.to(() =>
            NearbyJobs(cityName: c.cities[index].cityName, isCityWise: true)),
        child: Container(
          margin: const EdgeInsets.only(bottom: defaultMargin),
          padding: const EdgeInsets.all(defaultMargin),
          color: whiteColor,
          child: Text(
            c.cities[index].cityName,
            style: normalText,
          ),
        ),
      ),
    );
  }
}
