import '../../../Constants/exports.dart';

class Profile extends StatelessWidget {
  Profile({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileCard(),
              const SizedBox(height: defaultPadding),
              ProgressCard(),
              AboutMeCard(),
              WorkExp(),
              Education(),
              Skills(),
              CvCard(),
            ],
          ),
        ),
      ),
    );
  }
}
