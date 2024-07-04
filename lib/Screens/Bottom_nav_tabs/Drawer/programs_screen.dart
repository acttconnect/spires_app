import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Drawer/program_Details.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/program_detail_test.dart';
import 'package:spires_app/Screens/Main_Screens/main_screen.dart';

import '../../../Constants/exports.dart';

class ProgramsScreen extends StatefulWidget {
  final bool? isDrawer;
  const ProgramsScreen({super.key, this.isDrawer});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Programs"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () =>
          widget.isDrawer ?? false ? Get.back() : c.selectedIndex.value = 0,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: ListView(
          children: [
            ProgramCard(
              imageUrl: 'assets/icons/1.png',
              title: 'SkillUp 1.0',
              description:
                  'Description:SkillUp 1.0 is your comprehensive training program designed to equip you with the essential skills and knowledge needed to land your dream internship or entry-level job. Through interactive modules, practical exercises, and industry expert insights, you\'ll gain the confidence and competence to impress employers.',
              benefits:
                  "• Gain valuable skills through interactive modules & practical exercises.\n• Build confidence with mock interviews, interview tips, & resume workshops.\n• Connect with industry professionals & gain insights into your dream career.\n• Get access to exclusive internship listings with top companies.\n• Receive personalized guidance & support from our career coaches.",
              onShare: () {
                // Handle share action
              },
              faqs: [
                {
                  'question': 'Is SkillUp 1.0 free?',
                  'answer': 'Yes, SkillUp 1.0 is completely free to access for all Spires Recruit users.'
                },
                {
                  'question': 'What skills can I learn through SkillUp 1.0?',
                  'answer': 'SkillUp 1.0 offers a variety of modules covering in-demand skills such as communication, problem-solving, teamwork, digital marketing, social media marketing, data analysis, and more.'
                },
                {
                  'question': 'How do I get access to exclusive internship listings?',
                  'answer': 'By completing relevant SkillUp 1.0 modules and demonstrating your skills, you\'ll gain access to a curated list of internship opportunities from top companies.'
                },
                {
                  'question': 'Will I receive a certificate upon completion?',
                  'answer': 'Yes, upon successful completion of a SkillUp 1.0 learning path, you\'ll receive a digital certificate to showcase your acquired skills to potential employers.'
                },
              ],
              howItWorks:
                  '1. Download the Spires Recruit app / website & create a free account.\n2. Select a learning path based on your career interests & desired skills.\n3. Work through interactive modules at your own pace, anytime, anywhere.\n4. Sharpen your skills with mock interviews & resume feedback.\n5. Network with companies and apply for exclusive internship opportunities.',
            ),
            ProgramCard(
              imageUrl: 'assets/icons/3.png',
              title: 'Resume Workshop',
              description:
              'Master the art of resume writing with our interactive Resume Workshop! Get expert guidance on building a compelling resume that stands out to hiring managers and lands you interviews.',
              benefits: '• Learn proven resume writing strategies.\n• Optimize your resume for Applicant Tracking Systems (ATS).\n• Tailor your resume for specific job applications.\n• Gain confidence in your resume writing skills.\n• Get feedback from career experts.\n• Network with other job seekers.',
              faqs: [
                {
                  'question': 'Is the Resume Workshop free?',
                  'answer': 'Yes, the Spires Recruit Resume Workshop is completely free to attend!'
                },
                {
                  'question': 'Who should attend the Resume Workshop?',
                  'answer': 'This workshop is beneficial for anyone seeking to improve their resume writing skills, from recent graduates to experienced professionals looking to make a career change.'
                },
                {
                  'question': 'What will I learn in the workshop?',
                  'answer': 'The workshop will cover a variety of topics, including resume structure, formatting, keyword optimization, crafting impactful achievements statements, and tailoring your resume for specific job applications.'
                },
                {
                  'question': 'How do I register for the workshop?',
                  'answer': 'Download the Spires Recruit app or visit our website (link) to find upcoming workshop dates and register.'
                },
              ],
              onShare: () {
                // Handle share action
              },
              howItWorks: '• Sign up for the free workshop through the Spires Recruit app / website.\n• Join our live, interactive workshop led by career development professionals.\n• Engage in interactive exercises and discussions to learn resume best practices.\n• Have the opportunity to receive personalized feedback on your resume during the workshop or through follow-up resources.',
            ),
            ProgramCard(
              imageUrl: 'assets/icons/2.png',
              title: 'Interview Preparation',
              description:'Nail your next interview with Spires Recruit\'s comprehensive Interview Preparation section! This interactive tool equips you with the knowledge and confidence to shine in any interview setting.',
              benefits: '• Boost confidence and reduce interview anxiety.\n• Learn effective strategies for answering common interview questions.\n• Practice your responses with interactive mock interview tools.\n• Receive personalized feedback to identify areas for improvement.\n• Gain insights into different interview formats and company cultures',
              faqs: [
                {
                  'question': 'What types of interview formats are covered?',
                  'answer': 'Spires Recruit covers various interview formats, including phone interviews, video interviews, and traditional in-person interviews.'
                },
                {
                  'question': 'How does the mock interview simulator work?',
                  'answer': 'The simulator provides a virtual interviewer and presents you with common interview questions. You can record your response and receive automated feedback on your body language, verbal delivery, and answer content.'
                },
                {
                  'question': 'Are there interview tips for different industries?',
                  'answer': 'Yes, we offer tailored interview prep resources for various industries, helping you understand industry-specific questions and expectations.'
                },
                {
                  'question': 'How can I access the Interview Preparation section?',
                  'answer': 'The Interview Preparation section is available within the Spires Recruit app. Download the app for free and explore all our resources designed to help you land your dream job!'
                },
              ],
              onShare: () {
                // Handle share action
              },
              howItWorks: '• Access a vast library of interview questions categorized by industry, job title & difficulty level.\n• Utilize our AI-powered mock interview simulator to practice your responses in a realistic setting.\n• Review detailed feedback reports on your mock interviews, highlighting strengths & areas for development./n• Watch informative video tutorials & read articles from industry professionals on interview best practices.',
            ),
            ProgramCard(
              imageUrl: 'assets/icons/jsdh.png',
              title: 'Coding Clubs',
              description:'The Spires Recruit Coding Club is a community for developers who are passionate about building and improving the Spires Recruit platform. We welcome coders of all experience levels, from beginners to seasoned professionals.',
              benefits: '• Work on real-world projects that utilize various coding skills and technologies.\n• Approach challenges creatively and find innovative solutions.\n• Get guidance and feedback from industry professionals.\n• Showcase your coding projects to potential employers.\n• Connect with other programmers who share your passion for coding.',
              faqs: [
                {
                  'question': 'Is there a cost to join the Spires Recruit Coding Club?',
                  'answer': 'No, the Spires Recruit Coding Club is completely free to join and participate in.'
                },
                {
                  'question': 'What coding experience level is required?',
                  'answer': 'The Spires Recruit Coding Club welcomes coders of all skill levels, from beginners to experienced programmers.'
                },
                {
                  'question': 'What programming languages are covered in the club?',
                  'answer': 'The Spires Recruit Coding Club covers a variety of popular programming languages, with the specific languages addressed depending on member interests and industry trends.'
                },
                {
                  'question': 'How do I find out about upcoming workshops and events?',
                  'answer': 'Announcements for upcoming workshops, challenges, and events will be posted within the Spires Recruit Coding Club forum and communicated through the Spires Recruit app.'
                },
              ],
              onShare: () {
                // Handle share action
              },
              fit: BoxFit.fill,
              howItWorks: '• Sign up for the Spires Recruit Coding Club through the Spires Recruit app / website.\n• Participate in weekly coding challenges designed to test and enhance your skills.\n• Attend regular online workshops and Q&A sessions hosted by industry experts.\n• Join discussions, share solutions, and get help from fellow club members.\n• Connect with other coders through the forum and participate in virtual coding meetups.',
            ),
            // Add more ProgramCard widgets as needed
          ],
        ),
      ),
    );
  }
}

