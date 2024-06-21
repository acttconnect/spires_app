import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Drawer/program_Details.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/program_detail_test.dart';
import 'package:spires_app/Screens/Main_Screens/main_screen.dart';

import '../../../Constants/exports.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Programs"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: ListView(
          children: [
            ProgramCard(
              imageUrl: 'assets/icons/1.png',
              title: 'SkillUp 1.0',
              description: 'SkillUp Mississippi is a program that helps Mississippians get the skills they need to get a job. It is a partnership between the Mississippi Community College Board and the Mississippi Department of Employment Security.',
              onShare: () {
                // Handle share action
              },
            ),
            ProgramCard(
              imageUrl: 'assets/icons/2.png',
              title: 'Interview Preparation',
              description: 'MS Works is a program that helps Mississippians get the skills they need to get a job. It is a partnership between the Mississippi Community College Board and the Mississippi Department of Employment Security.',
              onShare: () {
                // Handle share action
              },
            ),
            ProgramCard(
              imageUrl: 'assets/icons/3.png',
              title: 'Resume Workshop',
              description: 'MS Works is a program that helps Mississippians get the skills they need to get a job. It is a partnership between the Mississippi Community College Board and the Mississippi Department of Employment Security.',
              onShare: () {
                // Handle share action
              },
            ),
            ProgramCard(
              imageUrl: 'assets/icons/jsdh.png',
              title: 'Coding Clubs',
              description: 'A coding clubs is a vibrant community where individuals of all skill levels come together to explore the fascinating world of programming. It\'s a place to learn new languages, build cool projects, share knowledge, and foster a passion for technology. Whether you\'re a beginner taking your first steps in code or an experienced developer seeking collaboration, a coding club offers a supportive and inspiring environment to grow your skills and connect with fellow enthusiasts.',
              onShare: () {
                // Handle share action
              },
              fit: BoxFit.fill,
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
    final String whatsappUrl = "whatsapp://send?text=${Uri.encodeFull(message)}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onShare;
  final BoxFit fit;

  const ProgramCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onShare,
    this.fit = BoxFit.cover,
  }) : super(key: key);

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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProgramDetailTest(
          imageUrl: widget.imageUrl,
          title: widget.title,
          description: widget.description,
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: primaryColor),
                ),
                // leading: Image.asset('assets/icons/graduation-hat.png', width: 28, height: 20),
                leading: const Icon(Icons.school,color: primaryColor,),
                trailing: IconButton(
                  icon:  Icon(Icons.arrow_forward_ios, color: primaryColor, size: 18,),
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
                          isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
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
                      widget.shareOnWhatsApp("Check out this program: ${widget.title} - ${widget.description}");
                    },
                    child: Row(
                      children: [
                        // Image.asset('assets/icons/whatsapp.png',width: 18 , height: 18),
                        Icon(Icons.share, color: Colors.black, size: 16),
                        SizedBox(width: 5),
                        Text("Share", style: TextStyle(color: Colors.black, fontSize: 15)),
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
