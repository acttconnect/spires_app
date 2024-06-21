import '../../../Constants/exports.dart';

class HelpCentre extends StatefulWidget {
  const HelpCentre({super.key});

  @override
  State<HelpCentre> createState() => _HelpCentreState();
}

class _HelpCentreState extends State<HelpCentre> {
  final List<Map<String, String>> predefinedProfileQuestions = [
    {
      'question': 'How can I contact support?',
      'response': 'You can contact support at support@spiresrecruit.com.'
    },
    {
      'question': 'How do I create an account on this Spires Recruit?',
      'response':
          'To create an account on Spires Recruit, visit the Spires portal and make an impressive profile to present yourself effectively for job opportunities.'
    },
    {
      'question': 'How do I upload my resume or CV?',
      'response':
          'To upload your resume or CV, follow these steps : Go to Profile Section, Look for upload Resume section and upload your Resume from your desired location from Phone memory'
    },
    {
      'question': 'What should I do if I forget my password?',
      'response':
          'If you forget your password for the Spires portal, you can likely use a "Password Reminder" or "Forgot Password" link on the login page. This will trigger an email to be sent to you with instructions to reset your password.'
    },
    {
      'question': 'How do I edit/update my profile information?',
      'response':
          'To edit or update your profile information on the portal, log in to your account and navigate to the profile section. Look for an "Edit" or "Update Profile" option, where you can make changes to your information, such as experience, skills, and contact details.'
    },
  ];

  final List<Map<String, String>> predefinedJobQuestions = [
    {
      'question': 'How can I contact support?',
      'response': 'You can contact support at support@spiresrecruit.com.'
    },
    {
      'question': 'Can I apply for multiple jobs at once?',
      'response':
          'Yes, you can apply for multiple jobs simultaneously on the Spires portal if the platform allows it. Check the application process for each job and follow the instructions to apply for your desired positions.'
    },
    {
      'question':
          'How do I track the status of my job/Internship applications?',
      'response':
          'To track the status of your job or internship applications on the portal, log in to your account and navigate to a section that lists your submitted applications. Depending on the platform design, you might see the status of each application, such as "Under Review," "Interview Scheduled," or "Application Declined".'
    },
    {
      'question': 'Is there a way to save jobs/internship for later?',
      'response':
          'Yes, you can save jobs/internships for later on the Spires portal Job Listings: \nWhen viewing a job/internship listing, look for a "Save" or "Bookmark" option Save for Later: Clicking this option will save the listing to a designated section in your account.\nAccess Saved Listings: You can later access your saved listings to apply or review them.'
    },
  ];
  List<ChatMessage> messages = [];
  final _scrollController = ScrollController();
  bool isProfileQ = false;
  bool isJobQ = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Centre'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            ),
          ),
          const Divider(height: 1.0),
          isProfileQ || isJobQ ? Container() : buildSelectOption(),
          buildQuestionsList(),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget buildSelectOption() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: primaryColor.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('Please Select a Category in which you have issue.'),
          InkWell(
            onTap: () => setState(() => isProfileQ = true),
            child: Container(
              margin: const EdgeInsets.fromLTRB(defaultMargin * 0.75,
                  defaultMargin * 0.75, defaultMargin * 0.75, 0),
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: borderRadius,
              ),
              child: const Text('Profile Section'),
            ),
          ),
          InkWell(
            onTap: () => setState(() => isJobQ = true),
            child: Container(
              margin: const EdgeInsets.fromLTRB(defaultMargin * 0.75,
                  defaultMargin * 0.75, defaultMargin * 0.75, 0),
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: borderRadius,
              ),
              child: const Text('Job/Internship Section'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: isProfileQ
          ? predefinedProfileQuestions.length
          : isJobQ
              ? predefinedJobQuestions.length
              : 0,
      itemBuilder: (context, index) {
        final question = isProfileQ
            ? predefinedProfileQuestions[index]['question']
            : isJobQ
                ? predefinedJobQuestions[index]['question']
                : null;
        return InkWell(
          onTap: () => _handleQuestionTap(question),
          child: Container(
            margin: const EdgeInsets.fromLTRB(defaultMargin * 0.75,
                defaultMargin * 0.75, defaultMargin * 0.75, 0),
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: borderRadius,
            ),
            child: Text(question!, style: normalText),
          ),
        );
      },
    );
  }

  void _handleQuestionTap(String question) {
    // Find the corresponding response for the selected question
    final response = isProfileQ
        ? predefinedProfileQuestions.firstWhere(
            (item) => item['question'] == question,
            orElse: () =>
                {'response': 'I do not have an answer for that question.'},
          )['response']
        : isJobQ
            ? predefinedJobQuestions.firstWhere(
                (item) => item['question'] == question,
                orElse: () =>
                    {'response': 'I do not have an answer for that question.'},
              )['response']
            : null;

    // Add user question to the chat
    messages.add(ChatMessage(
      text: question,
      isUserMessage: true,
    ));

    // Add bot response to the chat
    messages.add(ChatMessage(
      text: response!,
      isUserMessage: false,
    ));

    setState(() {});

    // Scroll to the latest message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage(
      {super.key, required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: isUserMessage ? whiteColor : primaryColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          style: isUserMessage ? normalText : normalWhiteText,
        ),
      ),
    );
  }
}
