import 'dart:convert';
import 'package:spires_app/Constants/exports.dart';
import 'package:http/http.dart' as http;
import '../../../../Model/skill_model.dart';

class SkillController extends GetxController {
  final c = Get.put(MyController());
  final rc = Get.put(ResumeController());
  RxList<String> skills = <String>[].obs;
  RxBool isLoading = false.obs;
  RxBool dataLoading = false.obs;
  RxInt count = 0.obs;
  RxList<String> filteredSkills = <String>[].obs;

  addToSelectedSkills(String skill) {
    skills.remove(skill);
  }

  removeFromSelectedSkills(String skill) {
    skills.add(skill);
  }

  getfilteredSkills(List<String> allskills, String query) {
    filteredSkills.value = skills.where((element) {
      final ski = element.toLowerCase();
      final que = query.toLowerCase();
      return ski.contains(que);
    }).toList();
  }

  showAllSkills() async {
    const url = '${apiUrl}skill';
    dataLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        int count = data['data'].length;
        for (int i = 0; i < count; i++) {
          if (!skills.contains(data['data'][i]['skill'])) {
            skills.add(data['data'][i]['skill']);
          }
        }
        dataLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        dataLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(
        msg:
            'Internal server error ${response.statusCode} ${response.reasonPhrase}',
      );
      dataLoading.value = false;
    }
  }

  Future<void> addSkills(String skillName, String level) async {
    final url =
        '${apiUrl}addSkill?user_id=${MyController.id}&skill=$skillName&skill_level=$level';
    isLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        addToSelectedSkills(skillName);
        Get.back();
        Fluttertoast.showToast(msg: 'Added');
        isLoading.value = false;
      } else {
        Get.back();
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Skill already added');
      }
    } else {
      Get.back();
      isLoading.value = false;
      Fluttertoast.showToast(
        msg:
            'Internal server error ${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }

  Future<SkillModel> showSkills() async {
    final url = '${apiUrl}showSkill?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        data['data'].length == 0
            ? c.skillPoints.value = 0.00
            : c.skillPoints.value = 10.00;
        c.getProgressValue();
        List<SkillDetailModel> allData = (data['data'] as List)
            .map((e) =>
                SkillDetailModel(skill: e['skill'], level: e['skill_level']))
            .toList();
        rc.allSkillList.value = allData;
        return SkillModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
        msg:
            'Internal server error ${response.statusCode} ${response.reasonPhrase}',
      );
    }
    throw Exception('Unable to load data');
  }

  Future<void> editSkills(String skillName, String level, int skillId) async {
    final url =
        '${apiUrl}editSkill?user_id=${MyController.id}&skill=$skillName&skill_level=$level&quality_id=$skillId';
    isLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Saved');
        isLoading.value = false;
      } else {
        Get.back();
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Get.back();
      isLoading.value = false;
      Fluttertoast.showToast(
        msg:
            'Internal server error ${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }

  Future<void> deleteSkills(int skillId, String name) async {
    final url =
        '${apiUrl}deleteSkill?user_id=${MyController.id}&quality_id=$skillId';
    isLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        removeFromSelectedSkills(name);
        Get.back();
        Fluttertoast.showToast(msg: 'Skills Deleted');
        isLoading.value = false;
      } else {
        Get.back();
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Get.back();
      isLoading.value = false;
      Fluttertoast.showToast(
        msg:
            'Internal server error ${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }
}
