import 'dart:convert';
import '../../Constants/exports.dart';
import 'package:http/http.dart' as http;

class FaqModel {
  final String ques;
  final String ans;
  RxBool isSelected;

  FaqModel({required this.ques, required this.ans, required this.isSelected});
}

class FaqController extends GetxController {
  RxList<FaqModel> faqData = <FaqModel>[].obs;
  RxBool isLoading = false.obs;
  getFaqs() async {
    const url = '${apiUrl}faq';
    isLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        final allData = (data['data'] as List)
            .map((e) => FaqModel(
                ques: e['question'], ans: e['answer'], isSelected: false.obs))
            .toList();
        faqData.value = allData;
        isLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        isLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
      isLoading.value = false;
    }
  }

  void handleTap(int index) {
    for (int i = 0; i < faqData.length; i++) {
      faqData[i].isSelected.value = (i == index);
    }
  }
}
