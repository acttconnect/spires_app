import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:spires_app/Payment/razor_pay.dart';

import '../../Constants/exports.dart';
import '../../Controllers/my_controller.dart';

class ProgramDetailTest extends StatefulWidget {
  final c = Get.put(MyController());
  final String imageUrl;
  final String title;
  final String description;

  ProgramDetailTest({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  State<ProgramDetailTest> createState() => _ProgramDetailTestState();
}

class _ProgramDetailTestState extends State<ProgramDetailTest>
    with SingleTickerProviderStateMixin {
  Future<void> inquire(String programName, String userId) async {
    var headers = {
      'Authorization':
          'Bearer sk-proj-lvOy2JU3EbHjOlkGjHMZT3BlbkFJbPIDfmDJQk89WcagsYgr'
    };

    var request = http.Request(
      'POST',
      Uri.parse(
          'https://spiresrecruit.com/api/program-enquiry?program_name=$programName&user_id=$userId'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text(
            'Inquiry Sent',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          content: const Text(
            'Your inquiry has been sent successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      );
      print('Inquiry sent');
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Error', style: TextStyle(fontFamily: 'Poppins')),
          content: const Text(
            'An error occurred while sending your inquiry',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  final List<Testimonial> testimonials = [
    Testimonial(
      name: 'John Doe',
      text:
          "Nulla facilisi. Nullam laoreet odio a risus scelerisque, quis bibendum libero ultrices.",
      imageUrl: "assets/images/logo.png",
    ),
    Testimonial(
      name: 'Jane Doe',
      text:
          "Nulla facilisi. Nullam laoreet odio a risus scelerisque, quis bibendum libero ultrices.",
      imageUrl: "assets/images/logo.png",
    ),
    Testimonial(
      name: 'Alice Doe',
      text:
          "Nulla facilisi. Nullam laoreet odio a risus scelerisque, quis bibendum libero ultrices.",
      imageUrl: "assets/images/logo.png",
    ),
    Testimonial(
      name: 'Bob Doe',
      text:
          "Vestibulum pharetra enim non varius feugiat. Nunc et metus sed nulla fringilla mattis a quis orci.",
      imageUrl: "assets/images/logo.png",
    ),
  ];

  late TabController _tabController;
  late Razorpay _razorpay;

  TextEditingController amtController = TextEditingController();
  void openCheckout() async {
    var amount = num.parse(amtController.text) * 100;
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amount,
      'name': 'Spires Recruit',
      'description': 'Payment for enrolling to a program',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'Success: ${response.paymentId}');
    print('Payment Success');
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Error: ${response.code} - ${response.message}');
    print('Payment Error');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'External Wallet: ${response.walletName}');
    print('External Wallet');
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    // Set initial value for amount controller
    amtController.text = '834';
    amtController
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: amtController.text.length));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          physics: PageScrollPhysics(),
          padding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(text: 'Description'),
            Tab(text: 'Testimonials'),
            Tab(text: 'How it Works'),
            Tab(text: 'Talk to Us'),
          ],
        ),
      ),
      body: TabBarView(
        physics: PageScrollPhysics(),
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Image.asset(
                        widget.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Benefits of the Program',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '1. Lorem ipsum dolor sit amet,\n2. Aliquam vel risus ac nisl malesuada pellentesque. ices.\n3. Fusce consectetur tellus vel odio dapibus dignissim.\n4. Nullam et mi lacinia, ultricies ligula in, ultricies ligula in,\n5. ultricies ligula in. Vestibulum pharetra enim non varius feugiat. \n6. Nunc et metus sed nulla fringilla mattis a quis orci.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Adjust spacing as needed
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹834',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2 months plan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor:
                                WidgetStateProperty.all<Color>(primaryColor),
                          ),
                          onPressed: openCheckout,
                          child: const Text(
                              textAlign: TextAlign.center,
                              'Pay Now',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      // Container(
                      //   width: 100,
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      //         RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //       ),
                      //       backgroundColor:
                      //           WidgetStateProperty.all<Color>(primaryColor),
                      //     ),
                      //     onPressed: () {
                      //       inquire(widget.title, MyController.id.toString());
                      //     },
                      //     child: const Text(
                      //         textAlign: TextAlign.center,
                      //         'Inquiry Now', style: TextStyle(color: Colors.white)),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                viewportFraction: 1,
                scrollPhysics: BouncingScrollPhysics(),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: testimonials.map((testimonial) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            testimonial.imageUrl,
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            testimonial.name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              testimonial.text,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Introduction'),
                _buildParagraph(
                    'Welcome to Our Program! Learn how our program can benefit you.'),
                _buildSectionTitle('How It Works'),
                _buildStep(
                  stepNumber: 1,
                  title: 'Step 1: [Action]',
                  description: '[Purpose]',
                ),
                _buildStep(
                  stepNumber: 2,
                  title: 'Step 2: [Action]',
                  description: '[Purpose]',
                ),
                _buildStep(
                  stepNumber: 3,
                  title: 'Step 3: [Action]',
                  description: '[Purpose]',
                ),

                _buildSectionTitle('Key Features'),
                _buildFeature(
                  title: '[Feature Name]',
                  description: '[Explanation and Benefits]',
                ),
                _buildFeature(
                  title: '[Feature Name]',
                  description: '[Explanation and Benefits]',
                ),

                // _buildSectionTitle('Customer Testimonials'),
                // _buildTestimonial(
                //   customerName: 'Customer Name',
                //   quote: '[Testimonial Quote]',
                // ),

                // _buildSectionTitle('FAQs'),
                // _buildFAQ(
                //   question: '[Question 1]',
                //   answer: '[Answer]',
                // ),
                // _buildFAQ(
                //   question: '[Question 2]',
                //   answer: '[Answer]',
                // ),

                // _buildSectionTitle('Call to Action'),
                // _buildParagraph('Ready to get started? Sign Up Now or Contact Us.'),
                // Add buttons or contact information widgets here.

                SizedBox(height: 20.0),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Talk to Us',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Email: example@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Phone: +254 712 345 678',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Website: www.example.com',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Address: 1234 Example Street, Nairobi, Kenya',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Contact Us',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Testimonial {
  final String name;
  final String text;
  final String imageUrl;

  Testimonial({
    required this.text,
    required this.imageUrl,
    required this.name,
  });
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildParagraph(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 16.0),
    ),
  );
}

Widget _buildStep(
    {required int stepNumber,
    required String title,
    required String description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Step $stepNumber: $title',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8.0),
      Text(description),
      SizedBox(height: 16.0),
    ],
  );
}

Widget _buildFeature({required String title, required String description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8.0),
      Text(description),
      SizedBox(height: 16.0),
    ],
  );
}

Widget _buildTestimonial(
    {required String customerName, required String quote}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Customer Testimonial',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8.0),
      Text(
        '"$quote" - $customerName',
        style: TextStyle(fontSize: 14.0),
      ),
      SizedBox(height: 16.0),
    ],
  );
}

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
