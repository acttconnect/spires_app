import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Drawer/search_pref.dart';
import '../../../Model/category_model.dart';
import '../../../Model/pref_model.dart';

class Preferences extends StatelessWidget {
  Preferences({super.key});
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Obx(
        () => c.isPrefLoading.value
            ? loading
            : FutureBuilder<JobCategoryModel>(
                future: HomeUtils.getCategories(),
                builder: (context, snapshot) => snapshot.hasData
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Your Preferences', style: xLargeColorText),
                              Text('Area of Interest', style: mediumText),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => Get.to(() => const SearchPrefs(),
                                    transition: Transition.rightToLeftWithFade),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.75),
                                  margin: const EdgeInsets.only(
                                      bottom: defaultPadding),
                                  decoration: BoxDecoration(
                                      borderRadius: borderRadius,
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.interests),
                                      SizedBox(width: 8),
                                      Text('Search areas you want to work')
                                    ],
                                  ),
                                ),
                              ),
                              FutureBuilder<PrefModel>(
                                future: HomeUtils.showPref(),
                                builder: (context, snapshot) => snapshot.hasData
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.data!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            selectedCategory(
                                                snapshot, index, size),
                                      )
                                    : Container(),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    categoriesCard(snapshot, index, size),
                              ),
                            ],
                          ),
                        ),
                      )
                    : loading),
      ),
    );
  }

  selectedCategory(AsyncSnapshot<PrefModel> snapshot, int index, Size size) {
    final item = snapshot.data!.data![index];
    return InkWell(
      onTap: () => HomeUtils.removeFromPref(item.id!.toInt()),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        margin: const EdgeInsets.only(bottom: defaultPadding),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(defaultCardRadius * 2),
        ),
        width: size.width * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.category!.name!,
              style: normalWhiteText,
            ),
            const SizedBox(width: 8),
            const Icon(Icons.close, size: 20, color: whiteColor),
          ],
        ),
      ),
    );
  }
}

categoriesCard(AsyncSnapshot<JobCategoryModel> snapshot, int index, Size size) {
  final item = snapshot.data!.data![index];
  return InkWell(
    onTap: () => HomeUtils.addToPref(item.id!.toInt()),
    child: Container(
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.only(bottom: defaultPadding),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defaultCardRadius * 2),
          border: Border.all(color: Colors.black12)),
      width: size.width * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name!,
            style: normalText,
          ),
          const SizedBox(width: 8),
          const Icon(Icons.add, size: 20),
        ],
      ),
    ),
  );
}
