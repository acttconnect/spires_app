import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:spires_app/Constants/exports.dart';
import 'package:pdf/widgets.dart' as pw;
import 'Widgets/contact_cv.dart';

class ResumeScreen extends StatelessWidget {
  ResumeScreen({super.key});
  final c = Get.put(MyController());
  final rc = Get.put(ResumeController());
  final bdColor = const Color(0xFF1E2027);
  final namebg = const Color(0xFFF2F1ED);
  final ScreenshotController screenshotController = ScreenshotController();
  final normalWhitePdfText =
      const pw.TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 16);
  final largeWhitePdfText =
      const pw.TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 20);
  final smallWhitePdfText =
      const pw.TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 14);
  final largeLightPdfText =
      const pw.TextStyle(color: PdfColor.fromInt(0xFF696969), fontSize: 20);
  final normalLightPdfText =
      const pw.TextStyle(fontSize: 16, color: PdfColor.fromInt(0xff696969));
  final mediumColorPdfText =
      const pw.TextStyle(fontSize: 18, color: PdfColor.fromInt(0xff696969));
  final xsmallLightPdfText =
      const pw.TextStyle(fontSize: 12, color: PdfColor.fromInt(0xff696969));
  final namebg1 = const PdfColor.fromInt(0xFFF2F1ED);
  final bdColor1 = const PdfColor.fromInt(0xFF1E2027);
  final primaryPdfColor = const PdfColor.fromInt(0xFFF38E27);
  final largeColorPdfText =
      const pw.TextStyle(color: PdfColor.fromInt(0xFFF38E27), fontSize: 18);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => rc.isSaving.value
              ? loading
              : Row(
                  children: [
                    Container(
                      width: size.width * 0.4,
                      height: size.height,
                      color: bdColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContactCV(),
                          const SizedBox(height: 8),
                          buildTitle('skills', largeWhiteText),
                          buildSkill(),
                          const SizedBox(height: 8),
                          buildTitle('values', largeWhiteText),
                          skillItem('Excellence'),
                          skillItem('Trust'),
                          skillItem('Integrity'),
                          skillItem('Accountability'),
                          const SizedBox(height: 8),
                          const Spacer(),
                          const Divider(color: whiteColor, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(fbWhiteIcon, height: 20),
                              SvgPicture.asset(globeIcon, height: 20),
                              SvgPicture.asset(githubIcon, height: 20),
                              SvgPicture.asset(linkedinIcon, height: 20),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.6,
                      height: size.height,
                      color: whiteColor,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.14,
                            color: namebg,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildTitle('Flutter Developer', largeLightText),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '${MyController.userFirstName} ${MyController.userLastName}'
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 21,
                                      letterSpacing: 1.20,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          buildTitle('Experience', largeText),
                          ExperienceItem(),
                          buildTitle('Education', largeText),
                          EducationItem(),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await ResumeController()
            .screenToPdf('cv', buildPdfOfResume(size, rc.pdfImg.value)),
        child: const Icon(Icons.download, color: whiteColor),
      ),
    );
  }

  buildSkill() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rc.allSkillList.length,
        itemBuilder: (context, index) =>
            skillItem(rc.allSkillList[index].skill));
  }

  skillItem(String skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 2,
            backgroundColor: whiteColor,
          ),
          const SizedBox(width: 8),
          Text(skill, style: normalWhiteText)
        ],
      ),
    );
  }

  buildPdfOfResume(Size size, String img) {
    return pw.Row(children: [
      pw.Container(
        width: 595 * 0.4,
        height: 842,
        color: bdColor1,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Column(
            children: [
              buildContact(size, img),
              pw.SizedBox(height: 12),
              buildPdfTitle('skills', largeWhitePdfText),
              pw.SizedBox(height: 12),
              buildPdfSkill(),
              pw.SizedBox(height: 24),
              buildPdfTitle('values', largeWhitePdfText),
              pw.SizedBox(height: 12),
              pdfSkillItem('Excellence'),
              pdfSkillItem('Trust'),
              pdfSkillItem('Integrity'),
              pdfSkillItem('Accountability'),
              pw.SizedBox(height: 12),
              pw.Spacer(),
              pw.Divider(color: const PdfColor(1, 1, 1), thickness: 1),
            ],
          ),
        ),
      ),
      pw.Container(
        width: 595 * 0.6,
        height: 842,
        color: const PdfColor.fromInt(0xffffffff),
        child: pw.Column(
          children: [
            pw.Container(
              height: size.height * 0.14,
              color: namebg1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  buildPdfTitle('Flutter Developer', largeLightPdfText),
                  pw.SizedBox(height: 12),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(12),
                    child: pw.Text(
                      '${MyController.userFirstName} ${MyController.userLastName}'
                          .toUpperCase(),
                      style: const pw.TextStyle(
                        fontSize: 21,
                        letterSpacing: 1.20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 12),
            buildPdfTitle('Experience', largeLightPdfText),
            pdfExperience(),
            buildPdfTitle('Education', largeLightPdfText),
            pdfEducation(),
          ],
        ),
      ),
    ]);
  }

  buildPdfIcon(String iconCode, double size) {
    return pw.Text(
      iconCode,
      style: pw.TextStyle(
        fontSize: size,
      ),
    );
  }

  buildPdfTitle(String label, pw.TextStyle style) {
    return pw.Row(
      children: [
        pw.Container(
          color: primaryPdfColor,
          height: 2,
          width: 35,
        ),
        pw.SizedBox(width: 8),
        pw.Text(label.toUpperCase(), style: style)
      ],
    );
  }

  buildContact(Size size, String imagePath) {
    return pw.Column(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4.0),
          child: pw.Image(
            pw.MemoryImage(
              File(rc.pdfImg.value).readAsBytesSync(),
            ),
            height: 842 * 0.25,
            width: 595 * 0.4,
            fit: pw.BoxFit.cover,
          ),
        ),
        pw.SizedBox(height: 12),
        buildPdfTitle('contact', largeWhitePdfText),
        pw.SizedBox(height: 12),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Email : ', style: smallWhitePdfText),
            pw.SizedBox(height: 4),
            pw.Text(MyController.userEmail,
                style: smallWhitePdfText, softWrap: true),
            pw.SizedBox(height: 8),
            pw.Text('Mobile : ', style: smallWhitePdfText),
            pw.SizedBox(height: 4),
            pw.Text(MyController.userPhone,
                style: smallWhitePdfText, softWrap: true),
          ],
        ),
      ],
    );
  }

  buildPdfSkill() {
    return pw.ListView.builder(
        itemCount: rc.allSkillList.length,
        itemBuilder: (context, index) =>
            pdfSkillItem(rc.allSkillList[index].skill));
  }

  pdfSkillItem(String skill) {
    return pw.Row(
      children: [
        pw.Container(
            height: 5,
            width: 5,
            decoration: pw.BoxDecoration(
              color: const PdfColor.fromInt(0xffffffff),
              borderRadius: pw.BorderRadius.circular(5),
            )),
        pw.SizedBox(width: 8),
        pw.Text(skill, style: normalWhitePdfText)
      ],
    );
  }

  pdfExperience() {
    return pw.ListView.builder(
      itemCount: rc.allExpList.length,
      itemBuilder: (context, index) => experiencePdfData(
          title: rc.allExpList[index].designation,
          organisation: rc.allExpList[index].organization,
          city: rc.allExpList[index].location,
          startDate: rc.allExpList[index].startDate,
          endDate: rc.allExpList[index].endDate ?? 'Currently working',
          description: rc.allExpList[index].desc),
    );
  }

  experiencePdfData(
      {required String title,
      required String organisation,
      required String city,
      required String startDate,
      String? endDate,
      required String description}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: largeColorPdfText,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            '$organisation - $city',
            style: normalLightPdfText,
          ),
          pw.Text(
            '$startDate - $endDate',
            style: normalLightPdfText,
          ),
          pw.SizedBox(height: 4),
          pw.Text(description, style: xsmallLightPdfText),
          pw.SizedBox(height: 8),
        ],
      ),
    );
  }

  pdfEducation() {
    return pw.ListView.builder(
      itemCount: rc.allEduList.length,
      itemBuilder: (context, index) => pdfEducationData(
          schoolName: rc.allEduList[index].collegName,
          course: rc.allEduList[index].degree,
          branch: rc.allEduList[index].stream,
          fromDate: rc.allEduList[index].startDate,
          endDate: rc.allEduList[index].endDate,
          percent: rc.allEduList[index].percent),
    );
  }

  pdfEducationData(
      {required String schoolName,
      required String course,
      required String branch,
      required String percent,
      required String fromDate,
      required String endDate}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            course,
            style: largeColorPdfText,
          ),
          pw.Row(
            children: [
              pw.Text(branch, style: normalLightPdfText),
              pw.SizedBox(width: 12),
              pw.Text(schoolName, style: normalLightPdfText),
            ],
          ),
          pw.Text('With $fromDate% aggregate', style: normalLightPdfText),
          pw.Row(
            children: [
              pw.Text(percent, style: normalLightPdfText),
              pw.SizedBox(width: 12),
              pw.Text(endDate, style: normalLightPdfText),
            ],
          ),
        ],
      ),
    );
  }
}
