import 'dart:convert';
import 'package:spires_app/Constants/exports.dart';
import 'package:http/http.dart' as http;
import 'package:spires_app/Model/job_model.dart';

class CityModel {
  final String cityName;
  CityModel({required this.cityName});
}

class JobsModel {
  final int jobId;
  final String jobTitle;
  final String jobType;
  final String postDate;
  final String experience;
  final String aboutJob;
  final String location;
  final String salary;
  final String skill;
  final String openings;
  final String probSalary;
  final String probDuration;
  final String lastDate;
  final bool isApplied;
  final bool isSaved;
  final String companyName;
  final String cEmail;
  final String website;
  final String logo;
  final String industry;
  final String cDescription;
  final String jobPosted;
  final String hired;
  final String hiringSince;
  final String lat;
  final String long;

  JobsModel(
      {required this.lat,
      required this.long,
      required this.jobId,
      required this.jobTitle,
      required this.jobType,
      required this.postDate,
      required this.experience,
      required this.aboutJob,
      required this.location,
      required this.salary,
      required this.skill,
      required this.openings,
      required this.probSalary,
      required this.probDuration,
      required this.lastDate,
      required this.isApplied,
      required this.isSaved,
      required this.companyName,
      required this.cEmail,
      required this.website,
      required this.logo,
      required this.industry,
      required this.cDescription,
      required this.jobPosted,
      required this.hired,
      required this.hiringSince});
}

class NearbyJobController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool isNLoading = false.obs;
  RxInt count = 0.obs;
  RxList<CityModel> cities = <CityModel>[].obs;
  RxList<CityModel> filteredCities = <CityModel>[].obs;
  RxList<JobsModel> jobs = <JobsModel>[].obs;

  RxDouble radius = 350.0.obs;
  Future<void> getCities() async {
    isDataLoading.value = true;
    const url = '${apiUrl}showLocation';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        List<CityModel> allCity = (data['data'] as List)
            .map((e) => CityModel(cityName: e['location']))
            .toList();
        cities.value = allCity;
        isDataLoading.value = false;
      } else {
        isDataLoading.value = false;
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      isDataLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  getFilteredCities(String query) {
    filteredCities.value = cities.where((e) {
      final inputText = query.toLowerCase();
      final cit = e.cityName.toLowerCase();
      return cit.contains(inputText);
    }).toList();
  }

  Future<JobModel> showNearbyJobs(String cityName) async {
    final url =
        '${apiUrl}getMatchingJobs?location=$cityName&user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return JobModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  Future<void> getJobs() async {
    final url =
        '${apiUrl}job?user_id=${MyController.id}&latitude=0.0&longitude=0.0&radius=0';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        List<JobsModel> allJobs = (data['data'] as List)
            .map((e) => JobsModel(
                lat: e['admin']['latitude'],
                long: e['admin']['longitude'],
                jobId: e['id'],
                jobTitle: e['job_title'],
                jobType: e['job_type'],
                postDate: e['post_date'],
                experience: e['experience'],
                aboutJob: e['about_job'],
                location: e['location'],
                salary: e['salary'],
                skill: e['skills'],
                openings: e['openings'],
                probSalary: e['probation_salary'],
                probDuration: e['probation_duration'],
                lastDate: e['last_date'],
                isApplied: e['is_applied'],
                isSaved: e['is_saved'],
                companyName: e['admin']['username'] ?? 'Aditya Birla',
                cEmail: e['admin']['email'],
                website: e['admin']['website'],
                logo: e['admin']['logo'],
                industry: e['admin']['industry'],
                cDescription: e['admin']['description'],
                jobPosted: e['job_posted'] ?? '55',
                hired: e['candidate_hired'] ?? '25',
                hiringSince: e['date'] ?? '15 Aug 23'))
            .toList();
        jobs.value = allJobs;
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
