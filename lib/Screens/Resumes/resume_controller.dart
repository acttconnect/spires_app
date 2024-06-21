import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:spires_app/Constants/exports.dart';
import 'package:http/http.dart' as http;

class ResumeController extends GetxController {
  RxBool isSaving = false.obs;
  RxList<WorkExpModel> allExpList = <WorkExpModel>[].obs;
  RxList<EduDetailModel> allEduList = <EduDetailModel>[].obs;
  RxList<SkillDetailModel> allSkillList = <SkillDetailModel>[].obs;
  RxString pdfImg = ''.obs;
  final c = Get.put(MyController());

  Future<String> downloadImage() async {
    try {
      final response =
          await http.get(Uri.parse('$imgPath/${c.profileImg.value}'));
      if (response.statusCode == 200) {
        final directory = (await getTemporaryDirectory()).path;
        final filePath = '$directory/image.png';
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        pdfImg.value = file.path;
        return file.path;
      } else {
        throw Exception(
            'Failed to download image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to download image: $e');
    }
  }

  Future screenToPdf(String fileName, pw.Widget child) async {
    isSaving.value = true;
    pw.Document cv = pw.Document();
    cv.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: child,
          );
        },
      ),
    );
    String path = (await getTemporaryDirectory()).path;
    File pdfFile = await File('$path/$fileName.pdf').create();
    pdfFile.writeAsBytesSync(await cv.save());
    isSaving.value = false;
    OpenFile.open('$path/$fileName.pdf');
  }
}

//List for resume data with Models

class WorkExpModel {
  final String designation;
  final String organization;
  final String location;
  final String startDate;
  final String? endDate;
  final String desc;

  WorkExpModel(
      {required this.designation,
      required this.organization,
      required this.location,
      required this.startDate,
      this.endDate,
      required this.desc});
}

class EduDetailModel {
  final String collegName;
  final String degree;
  final String stream;
  final String startDate;
  final String endDate;
  final String percent;

  EduDetailModel(
      {required this.collegName,
      required this.degree,
      required this.stream,
      required this.startDate,
      required this.endDate,
      required this.percent});
}

class SkillDetailModel {
  final String skill;
  final String level;

  SkillDetailModel({required this.skill, required this.level});
}