class ProgramCard extends StatefulWidget {
  Future<void> shareOnWhatsApp(String message) async {
    final String whatsappUrl =
        "whatsapp://send?text=${Uri.encodeFull(message)}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  final String imageUrl;
  final String title;
  final String description;
  final String benefits;
  final String howItWorks;
  final List<Map<String,String>> faqs;
  final VoidCallback onShare;
  final BoxFit fit;

  const ProgramCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onShare,
    this.fit = BoxFit.cover,
    required this.benefits,
    required this.howItWorks,
    this.faqs=const [],
  }) : super(key: key);


  Widget _buildFAQ({required String question, required String answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Q: $question',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'A: $answer',
        ),
        SizedBox(height: 16.0),
      ],
    );
  }


  @override
  _ProgramCardState createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  bool isLiked = false;
  bool isSaved = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProgramDetailScreen(
        //       imageUrl: widget.imageUrl,
        //       title: widget.title,
        //       description: widget.description,
        //     ),
        //   ),
        // );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProgramDetailTest(
                      imageUrl: widget.imageUrl,
                      title: widget.title,
                      description: widget.description,
                      benefits: widget.benefits,
                      faqs: widget.faqs,
                      howItWorks: widget.howItWorks,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  widget.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: widget.fit,
                ),
              ),
              ListTile(
                title: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor),
                ),
                // leading: Image.asset('assets/icons/graduation-hat.png', width: 28, height: 20),
                leading: const Icon(
                  Icons.school,
                  color: primaryColor,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgramDetailScreen(
                          imageUrl: widget.imageUrl,
                          title: widget.title,
                          description: widget.description,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.5,
                height: 0,
                indent: 16,
                endIndent: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          isLiked
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          color: isLiked ? primaryColor : Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Like",
                          style: TextStyle(
                            color: isLiked ? primaryColor : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.shareOnWhatsApp(
                          "Check out this program: ${widget.title} - ${widget.description}");
                    },
                    child: Row(
                      children: [
                        // Image.asset('assets/icons/whatsapp.png',width: 18 , height: 18),
                        Icon(Icons.share, color: Colors.black, size: 16),
                        SizedBox(width: 5),
                        Text("Share",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: toggleSave,
                    child: Row(
                      children: [
                        Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_outline,
                          color: isSaved ? primaryColor : Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Save",
                          style: TextStyle(
                            color: isSaved ? primaryColor : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

