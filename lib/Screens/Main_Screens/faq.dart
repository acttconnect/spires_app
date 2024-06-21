import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Screens/Main_Screens/faq_controller.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key});

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  final c = Get.put(FaqController());
  @override
  void initState() {
    c.getFaqs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ'S"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Obx(
          () => c.isLoading.value
              ? loading
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: c.faqData.length,
                  itemBuilder: (context, index) => buildFaqs(size, index),
                ),
        ),
      ),
    );
  }

  Widget buildFaqs(Size size, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: defaultPadding,
      ),
      child: GestureDetector(
        onTap: () => c.handleTap(index),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Obx(
            () => AnimatedContainer(
              height: c.faqData[index].isSelected.value
                  ? c.faqData[index].ans.length > 50
                      ? 150
                      : 60
                  : c.faqData[index].ques.length > 50
                      ? 60
                      : 45,
              padding: const EdgeInsets.all(defaultPadding),
              curve: Curves.easeInOut,
              color: whiteColor,
              duration: const Duration(seconds: 1),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: size.width - 65,
                            child: Text(c.faqData[index].ques,
                                style: smallBoldText, maxLines: 2)),
                        const Spacer(),
                        c.faqData[index].isSelected.value
                            ? const Icon(
                                Icons.minimize_outlined,
                                size: 14,
                                color: primaryColor,
                              )
                            : const Icon(
                                Icons.add_rounded,
                                size: 14,
                                color: primaryColor,
                              ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: c.faqData[index].isSelected.value,
                      child: Text(
                        c.faqData[index].ans,
                        style: smallLightText,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
