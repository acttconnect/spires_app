import 'package:spires_app/Constants/exports.dart';

class LoadingJob extends StatefulWidget {
  const LoadingJob({super.key});

  @override
  State<LoadingJob> createState() => _LoadingJobState();
}

class _LoadingJobState extends State<LoadingJob> {
  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Jobs'),
      ),
      body: Column(
        children: [
          MyContainer(
            color: whiteColor,
            margin: const EdgeInsets.all(defaultMargin),
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.my_location, color: primaryColor),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: size.width * 0.75,
                      child: Text(
                        'Showing nearby jobs based on: \n${c.location.value}',
                        style: smallText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          loading,
          Text('Please wait...', style: normalText)
        ],
      ),
    );
  }
}
