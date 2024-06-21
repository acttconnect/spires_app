import 'dart:convert';
import 'package:spires_app/Constants/exports.dart';
import 'package:http/http.dart' as http;

class MyController extends GetxController {
  //login or Signup
  RxBool isLoginLoading = false.obs;
  RxBool isRegLoading = false.obs;
  RxBool isotpLoading = false.obs;
  RxBool isemailLoading = false.obs;

  RxString otp = '0000'.obs;
  RxString myotp = '0000'.obs;
  //autologin
  RxString authEmail = ''.obs;
  RxString authPass = ''.obs;
  //bottom nav bar
  RxInt selectedIndex = 0.obs;
  //user data
  static int id = 0;
  static String userFirstName = '';
  static String userLastName = '';
  static String userEmail = '';
  static String userPhone = '';
  static String veriEmail = '';
  static String veriPhone = '';
  static String subscribed = '';
  RxString aboutMe = ''.obs;
  RxString profileImg = ''.obs;
  RxBool isSubscribed = false.obs;
  RxDouble progressValue = 0.00.obs;
  RxDouble emailPoints = 0.00.obs;
  RxDouble phonePoints = 0.00.obs;
  RxDouble aboutMePoints = 0.00.obs;
  RxDouble imgPoints = 0.00.obs;
  RxDouble expPoints = 0.00.obs;
  RxDouble eduPoints = 0.00.obs;
  RxDouble resumePoints = 0.00.obs;
  RxDouble skillPoints = 0.00.obs;
  RxBool isEmailVerified = false.obs;
  RxBool isPhoneVerified = false.obs;
  RxBool isEduEmpty = false.obs;
  RxBool isExpEmpty = false.obs;
  RxBool isCVEmpty = false.obs;
  RxBool isSkillsEmpty = false.obs;
  RxBool isAboutme = false.obs;
  RxString location = ''.obs;
  RxString city = ''.obs;
  var startDate = DateTime(1999).obs;
  getProgressValue() {
    progressValue.value = emailPoints.value +
        phonePoints.value +
        imgPoints.value +
        aboutMePoints.value +
        expPoints.value +
        eduPoints.value +
        resumePoints.value +
        skillPoints.value;
  }

  //jobs & Internship
  RxBool isJobLoading = false.obs;
  RxBool isInternshipLoading = false.obs;
  RxBool isJobSaved = false.obs;
  RxBool isJobApplied = false.obs;
  RxBool isInternshipSaved = false.obs;
  RxBool isInternshipApplied = false.obs;
  RxBool isLocationLoading = false.obs;
  RxBool isNearbyLoading = false.obs;
  RxInt allJob = 0.obs;
  RxInt allInternship = 0.obs;

  //user academic details
  RxBool isEduLoading = false.obs;
  RxBool isExpLoading = false.obs;
  RxBool isAboutLoading = false.obs;
  RxBool isCVLoading = false.obs;
  RxBool isDpLoading = false.obs;
  RxBool isPrefLoading = false.obs;

  //filters
  var isOffice = false.obs;
  var isPart = false.obs;
  var isFull = false.obs;
  var isRemote = false.obs;
  var isIOffice = false.obs;
  var isIPart = false.obs;
  var isIFull = false.obs;
  var isIRemote = false.obs;
  var selectedSalary = 0.obs;
  var minimumSalary = 0.obs;
  RxList<String> jobType = <String>[].obs;
  RxList<String> internshipType = <String>[].obs;
  RxList<String> selectedCities = <String>[].obs;
  RxBool isCompLoading = false.obs;
  RxList<CompanyModel> allCompanies = <CompanyModel>[].obs;

  Future<void> fetchCompanies() async {
    const url = '${apiUrl}company-list';
    isCompLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        final allData = (data['data'] as List)
            .map((company) => CompanyModel(
                companyName: company['username'], image: company['logo']))
            .toList();
        allCompanies.value = allData;
        isCompLoading.value = false;
      } else {
        isCompLoading.value = false;
      }
    } else {
      isCompLoading.value = false;
    }
  }
}

class CompanyModel {
  final String companyName;
  final String image;

  CompanyModel({required this.companyName, required this.image});
}
