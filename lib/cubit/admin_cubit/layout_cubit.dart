import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/models/appointment_model.dart';
import 'package:reda3/models/time_appointment.dart';
import 'package:reda3/modules/admin/advert.dart';
import 'package:reda3/modules/doctor/add_article.dart';
import 'package:reda3/modules/doctor/an_appointment.dart';
import 'package:reda3/modules/doctor/appointment_doctor.dart';
import '../../models/Appointment_days.dart';
import '../../models/advert_model.dart';
import '../../models/appointment_mod.dart';
import '../../models/article_model.dart';
import '../../models/clinic_model.dart';
import '../../models/doctor_model.dart';
import '../../models/donation_model.dart';
import '../../models/noti_doctor_model.dart';
import '../../models/payment_model.dart';
import '../../models/profile_model.dart';
import '../../models/referal_model.dart';
import '../../models/secretariat_model.dart';
import '../../models/statistics_model.dart';
import '../../models/patient_detail.dart';
import '../../modules/admin/Patient_admin.dart';
import '../../modules/admin/add_clinic.dart';
import '../../modules/admin/add_doctor.dart';
import '../../modules/admin/add_secretariat.dart';
import '../../modules/admin/notification.dart';
import '../../modules/admin/clinics.dart';
import '../../modules/admin/dashboard.dart';
import '../../modules/admin/doctors.dart';
import '../../modules/admin/donation_screen.dart';
import '../../modules/admin/payments.dart';
import '../../modules/admin/profile.dart';
import '../../modules/admin/show_advert.dart';
import '../../modules/doctor/dashboard.dart';
import '../../modules/doctor/profile_screen.dart';
import '../../modules/doctor/referals.dart';
import '../../modules/doctor/show_articls.dart';
import '../../shared/components/constants/constant.dart';
import '../../shared/network/cach_network.dart';

enum UploadFileStatus { uploading, success, failure }

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState()) {}
  Timer? _timer;

  static LayoutCubit get(context) => BlocProvider.of(context);
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      noti = [];
      getNotiDoctor();
    });
  }

  final List<Widget> screen = [
    const Dashboard(),
    ProfileScreen(),
    const AddClinic(),
    const AddDoctor(),
    const AddSecretariat(),
    const Nots(),
    Advert(),
    AdvertShow(),
    Doctors(),
    Clinics(),
    PatientAdmin(),
    DonationScreen(),
    Payments()
  ];
  int selectedIndex = 5;

  void onChanged(index) {
    selectedIndex = index;
    emit(OnChangeScreenState());
  }



  String selectedOption = 'male';
  String selectedOptionType = 'center';
  void dropButtonTextFromFieldOnChange(String newValue) {
    selectedOption = newValue;
    emit(OnChangeScreenState());
  }


  File? pickedImage;
  Uint8List webImage = Uint8List(8);
  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      webImage = f;
      pickedImage = File('a');
      emit(ImagePickerGalleryState());
      // imagePath=image.path.toString();
    }
  }



