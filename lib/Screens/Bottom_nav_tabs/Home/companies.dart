import 'dart:math';

import 'package:spires_app/Constants/exports.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  final c = Get.put(MyController());
  final random = Random();
  @override
  void initState() {
    super.initState();
    c.fetchCompanies();
  }

  Color generateRandomColor() {
    return Color.fromARGB(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trusted Companies'),
      ),
      body: Obx(
        () => c.isCompLoading.value
            ? loading
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: GridView.builder(
                  itemCount: c.allCompanies.length,
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: generateRandomColor(),
                      borderRadius: borderRadius,
                    ),
                    child: Text(
                      c.allCompanies[index].companyName,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: defaultPadding,
                      mainAxisSpacing: defaultPadding),
                ),
              ),
      ),
    );
  }
}
