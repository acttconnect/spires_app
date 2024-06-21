import 'package:spires_app/Constants/exports.dart';
import '../../Widgets/custom_shape.dart';

class ResumePage extends StatelessWidget {
  ResumePage({super.key});

  final c = Get.put(ResumeController());
  final control = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('My Resume'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: CachedNetworkImageProvider(
                    '$imgPath/${control.profileImg}'),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${MyController.userFirstName} ${MyController.userLastName}',
              style: largeBoldText,
            ),
            const SizedBox(height: 8),
            Text(
              control.aboutMe.value,
              style: normalText,
            ),
            const SizedBox(height: 8),
            ContactInfo(
              icon: Icons.email,
              text: MyController.userEmail,
            ),
            ContactInfo(
              icon: Icons.phone,
              text: MyController.userPhone,
            ),
            const SizedBox(height: 8),
            const SectionTitle(title: 'Education'),
            EducationItem(),
            const SizedBox(height: 8),
            const SectionTitle(title: 'Experience'),
            ExperienceItem(),
            const SectionTitle(title: 'Skills'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: c.allSkillList.length,
              itemBuilder: (context, index) => SkillItem(index: index),
            ),
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: 150,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Custom Shape Container',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: largeBoldText,
    );
  }
}

class SkillItem extends StatelessWidget {
  final int index;
  SkillItem({super.key, required this.index});
  final c = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    final item = c.allSkillList[index];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.skill,
            style: normalWhiteText,
          ),
          Text(
            item.level,
            style: smallWhiteText,
          ),
        ],
      ),
    );
  }
}


// final pdf = pw.Document(); // Create a PDF document
//   bool isSaving = false;
//   void _generatePDF() {
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return _buildResumeContent(); // Build your resume content here
//         },
//       ),
//     );
//   }

//   void _showStatusMessage({required bool isSuccess}) {
//     final message = isSuccess ? 'PDF saved successfully!' : 'Error saving PDF.';
//     final color = isSuccess ? Colors.green : Colors.red;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//       ),
//     );
//   }

//   Future<void> _savePDF() async {
//     setState(() {
//       isSaving = true;
//     });

//     final bytes = await pdf.save();

//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/my_resume.pdf');
//     await file.writeAsBytes(bytes);

//     setState(() {
//       isSaving = false;
//     });

//     _showStatusMessage(isSuccess: true);
//   }


// pw.Widget _buildResumeContent() {
//   return pw.Container(
//     padding: const pw.EdgeInsets.all(16),
//     child: pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         // Profile section
//         pw.Row(
//           children: [
//             pw.Container(
//               width: 100,
//               height: 100,
//             ),
//             pw.SizedBox(width: 16),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   'John Doe',
//                   style: pw.TextStyle(
//                       fontSize: 24, fontWeight: pw.FontWeight.bold),
//                 ),
//                 pw.Text(
//                   'Mobile App Developer',
//                   style:
//                       const pw.TextStyle(fontSize: 18, color: PdfColors.grey),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         // Contact section
//         pw.SizedBox(height: 16),

//         // Education section
//         pw.SizedBox(height: 16),
//         _buildSectionTitle('Education'),
//         _buildExperienceItem(
//             'Bachelor of Computer Science', 'XYZ University', '2016 - 2020'),
//         // Experience section
//         pw.SizedBox(height: 16),
//         _buildSectionTitle('Experience'),
//         _buildExperienceItem('Flutter Developer', 'ABC Tech', '2020 - Present',
//             'Developed and launched Flutter applications.'),
//         _buildExperienceItem('Software Developer Intern', 'DEF Software',
//             'Summer 2019', 'Assisted in developing software solutions.'),
//         // Skills section
//         pw.SizedBox(height: 16),
//         _buildSectionTitle('Skills'),
//         _buildSkillItem('Flutter'),
//         _buildSkillItem('Dart'),
//         _buildSkillItem('UI/UX Design'),
//         _buildSkillItem('Git'),
//       ],
//     ),
//   );
// }

// pw.Widget _buildSectionTitle(String title) {
//   return pw.Text(
//     title,
//     style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
//   );
// }

// pw.Widget _buildExperienceItem(String title, String subtitle, String duration,
//     [String description = '']) {
//   return pw.Column(
//     crossAxisAlignment: pw.CrossAxisAlignment.start,
//     children: [
//       pw.Text(
//         title,
//         style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
//       ),
//       pw.Text(
//         '$subtitle  $duration',
//         style: const pw.TextStyle(color: PdfColors.grey),
//       ),
//       pw.SizedBox(height: 8),
//       pw.Text(description),
//       pw.SizedBox(height: 16),
//     ],
//   );
// }

// pw.Widget _buildSkillItem(String skill) {
//   return pw.Container(
//     padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//     margin: const pw.EdgeInsets.only(right: 8, bottom: 8),
//     decoration: pw.BoxDecoration(
//       color: const PdfColor.fromInt(0xFFF38E27),
//       borderRadius: pw.BorderRadius.circular(20),
//     ),
//     child: pw.Text(
//       skill,
//       style: const pw.TextStyle(color: PdfColors.white),
//     ),
//   );
// }