//register
  void register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      Response response = await http.post(
        // request Url = base url + method url ( endpoint ) = https://student.valuxapps.com + /api/register
        Uri.parse('http://127.0.0.1:8000/api/admin/Adminregister'),
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        // print( data);
        var token = data['admin']['token'];
        debugPrint(token);

        if (data['message'] == "User successfully registered") {
          // debugPrint("Response is : $data");
          emit(RegisterSuccessState());
        } else {
          // debugPrint("Response is : $data");
          emit(FailedToRegisterState(message: data['message']));
        }
      }
    } catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

  //Login
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      print("jhhhhhhiiii");
      Response response = await http.post(
        // request => url = base url + method url

        Uri.parse('http://127.0.0.1:8000/api/login'),
        body: {'email': email, 'password': password},
      );
      print("00000000");
      if (response.statusCode == 200 //|| //response.statusCode==201
          ) {
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          token = responseData['token'];
          idRole = responseData['id'];
          print("idRole");
          // debugPrint("User login success and his Data is : ${responseData['data']['token']}");
          await CacheNetwork.insertToCache(
              key: "token", value: responseData['token']);
          // await CacheNetwork.insertToCacheInt(key: "role", value: responseData['user']['role_id']);
          roleId = responseData['user']['role_id'];
          idDoc = responseData['id'];
          print(responseData['user']['role_id']);
          emit(LoginSuccessState());
        } else {
          debugPrint("Failed to login, reason is : ${responseData['message']}");
          emit(FailedToLoginState(message: responseData['message']));
        }
      }
    } catch (e) {
      emit(FailedToLoginState(message: e.toString()));
    }
  }

  //add Clinic

  Future insertClinic(Uint8List img, String name, String clinic) async {
    try {
      emit(InsertClinicLoadingState());
      var headers = {'Authorization': 'Bearer ${token!}'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://127.0.0.1:8000/api/store'));
      request.fields.addAll({'clinic_name': name, 'description': clinic});
      // Uint8List data=await img.readAsBytes();
      List<int> list = img.cast();
      request.files.add(await http.MultipartFile.fromBytes('clinic_img', list,
          filename: 'myFile.png'));
      request.headers.addAll(headers);

      var response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        emit(InsertClinicSuccessState());
      } else {
        print(response.reasonPhrase);
        emit(FailedToInsertClinicState(
            message: response.reasonPhrase.toString()));
      }
    } catch (e) {
      emit(FailedToInsertClinicState(message: e.toString()));
    }
  }

  Future insertDoctor(
      {required String specializations,
      required String learningGrades,
      required String firstName,
      required String lastName,
      required String email,
      required String passwordCentre,
      required String userName,
      required String gender,
      required String address,
      required String phone,
      required String clinicsId,
      required Uint8List img}) async {
    try {
      emit(InsertDoctorLoadingState());
      var headers = {'Authorization': 'Bearer ${token!}'};
      //لازم تكون كلمة المرور8
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://127.0.0.1:8000/api/Doctorstore'));
      request.fields.addAll({
        'specialization': specializations,
        'learning_grades': learningGrades,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': passwordCentre,
        'UserName': userName,
        'gender': gender,
        'address': address,
        'phone': phone,
        'clinics_id': clinicsId,
      });
      List<int> list = img.cast();
      request.files.add(await http.MultipartFile.fromBytes('doctor_img', list,
          filename: 'myFile.png'));
      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        emit(InsertDoctorSuccessState());
      } else {
        print(response.reasonPhrase);
        emit(FailedToInsertDoctorState(
            message: response.reasonPhrase.toString()));
      }
    } catch (e) {
      emit(FailedToInsertDoctorState(message: e.toString()));
    }
  }

  Future insertSecretariat(
      {required String learningGrades,
      required String firstName,
      required String lastName,
      required String email,
      required String passwordCentre,
      required String userName,
      required String address,
      required String phone,
      required String gender,
      required String birth,
      required Uint8List img}) async {
    try {
      emit(InsertSecretariatLoadingState());
      var headers = {'Authorization': 'Bearer ${token!}'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://127.0.0.1:8000/api/addSecretary'));
      request.fields.addAll({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': passwordCentre,
        'UserName': userName,
        'address': address,
        'phone': phone,
        'learning_grades': learningGrades,
        'gender': gender,
        'birthdate': birth,
      });
      List<int> list = img.cast();
      request.files.add(await http.MultipartFile.fromBytes(
          'secretary_img', list,
          filename: 'myFile.png'));
      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        emit(InsertSecretariatSuccessState());
      } else {
        print(response.reasonPhrase);
        emit(FailedToInsertSecretariatState(
            message: response.reasonPhrase.toString()));
      }
    } catch (e) {
      emit(FailedToInsertSecretariatState(message: e.toString()));
    }
  }

  //
  Future profileCenter(Uint8List img, String centerName, String phone,
      String description) async {
    emit(ProfileLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token!}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/storeProfile'));
    request.fields.addAll({
      'center_name': centerName,
      'phone': phone,
      'description': description
    });
    // Uint8List data=await img.readAsBytes();
    List<int> list = img.cast();
    request.files.add(await http.MultipartFile.fromBytes('center_img', list,
        filename: 'myFile.png'));
    request.headers.addAll(headers);

    var response = await request.send();
    // response.stream.bytesToString().asStream().listen((event) {
    //   var parsedJson =json.decode(event);
    //   print(parsedJson);
    //   print(response.statusCode);
    // });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());
      getProfile();
      emit(ProfileSuccessState());
    } else {
      print(response.reasonPhrase);
      emit(FailedToInsertProfileState(
          message: response.reasonPhrase.toString()));
    }
  }

  List<Clinic> clinics = [];

  Future getClinic() async {
    emit(GetClinicsLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/showAllClinics"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("clinics Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['data']) {
        clinics.add(Clinic.fromJson(json: item));
      }
      emit(GetClinicsSuccessState());
      print(responseBody);
    } else {
      emit(FailedToGetClinicsState());
    }
  }

  IconData seffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changePasswordVisibility() {
    ispassword = !ispassword;
    seffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  //dropdownButtonSelection
  Clinic? selectedClinic;
  Clinic selectop(newClinic) {
    selectedClinic = clinics[0];
    selectedClinic = newClinic;

    emit(SelectOpDropDawnButton());
    return selectedClinic!;
  }

//dropdownButtonSelection
  Data? selectedDoctor;
  Data selectDoctor(newDoctor) {
    // selectedDoctor=doctors[0];
    selectedDoctor = newDoctor;

    emit(SelectOpDropDawnButton());
    return selectedDoctor!;
  }

  void onChangedDropDownButtonDoctor(newDoctor) {
    selectedDoctor = selectDoctor(newDoctor);
    emit(AccountListLoaded(doctors));
  }

  //dropdownButtonSelection
  AppointmentModel? selectedApp;
  AppointmentModel selectAppointment(newDoctor) {
    selectedApp = appointments[0];
    selectedApp = newDoctor;

    emit(SelectOpDropDawnButton());
    return selectedApp!;
  }

//

//
  List<ProfileModel> profileModel = [];
  ProfileModel? pro;
  Future getProfile() async {
    emit(GetProfileLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/ShowProfile"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("clinics Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['data']) {
        profileModel.add(ProfileModel.fromJson(json: item));
      }
      if (profileModel.isNotEmpty) {
        pro = profileModel.elementAt(profileModel.length - 1);
      }
      print("response is : $responseBody");
      emit(GetProfileSuccessState(pro));
      print(responseBody);
    } else {
      emit(FailedToGetProfileState());
    }
  }

  List<AppointmentModel> appointments = [];

  Future getAppointments() async {
    emit(GetAppointmentLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/getAppointments"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Appointment Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['data']) {
        appointments.add(AppointmentModel.fromJson(json: item));
      }
      emit(GetAppointmentSuccessState());
      print(responseBody);
    } else {
      emit(FailedToGetAppointmentState());
    }
  }

  //apointment
  Future insertAppointment(
      {required String idAppointment,
      required String idClinic,
      required String idDoctor}) async {
    emit(AppointmentLoadingState());
    try {
      print("lll");
      Response response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/Appointment_ClinicStore'),
          body: {
            'appointment_id': idAppointment,
            'clinics_id': idClinic,
            'doctors_id': idDoctor
          },
          headers: {
            'Authorization': 'Bearer ${token!}',
          });
      print("ee");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("99");
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          emit(AppointmentSuccessState());
        } else {
          debugPrint(
              "Failed to Appointment, reason is : ${responseData['message']}");
          emit(FailedToAppointmentState(message: responseData['message']));
        }
      }
    } catch (e) {
      emit(FailedToAppointmentState(message: e.toString()));
    }
  }

  Future insertAppointmentItem(
      {required String start,
      required String end,
      required String duration}) async {
    emit(AppointmentItemLoadingState());
    try {
      Response response = await http
          .post(Uri.parse('http://127.0.0.1:8000/api/AppointmentStore'), body: {
        'the_beginning_of_the_appointment': start,
        'the_end_of_the_appointment': end,
        'duration': duration
      }, headers: {
        'Authorization': 'Bearer ${token!}'
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          getAppointments();
          emit(AppointmentItemSuccessState());
        } else {
          debugPrint(
              "Failed to Apointment, reason is : ${responseData['message']}");
          emit(FailedToAppointmentItemState(message: responseData['message']));
        }
      }
    } catch (e) {
      emit(FailedToAppointmentItemState(message: e.toString()));
    }
  }

  List<PatientDetails> filteredRecord = [];
  void filterRecord({required String input}) {
    filteredRecord = r
        .where((element) =>
            element.firstName!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();

    emit(FilterRecordSuccessState());
  }

  List<Clinic> filteredClinics = [];
  void filterClinics({required String input}) {
    filteredClinics = clinics
        .where((element) =>
            element.clinicName!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterClinicsSuccessState());
  }

  List<Data> filteredDoctorsInClinic = [];
  void filterDoctorInClinic({required String input}) {
    if (input.isEmpty) {
      filteredDoctorsInClinic = doctorsInClinic;
    } else {
      filteredDoctorsInClinic = doctorsInClinic
          .where((element) =>
              element.userName!.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
    }

    emit(GetDoctorInClinicSuccessState(filteredDoctorsInClinic));
  }

  List<Data> doctorsInClinic = [];
  Future getDoctorsClinic(int id) async {
    emit(GetDoctorLoadState());

    Response response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/getDoctorByClinic/${id}"),
    );
    var responseBody = jsonDecode(response.body);
    print("Doctor Data is : $responseBody");
    print("kkkkkkkkkkkkkkkk");
    for (var item in responseBody) {
      doctorsInClinic.add(Data.fromJson(json: item));
    }
    filteredDoctorsInClinic = doctorsInClinic;
    print("kkkkkkkkkkkkkkkk");
    emit(GetDoctorInClinicSuccessState(filteredDoctorsInClinic));
    print(responseBody);
  }

  //secritaiate
  List<Secretariat> secretariat = [];
  List<Secretariat> parseSecretariat(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return List<Secretariat>.from(
        parsed.map((json) => Secretariat.fromJson(json: json)));
  }

  List<Secretariat> filteredSecretaraits = [];

  void filterSecretarait({required String input}) {
    if (input.isEmpty) {
      filteredSecretaraits = secretariat;
    } else {
      filteredSecretaraits = secretariat
          .where((element) =>
              element.userName!.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
    }
    emit(GetSecretariatSuccessState(filteredSecretaraits));
  }

  Future getSecretariat() async {
    emit(GetSecretariatLoadState());

    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/ShowSecretary"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Secretariat Data is : $responseBody");
    // loop list
    if (response.statusCode == 200) {
      final secretariats = parseSecretariat(response.body);

      secretariat = secretariats;
      filteredSecretaraits = secretariat;
      emit(GetSecretariatSuccessState(filteredSecretaraits));
    } else {
      emit(FailedToGetSecretariatState());
    }
  }

  Future<void> deleteSecretariat(String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token!}',
    };
    var request = http.Request('DELETE',
        Uri.parse('http://127.0.0.1:8000/api/Secretary/Secretarydelete/${id}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await getSecretariat();
      // emit(DeleteSecretariatSuccessfuly());
    } else {
      print(response.reasonPhrase);
      emit(DeleteSecretariatFail());
    }
  }

  List<Data> doctors = [];
  List<Data> parseAccounts(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return List<Data>.from(parsed.map((json) => Data.fromJson(json: json)));
  }

  List<Data> listDoctors = [];
  Future getListDoctor() async {
    emit(GetDoctorLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/showAllDoctors"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Doctor Data is : $responseBody");
    // final doctor = parseAccounts(response.body);
    // emit(AccountListLoaded(doctor));
    // loop list
    // if( responseBody['message'] == "Doctor added successfully"  )
    // {
    for (var item in responseBody['data']) {
      listDoctors.add(Data.fromJson(json: item));
    }
    emit(GetDoctorSuccessState());

    // }
    // else
    // {
    //   emit(FailedToGetDoctorState());
    // }
  }

  // filtered doctors
  List<Data> doctor = [];
  List<Data> filteredDoctors = [];
  void filterDoctor({required String input}) {
    if (input.isEmpty) {
      filteredDoctors = doctor;
    } else {
      filteredDoctors = doctor
          .where((element) =>
              element.userName!.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
    }

    emit(AccountListLoaded(filteredDoctors));
  }

  Future getDoctor() async {
    emit(GetDoctorLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/showAllDoctors"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Doctor Data is : $responseBody");
    if (response.statusCode == 200) {
      doctor = parseAccounts(response.body);

      filteredDoctors = doctor;
      emit(AccountListLoaded(filteredDoctors));
      emit(AccountListLoaded(doctor));
    }
  }

  Future<void> deleteDoctor(String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token!}',
    };
    var request = http.Request('DELETE',
        Uri.parse('http://127.0.0.1:8000/api/Doctor/Doctordelete/${id}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await getDoctor();
    } else {
      print(response.reasonPhrase);
      emit(DeleteDoctorFail());
    }
  }

  late TimeModel timeModel;
  var itemCount = 0;
  List<TimeModel> times = [];
  addEmployee(String from, String to) {
    try {
      timeModel = TimeModel(from: from, to: to, isbook: false);
      times.add(timeModel);
      itemCount = times.length;
      emit(InsertDataSuccessState());
      print(times.length);
      print(itemCount);
      if (itemCount < 0 || itemCount >= times.length) {
        throw RangeError.range(itemCount, 0, times.length - 1, 'index');
      }
    } catch (e) {
      print(e.toString());
    }
    emit(InsertDataSuccessState());
  }

  removeEmployee(int index) {
    times.removeAt(index);
    itemCount = times.length;
    emit(RemoveDataSuccessState());
  }

  List<Map<String, dynamic>> maps = [];
  void convertMap() {
    for (TimeModel model in times) {
      Map<String, dynamic> map = {
        'start_time': model.from,
        'end_time': model.to,
        'is_booked': model.isbook
      };
      maps.add(map);
    }
  }

  Future<void> sendAppointment(
      List<Map> t, String date, String visit, int id) async {
    // print("ll${maps}");
    var headers = {
      'Authorization': 'Bearer ${token!}',
      'Content-Type': 'application/json'
    };

    List time = [];

    for (int i = 0; i < maps.length; i++) {
      time.add({
        "start_time": maps[i]['start_time'],
        "end_time": maps[i]['end_time'],
        "is_booked": false
      });
    }
    print(time);

    emit(AddAppointmentLoadingState());
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/api/AppointmentStore'));
    for (int i = 0; i < t.length; i++) {
      request.body = json.encode({
        "appointment_date": date,
        "visit_type": visit,
        "doctor_id": id,
        "time_slots": time
      });
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(responseString);
      var appointmentData = responseJson;
      appointmentId = appointmentData['id'];
      print('Appointment ID: $appointmentId');
      emit(SuccessAddAppointmentState());

      // print(await response.stream.bytesToString());
      emit(SuccessAddAppointmentState());
    } else {
      print(response.reasonPhrase);
      emit(AddAppointmentErrorState());
    }
  }

  List<AdvertModel> adverts = [];
  List<AdvertModel> parseAdvert(String responseBody) {
    final parsed = jsonDecode(responseBody)['Advert'];
    return List<AdvertModel>.from(
        parsed.map((json) => AdvertModel.fromJson(json: json)));
  }

  Future getAdverts() async {
    emit(GetAdvertLoadState());
    Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/showWaitingAdverts2"),
        headers: {
          'Authorization': 'Bearer ${token!}',
        });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Advertss Data is : $responseBody");
    if (response.statusCode == 200) {
      final advert = parseAdvert(response.body);
      emit(GetAdvertsSuccessState(advert: advert));
      print(responseBody);
    } else {
      emit(FailedToGetAdvertsState());
    }
  }

  Future getAdvert() async {
    emit(GetAdvertLoadState());
    Response response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/showAd"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Advertss Data is : $responseBody");
    if (response.statusCode == 200) {
      final advertList = parseAdvert(response.body);
      emit(GetAdvertsSuccessState(advert: advertList));
      print(responseBody);
    } else {
      emit(FailedToGetAdvertsState());
    }
  }

  void advertApprove({required int id}) async {
    // emit(UpdateAdvertLoadingState());
    try {
      Response response = await http.post(
          // request => url = base url + method url
          Uri.parse('http://127.0.0.1:8000/api/update_advert_status/${id}'),
          body: {
            'status': 'approved'
          },
          headers: {
            'Authorization': 'Bearer ${token!}',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("kkk");
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          statusAdvert = responseData['data']['status'];
          await getAdverts();
          emit(UpdateAdvertSuccessState());
        } else {
          debugPrint(
              "Failed to Adverts, reason is : ${responseData['message']}");
          emit(FailedToLoginState(message: responseData['message']));
        }
      }
    } catch (e) {
      emit(FailedToUpdateAdvertState(message: e.toString()));
    }
  }

  void advertReject({required int id}) async {
    emit(UpdateAdvertLoadingState());
    try {
      Response response = await http.post(
          // request => url = base url + method url
          Uri.parse('http://127.0.0.1:8000/api/update_advert_status/${id}'),
          body: {
            'status': 'rejected'
          },
          headers: {
            'Authorization': 'Bearer ${token!}',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          await getAdverts();
          // statusAdvert=responseData['data']['status'];

          // emit(UpdateAdvertSuccessState());
        } else {
          debugPrint("Failed to login, reason is : ${responseData['message']}");
          emit(FailedToLoginState(message: responseData['message']));
        }
      }
    } catch (e) {
      emit(FailedToUpdateAdvertState(message: e.toString()));
    }
  }

