import 'package:spires_app/Constants/exports.dart';
import '../../../Model/category_model.dart';

class SearchPrefs extends StatefulWidget {
  const SearchPrefs({super.key});

  @override
  State<SearchPrefs> createState() => _SearchPrefsState();
}

class _SearchPrefsState extends State<SearchPrefs> {
  final prefController = TextEditingController();

  final c = Get.put(MyController());

  @override
  void initState() {
    super.initState();
    prefController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preference'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            CustomTextField(
                controller: prefController,
                hintText: 'Type areas you want to work',
                iconData: Icons.interests),
            prefController.text.isEmpty
                ? Container()
                : Obx(
                    () => c.isPrefLoading.value
                        ? loading
                        : FutureBuilder<JobCategoryModel>(
                            future: HomeUtils.getCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<Data> allData = snapshot.data!.data!;
                                List<Data> filteredData = allData;
                                if (prefController.text.isNotEmpty) {
                                  filteredData = filteredData
                                      .where((element) => element.name!
                                          .toLowerCase()
                                          .contains(prefController.text
                                              .toLowerCase()))
                                      .toList();
                                  if (filteredData.isEmpty) {
                                    return Center(
                                        child: Text('No results found',
                                            style: mediumText));
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: filteredData.length,
                                      itemBuilder: (context, index) =>
                                          filteredCard(
                                              filteredData, index, size));
                                } else {
                                  return Container();
                                }
                              } else {
                                return loading;
                              }
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  filteredCard(List<Data> data, int index, Size size) {
    final item = data[index];
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
}
