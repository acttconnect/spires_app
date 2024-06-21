import 'package:spires_app/Constants/exports.dart';

class SafetyTips extends StatelessWidget {
  const SafetyTips({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Tips'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.health_and_safety,
                      size: 75, color: primaryColor),
                  Text('Safety Tips', style: xLargeBoldColorText),
                  Text(
                    'At Spires Recruit, we are committed to making your online experience a safe and reliable one. The following information is designed to help internship/job seekers identify common red flags and avoid fraud.',
                    style: smallLightText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.black26),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Follow these safety tips while using Spires Connect Privacy Settings:\n Adjust your privacy settings to control who can view your profile and contact you.Use Strong Passwords: Create a strong, unique password for your account and update it regularly.Keep Personal Information Private: Avoid sharing sensitive personal information, such as your Social Security number or bank details, unless absolutely necessary.\nStay Informed: Keep yourself updated about common online scams and fraud tactics.Report Concerns: If you have concerns about any user or posting, report it to our support team.',
                      style: smallLightText),
                  // Text('Asking for personal and bank details',
                  //     style: mediumBoldText),
                  // const SizedBox(height: 8),
                  // Text(
                  //     "Be cautious of employers who ask for details like PIN, pan card, bank account, credit card, OTP, Aadhar, etc., via online channels, in exchange for a ‘special offer’. ",
                  //     style: smallLightText),
                  // const SizedBox(height: 4),
                  // Text(
                  //     "Legitimate employers would have had sufficient interaction with you through interviews and would have expressed interest in hiring you, before requesting personal information like bank account details, pan card and marksheets. ",
                  //     style: smallLightText),
                  // const SizedBox(height: 16),
                  // Text('Asking for Money', style: mediumBoldText),
                  // const SizedBox(height: 8),
                  // Text(
                  //     "If an employer asks you for money in the form of training fee, application/admission fee, security deposit, test fee, laptop fee, documentation fee, interview reservation fee, etc., please do not make any payment and report him/her immediatety. Charging money is not only a violation of Spires Recruit's rules, it is often a scam.",
                  //     style: smallLightText),
                  // const SizedBox(height: 16),
                  // Text('Discrepancy in job description', style: mediumBoldText),
                  // const SizedBox(height: 8),
                  // Text(
                  //     "An employer could offer you a different job than what you had applied for on Spires Recruit. If the job offered involves any of the following, please report it:",
                  //     style: smallLightText),
                  // const SizedBox(height: 4),
                  // buildPoints(size,
                  //     'Consuming alcohol or smoking or inducing others to do so'),
                  // const SizedBox(height: 4),
                  // const SizedBox(height: 4),
                  // buildPoints(size,
                  //     'Network-level marketing - where your only role is to promote or sell a product or service to your friends and family'),
                  // const SizedBox(height: 4),
                  // const SizedBox(height: 4),
                  // buildPoints(size,
                  //     'Consuming alcohol or smoking or inducing others to do so'),
                  // const SizedBox(height: 4),
                  // const SizedBox(height: 4),
                  // buildPoints(size, 'Gambling or related games'),
                  // const SizedBox(height: 4),
                  // const SizedBox(height: 4),
                  // buildPoints(size,
                  //     'Promoting explicit religious content, a particular religious personality, or a sect, etc'),
                  // const SizedBox(height: 4),
                  // const SizedBox(height: 16),
                  // Text('Refusal to pay stipend/salary or issue certificate',
                  //     style: mediumBoldText),
                  // const SizedBox(height: 8),
                  // Text(
                  //     "On Spires Recruit, jobs with CTC less than 2 LPA and unpaid internships are not allowed, unless explicitly mentioned so in the internship/job post. If you come across any such incident where the stipend/salary mentioned on Spires Recruit and the offer letter do not match, do notify us.",
                  //     style: smallLightText),
                  // const SizedBox(height: 4),
                  // Text(
                  //     "Legitimate employers would have had sufficient interaction with you through interviews and would have expressed interest in hiring you, before requesting personal information like bank account details, pan card and marksheets. ",
                  //     style: smallLightText),
                  // const SizedBox(height: 16),
                  // Text('Asking for irrelevant assignments',
                  //     style: mediumBoldText),
                  // const SizedBox(height: 8),
                  // Text(
                  //     "Any assignment that an employer asks you to do should assess your suitability for the role, and should be relevant to the profile.",
                  //     style: smallLightText),
                  // const SizedBox(height: 4),
                  // Text(
                  //     "Please report employers, if they asks you to do extremely lengthy assignments which may involve making business strategies for their company, writing multiple articles for their blog, promoting their social media accounts in your network, increasing downloads of their app, or designing multiple graphics for their company. These assignments may be a scheme by the company to get free work done.",
                  //     style: smallLightText),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildPoints(Size size, String point) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: defaultPadding),
          child: Icon(Icons.circle, size: 7),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: size.width - 40,
          child: Text(
            point,
            style: smallLightText,
          ),
        ),
      ],
    );
  }
}