//send file
  String? filePath;

  void openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
      emit(FileSendState());
    }
  }

  //doctor profile
  Data? doctorModel;

  String selectedOptiond = 'radiograph';
  void dropButtonTextFromFieldOnChanged(String newValue) {
    selectedOption = newValue;
    emit(OnChangeScreenState());
  }

  // static const String url = 'http://127.0.0.1:8000/api/profile/2';

  Future<Data> fetchProfileDoctor(int id) async {
    String url = 'http://127.0.0.1:8000/api/profile/$id';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${token!}', // تعديل وفقًا لمتطلبات الـ API الخاص بك
      },
    );

    if (response.statusCode == 200) {
      return Data.fromJson(json: json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> fetchProfile(int id) async {
    try {
      emit(ProfileLoading());
      final profile = await fetchProfileDoctor(id);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to fetch profile'));
    }
  }
  List<ArticleModel> article = [];
  void insertArticle(String title, String content) async {
    emit(InsertArticleLoadState());
    try {
      Response response = await http.post(
          // request => url = base url + method url
          Uri.parse('http://127.0.0.1:8000/api/store_Article/$idDoc'),
          body: {
            'title': title,
            'content': content
          },
          headers: {
            'Authorization': 'Bearer ${token!}',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(article.length);

        emit(InsertArticleSuccessState());
      }
    } catch (e) {
      emit(FailedToInsertArticleState());
    }
  }

  String? numVisit;
  Future fetchStatisticsNumVisit() async {
    emit(GetProfileLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/getVisitCount"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("clinics Data is : $responseBody");
    if (response.statusCode == 200) {
      numVisit = responseBody["visit_count"];
      print("response is : $numVisit");
      emit(GetProfileSuccessState(pro));
      print(responseBody);
    } else {
      emit(FailedToGetProfileState());
    }
  }

  String? numPatient;
  Future fetchStatisticsNumPatient() async {
    emit(GetProfileLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/getPatientCount"), headers: {
      'Authorization': 'Bearer ${token!}',
    });
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("patient num Data is : $responseBody");
    if (response.statusCode == 200) {
      numPatient = responseBody["patient_count"];
      print("response is : $numPatient");
      emit(GetProfileSuccessState(pro));
      print(responseBody);
    } else {
      emit(FailedToGetProfileState());
    }
  }

  String? mostFrequentAge;
  Future getMostFrequentAge() async {
    emit(GetProfileLoadState());
    Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/getMostFrequentAge"),
        headers: {
          'Authorization': 'Bearer ${token!}',
        });
    var responseb = response.body;
    // print(responseBody['photo']);
    print("mostFrequentAge Data is : $responseb");
    if (response.statusCode == 200) {
      mostFrequentAge = responseb;
      print("response is : $numVisit");
      emit(GetProfileSuccessState(pro));
      print(mostFrequentAge);
    } else {
      emit(FailedToGetProfileState());
    }
  }

  Future<void> fetchStatistics() async {
    try {
      final headers = {'Authorization': 'Bearer ${token!}'};
      final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/getMonthlyVisitStatistics'),
          headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final Map<String, double> dataMap = {
          for (var entry in data)
            'Month ${entry['month']}': entry['visit_percentage'].toDouble(),
        };
        emit(StatisticsLoaded(dataMap));
      } else {
        emit(StatisticsError('Failed to fetch data'));
      }
    } catch (e) {
      emit(StatisticsError('Failed to fetch data$e'));
    }
  }

  Future<void> fetchStatisticsP() async {
    try {
      final headers = {'Authorization': 'Bearer ${token!}'};
      final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/getMonthlyPatientStatistics'),
          headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final Map<String, double> dataMap = {
          for (var entry in data)
            'Month ${entry['month']}': entry['patient_percentage'].toDouble(),
        };
        emit(StatisticsLoaded(dataMap));
      } else {
        emit(StatisticsError('Failed to fetch data'));
      }
    } catch (e) {
      emit(StatisticsError('Failed to fetch data$e'));
    }
  }

  Future<void> onFetchAgeGroupStatistics() async {
    emit(AgeGroupStatisticsLoading());
    try {
      final headers = {'Authorization': 'Bearer ${token!}'};
      final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/getAgeGroupStatistics'),
          headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> ageGroupData = data
            .map((entry) => {
                  'age_group': entry['age_group'],
                  'count': entry['count'],
                  'percentage': entry['percentage'].toDouble(),
                })
            .toList();
        emit(AgeGroupStatisticsLoaded(ageGroupData));
      } else {
        emit(AgeGroupStatisticsError('Failed to fetch data'));
      }
    } catch (e) {
      emit(AgeGroupStatisticsError('Failed to fetch data: $e'));
    }
  }

  Future<void> insertDescriptionByDoctor(
      {required int idrec, required String des}) async {
    emit(InsertDescriptionLoadingState());
    try {
      Response response = await http.post(
          // request => url = base url + method url

          Uri.parse('http://127.0.0.1:8000/api/AddDescription/$idrec'),
          body: {
            'description': des,
          },
          headers: {
            'Authorization': 'Bearer ${token!}'
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("lllllllll");
        var responseData = jsonDecode(response.body);
        print(responseData);
        getRecord();
        emit(SuccessToInsertDescriptionState());
      }
    } catch (e) {
      emit(FailedToInserDescriptionState(e.toString()));
    }
  }

  List<ArticleModel> articles = [];

  Future getArticles() async {
    emit(GetArticlesLoadState());
    Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/show_articles/$idDoc"),
        headers: {
          'Authorization': 'Bearer ${token!}',
        });
    var responseBody = jsonDecode(response.body);
    print("Articles Data is.............. : $responseBody");
    if (response.statusCode == 200) {
      List<dynamic> articlesData = responseBody['articles'];
      var articlesList =
          articlesData.map((x) => ArticleModel.fromJson(x)).toList();
      articles.addAll(articlesList);
      // for( var item in responseBody['articles'])
      // {
      //   print(";l");
      //   print(responseBody['articles']);
      //   articles.add(ArticleModel.fromJson( item));
      //   print(articles);
      // }
      emit(GetArticlesSuccessState(articles));
      print(articles);
    } else {
      emit(FailedToGetArticlesState());
    }
  }

  final List<Widget> screenDoctor = [
    const DashboardDoctor(),
    const ProfileDoctor(),
    AppointmentDoctor(),
    const AddArticle(),
    const Referals(),
    Nots(),
    ShowArticle(),
    InsertAppointment()
  ];
  int selectedIndex1 = 2;

  List<PatientDetails> r = [];
