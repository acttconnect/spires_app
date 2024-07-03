import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../Controllers/my_controller.dart';

class ProgramDetailScreen extends StatefulWidget {

  final String imageUrl;
  final String title;
  final String description;

  ProgramDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  Future<void> inquire(String programName, String userId) async {
    var headers = {
      'Authorization': 'Bearer sk-proj-lvOy2JU3EbHjOlkGjHMZT3BlbkFJbPIDfmDJQk89WcagsYgr'
    };

    var request = http.Request(
        'POST',
        Uri.parse('https://spiresrecruit.com/api/program-enquiry?program_name=$programName&user_id=$userId')
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
        title: const Text('Inquiry Sent', textAlign: TextAlign.center,),
        content: const Text('Your inquiry has been sent successfully', textAlign: TextAlign.center,),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ));
      print('Inquiry sent');
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('An error occurred while sending your inquiry'),
        actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('OK'))
        ],
      ));
    }
  }

  final c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imageUrl, height: 200, width: double.infinity, fit: BoxFit.fill),
            const SizedBox(height: 20),
            Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      inquire(widget.title, MyController.id.toString());
                    },
                    child: const Text('Inquiry Now', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