//record
  Future getRecord() async {
    emit(GetClinicsLoadState());
    Response response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/allRecords"),
    );
    var responseBody = jsonDecode(response.body);
    print("clinics Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['data']) {
        r.add(PatientDetails.fromJson(item));
      }
      emit(SuccessToGetRecordsState());
      print(responseBody);
    } else {
      emit(FailedToGetRecordState());
    }
  }

  List<PatientDetails> rd = [];
  Future getRecordForDoctor() async {
    emit(GetClinicsLoadState());
    Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/showDoctorRecords"),
        headers: {
          'Authorization': 'Bearer ${token!}',
        });
    var responseBody = jsonDecode(response.body);
    print("getRecordForDoctor  is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['records']) {
        rd.add(PatientDetails.fromJson(item));
      }
      emit(SuccessToGetRecordsState());
      print(responseBody);
    } else {
      emit(FailedToGetRecordState());
    }
  }

  void fetchFiles(int idr) async {
    emit(FileLoading());
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/showFiles/$idr"),
        headers: {
          'Authorization': 'Bearer ${token!}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // التحقق من صحة البيانات
        if (data['X_ray'] is List && data['analysis'] is List) {
          final Map<String, List<String>> files = {
            'X_ray':
                List<String>.from(data['X_ray'].map((item) => item.toString())),
            'analysis': List<String>.from(
                data['analysis'].map((item) => item.toString())),
          };
          emit(FileLoaded(files));
        } else {
          print('Unexpected data format: $data');
          emit(FileError('Unexpected data format'));
        }
      } else {
        print('Failed to load files, status code: ${response.statusCode}');
        emit(FileError('Failed to load files'));
      }
    } catch (e) {
      print('An error occurred: $e');
      emit(FileError('An error occurred: $e'));
    }
  }

  void uploadFile(String apiUrl, List<String?> filePaths) async {
    try {
      emit(FileLoading());

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll({
        'Authorization': 'Bearer ${token!}',
        // 'Content-Type': 'multipart/form-data',
      });
      for (var path in filePaths) {
        if (path != null) {
          var file = await http.MultipartFile.fromPath('X_ray[]', path);
          request.files.add(file);
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        emit(SuccessToInsertFileState());
      } else {
        emit(FileError("kkkkkkk"));
      }
    } catch (e) {
      print('Error uploading file: $e');
      emit(FileError("llllllll"));
    }
  }

  void uploadAnalysisFile(String apiUrl, List<String?> filePaths) async {
    try {
      emit(FileLoading());

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll({
        'Authorization': 'Bearer ${token!}',
        // 'Content-Type': 'multipart/form-data',
      });
      for (var path in filePaths) {
        if (path != null) {
          var file = await http.MultipartFile.fromPath('analysis[]', path);
          request.files.add(file);
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        emit(SuccessToInsertFileState());
      } else {
        emit(FileError("kkkkkkk"));
      }
    } catch (e) {
      print('Error uploading file: $e');
      emit(FileError("llllllll"));
    }
  }
  List<AdvertModel> adv = [];

  Future fetchAdverto() async {
    emit(GetClinicsLoadState());
    Response response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/showAd"),
    );
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("clinics Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['Advert']) {
        adv.add(AdvertModel.fromJson(json: item));
      }

      emit(GetAdvertsShowingSuccessState(adv));
      print(responseBody);
    } else {
      emit(FailedToGetClinicsState());
    }
  }

  Future editadv(Uint8List img, String description, int id) async {
    emit(UpdateLoadState());
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token!}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/updateAdvert/$id'));
    request.fields.addAll({'description': description});
    // Uint8List data=await img.readAsBytes();
    List<int> list = img.cast();
    request.files.add(await http.MultipartFile.fromBytes('advert_image', list,
        filename: 'myFile.png'));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());
      await fetchAdverto();
      emit(UpdateSuccessState());
    } else {
      print(response.reasonPhrase);
      emit(FailedToUpdateState());
    }
  }

  List<String> weekDays = [];
  List<List<dynamic>> list = [];
  List<AppointmentM> appoint = [];

  Future<void> getAppointmentDayDoctor(
      {required String date, required int id}) async {
    emit(LoadToGetAppointmentDayDoctor());
    appoint.clear(); // إعادة تعيين القائمة لتجنب التكرار
    try {
      var headers = {'Content-Type': 'application/json'};
      Response response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/showDoctorAppointmentsByDay2/$idDoc'),
        body: jsonEncode({'date': date}),
        headers: headers,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data['appointments']) {
          appoint.add(AppointmentM.fromJson(item));
        }
        emit(SuccessToGetAppointmentDayDoctor());
      } else {
        emit(FailToGetAppointmentDayDoctor());
      }
    } catch (e) {
      debugPrint("Failed to getAppoint, reason: $e");
      emit(FailToGetAppointmentDayDoctor());
    }
  }

  List<AppointmentDay> days = [];

  Future<void> getDays() async {
    emit(LoadToGetDaysDoctor());
    try {
      Response response = await http.get(
        Uri.parse(
            "http://127.0.0.1:8000/api/showDoctorAppointmentsCenter/$idDoc"),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        days.clear(); // إعادة تعيين القائمة لتجنب التكرار
        for (var item in responseBody) {
          days.add(AppointmentDay.fromJson(json: item));
        }
        emit(SuccessToGetDaysDoctor());
      } else {
        emit(FailToGetDaysDoctor());
      }
    } catch (e) {
      debugPrint("Failed to get days, reason: $e");
      emit(FailToGetDaysDoctor());
    }
  }

  var idx = 1;
  onChangeIdx(int index) {
    idx = index;
    emit(GetDaysSuccessState());
  }

  void sendReferal({required String idRecord, required String idDoctor}) async {
    emit(LoadToSendReferal());
    try {
      Response response = await http.post(
        // request Url = base url + method url ( endpoint ) = https://student.valuxapps.com + /api/register
        Uri.parse('http://127.0.0.1:8000/api/AddReferral'),
        headers: {
          'Authorization': 'Bearer ${token!}',
        },

        body: {'record_id': idRecord, 'doctor_id': idDoctor, 'notes': 'hhhh'},
      );
      print("jj");
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(SuccessToSendReferal());
      }
    } catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailToSendReferal());
    }
  }

  List<ReferalModel> referals = [];

  Future getReferals() async {
    emit(LoadToGetReferal());
    Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/GetReferralsForDoctor"),
        headers: {
          'Authorization': 'Bearer ${token!}',
        });
    var responseBody = jsonDecode(response.body);
    print("referals Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['referrals']) {
        referals.add(ReferalModel.fromJson(json: item));
      }
      emit(SuccessToGetReferal());
      print(responseBody);
    } else {
      emit(FailToGetReferal());
    }
  }

  List<int?> selectedIndexes = [];


  Future<void> logout() async {
    emit(LoadToLogout());
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      emit(SuccessToLogout());
    } else {
      print(response.reasonPhrase);
      emit(FailToLogout());
    }
  }

  void handleNavigationDoctor(int index) {
    if (index == 8) {
      // تحقق مما إذا كان الزر المضغوط هو "Log Out"
      logout(); // تنفيذ دالة تسجيل الخروج
    } else {
      selectedIndex1 = index;
      emit(HandleNavigation());
    }
  }

  void handleNavigationAdmin(int index) {
    if (index == 13) {
      // تحقق مما إذا كان الزر المضغوط هو "Log Out"
      logout(); // تنفيذ دالة تسجيل الخروج
    } else {
      selectedIndex = index;
      emit(HandleNavigation());
    }
  }

  Future<void> insertAppointmen(
      List<Map> app, int roleid, String d, String t) async {
    emit(AppointmentLoadingState());
    var headers = {
      'Authorization': 'Bearer ${token!}',
      'Content-Type': 'application/json'
    };

    List myAppoint = [];

    for (int i = 0; i < app.length; i++) {
      myAppoint.add({
        "start_time": app[i]['start_time'],
        "end_time": app[i]['end_time'],
        "is_booked": false,
      });
    }
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/api/AppointmentStore'));

    request.body = json.encode({
      "appointment_date": d,
      "visit_type": t,
      "doctor_id": idDoc,
      "time_slots": myAppoint
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());
      emit(AppointmentSuccessState());
    } else {
      print(response.reasonPhrase);
      emit(FailedToAppointmentState(message: 'error'));
    }
  }
  DonationResponse? donation;
  Future<DonationResponse?> fetchDonations() async {
    emit(GetDonationsLoadState());
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/donations'),
        headers: {'Authorization': 'Bearer ${token!}'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // إذا كانت الاستجابة ناجحة، قم بتحويل JSON إلى نموذج DonationResponse
      donation = DonationResponse.fromJson(json.decode(response.body));
      emit(GetDonationsSuccessState());
    } else {
      emit(FailedToGetDonationsState());
    }
  }

  PaymentModel? payments;
  Future<PaymentModel?> fetchPayments() async {
    emit(GetDonationsLoadState());
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/payments'),
        headers: {'Authorization': 'Bearer ${token!}'});

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، قم بتحويل JSON إلى نموذج DonationResponse
      payments = PaymentModel.fromJson(json.decode(response.body));
      emit(GetDonationsSuccessState());
    } else {
      emit(FailedToGetDonationsState());
    }
  }

  List<Noti> parseNoti(String responseBody) {
    final parsed = jsonDecode(responseBody)['notifications'];
    return List<Noti>.from(parsed.map((json) => Noti.fromJson(json: json)));
  }

  List<Noti> noti = [];
  Future getNotiDoctor() async {
    // emit(GetLoadingLoadState());
    Response response = await http
        .get(Uri.parse("http://127.0.0.1:8000/api/notifications"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var responseBody = jsonDecode(response.body);

    print("noti Data is : $responseBody");

    if (response.statusCode == 200) {
      noti = parseNoti(response.body);
      emit(NotificationSuccess(noti));
      print(responseBody);
    } else {
      emit(FailedToGetClinicsState());
    }
  }

  Future<void> readNot(String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token!}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/notification-read'));
    request.fields.addAll({'id': id});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await getNotiDoctor();
    } else {
      print(response.reasonPhrase);
    }
  }



  late final Map<String, double> monthlyVisitsData;
  late final Map<String, double> weeklyAppointmentsData;
  Future<void> fetchStatisticsD() async {
    emit(DoctorStatisticsLoading());

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/doctorStatistics'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token!}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // تجهيز بيانات monthly_visits لرسم PieChart
        Map<String, double> monthlyVisits = {};
        for (var visit in data['monthly_visits']) {
          String month = visit['month'].toString();
          double percentage = visit['visit_percentage'].toDouble();
          monthlyVisits[month] = percentage;
        }

        // تجهيز بيانات weekly_appointments لرسم PieChart
        Map<String, double> weeklyAppointments = {};
        for (var appointment in data['weekly_appointments']) {
          String day = appointment['day'].toString();
          double count = appointment['appointment_count'].toDouble();
          weeklyAppointments[day] = count;
        }
        monthlyVisitsData = monthlyVisits;
        weeklyAppointmentsData = weeklyAppointments;
        emit(DoctorStatisticsLoaded());
      } else {
        emit(DoctorStatisticsError('Failed to load data'));
      }
    } catch (e) {
      emit(DoctorStatisticsError(e.toString()));
    }
  }

  Future<StatisticsModelDoctor> fetchSttistic() async {
    String url = 'http://127.0.0.1:8000/api/doctorStatistics1';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${token!}', // تعديل وفقًا لمتطلبات الـ API الخاص بك
      },
    );

    if (response.statusCode == 200) {
      return StatisticsModelDoctor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> fetchStatistic() async {
    try {
      emit(ProfileLoading());
      final stat = await fetchSttistic();
      emit(fetchSttisticLoaded(stat));
    } catch (e) {
      emit(ProfileError('Failed to fetch profile'));
    }
  }
}

// في التابع:
