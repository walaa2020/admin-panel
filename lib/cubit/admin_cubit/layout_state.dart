import 'package:reda3/models/article_model.dart';

import '../../models/advert_model.dart';
import '../../models/doctor_model.dart';
import '../../models/noti_doctor_model.dart';
import '../../models/profile_model.dart';
import '../../models/secretariat_model.dart';
import '../../models/statistics_model.dart';
abstract class LayoutStates{}
class LayoutInitialState extends LayoutStates{}
class OnChangeScreenState extends LayoutStates{}
class ImagePickerGalleryState extends LayoutStates{}
//register
class RegisterLoadingState extends LayoutStates{}
class RegisterSuccessState extends LayoutStates{}
class FailedToRegisterState extends LayoutStates{
  final String message;
  FailedToRegisterState({required this.message});
}

//login
class LoginLoadingState extends LayoutStates{}
class LoginSuccessState extends LayoutStates{}
class FailedToLoginState extends LayoutStates{
  final String message;
  FailedToLoginState({required this.message});
}

//InsertClinic
class InsertClinicLoadingState extends LayoutStates{}
class InsertClinicSuccessState extends LayoutStates{}
class FailedToInsertClinicState extends LayoutStates{
  final String message;
  FailedToInsertClinicState({required this.message});
}

//InsertDoctor
class InsertDoctorLoadingState extends LayoutStates{}
class InsertDoctorSuccessState extends LayoutStates{}
class FailedToInsertDoctorState extends LayoutStates{
  final String message;
  FailedToInsertDoctorState({required this.message});
}
//InsertSecretariat
class InsertSecretariatLoadingState extends LayoutStates{}
class InsertSecretariatSuccessState extends LayoutStates{}
class FailedToInsertSecretariatState extends LayoutStates{
  final String message;
  FailedToInsertSecretariatState({required this.message});
}
// profileCenter

class ProfileLoadingState extends LayoutStates{}
class ProfileSuccessState extends LayoutStates{}
class FailedToInsertProfileState extends LayoutStates{
  final String message;
  FailedToInsertProfileState({required this.message});
}
//
class GetDoctorLoadState extends LayoutStates{}
class GetDoctorSuccessState extends LayoutStates{

}

class GetDoctorInClinicSuccessState extends LayoutStates{
  final List<Data> doctor;

  GetDoctorInClinicSuccessState(this.doctor);
}
//
class GetSecretariatLoadState extends LayoutStates{}
class GetSecretariatSuccessState extends LayoutStates{
  final List<Secretariat> secretariat;

  GetSecretariatSuccessState(this.secretariat);
}
class FailedToGetSecretariatState extends LayoutStates{}

//
class GetClinicsLoadState extends LayoutStates{}
class GetClinicsSuccessState extends LayoutStates{}
class FailedToGetClinicsState extends LayoutStates{}
class ChangePasswordVisibilityState extends LayoutStates{}
class SelectOpDropDawnButton extends LayoutStates{}
//
class GetProfileLoadState extends LayoutStates{}
class GetProfileSuccessState extends LayoutStates{
  ProfileModel ?pro;
  GetProfileSuccessState(this.pro);
}
class FailedToGetProfileState extends LayoutStates{}

//apointment
class GetAppointmentLoadState extends LayoutStates{}
class GetAppointmentSuccessState extends LayoutStates{}
class FailedToGetAppointmentState extends LayoutStates{}

//apointment
class AppointmentLoadingState extends LayoutStates{}
class AppointmentSuccessState extends LayoutStates{}
class FailedToAppointmentState extends LayoutStates{
  final String message;
  FailedToAppointmentState({required this.message});
}
class AppointmentItemLoadingState extends LayoutStates{}
class AppointmentItemSuccessState extends LayoutStates{}
class FailedToAppointmentItemState extends LayoutStates{
  final String message;
  FailedToAppointmentItemState({required this.message});
}

class FilterDoctorsSuccessState extends LayoutStates{
  final List<Data> filterDoctors;

  FilterDoctorsSuccessState(this.filterDoctors);
}
class FilterClinicsSuccessState extends LayoutStates{
  // final List<Data> doctors;
  //
  // FilterClinicsSuccessState(this.doctors);
}
class FilterSecretaraitsSuccessState extends LayoutStates{
  final List<Secretariat> sec;

  FilterSecretaraitsSuccessState(this.sec);
}
class FilterRecordSuccessState extends LayoutStates{
}
class DeleteSecretariatSuccessfuly extends LayoutStates{}
class DeleteSecretariatFail extends LayoutStates{}

class DeleteDoctorSuccessfuly extends LayoutStates{
  // final List <Data> doctors ;
  // DeleteDoctorSuccessfuly({required this.doctors});
}
class DeleteDoctorFail extends LayoutStates{}
class DeleteDoctorLoadingState extends LayoutStates{}
class SuccessAddAppointmentState extends LayoutStates{}
class AddAppointmentLoadingState extends LayoutStates{}
class AddAppointmentErrorState extends LayoutStates{}
//sql
class GetDataSuccessState extends LayoutStates{}
class RemoveDataSuccessState extends LayoutStates{}

class InsertDataSuccessState extends LayoutStates{}
class InsertDataFailState extends LayoutStates{}
class GetAdvertLoadState extends LayoutStates{}
class GetAdvertsSuccessState extends LayoutStates{
  final List <AdvertModel> advert ;
  GetAdvertsSuccessState({required this.advert});
}
class FailedToGetAdvertsState extends LayoutStates{}

//update advert
class UpdateAdvertLoadingState extends LayoutStates{}
class UpdateAdvertSuccessState extends LayoutStates{}
class FailedToUpdateAdvertState extends LayoutStates{
  final String message;
  FailedToUpdateAdvertState({required this.message});
}

class AccountListLoaded extends LayoutStates {
  final List<Data> doctors;

  AccountListLoaded(this.doctors);
}

//doctor
class FileSendState extends LayoutStates{}

class ProfileLoading extends LayoutStates{}
class ProfileLoaded extends LayoutStates{
  final Data profile;

   ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}
class ProfileError extends LayoutStates{
  final String message;

   ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class InsertArticleLoadState extends LayoutStates{}
class InsertArticleSuccessState extends LayoutStates{}
class FailedToInsertArticleState extends LayoutStates{}
//statistic


class StatisticsLoading extends LayoutStates {}

class StatisticsLoaded extends LayoutStates {
  final Map<String, double> dataMap;

  StatisticsLoaded(this.dataMap);

  @override
  List<Object> get props => [dataMap];
}

class StatisticsError extends LayoutStates {
  final String message;

  StatisticsError(this.message);

  @override
  List<Object> get props => [message];

}


class AgeGroupStatisticsInitial extends LayoutStates {}

class AgeGroupStatisticsLoading extends LayoutStates {}

class AgeGroupStatisticsLoaded extends LayoutStates {
  final List<Map<String, dynamic>> data;

  AgeGroupStatisticsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class AgeGroupStatisticsError extends LayoutStates {
  final String message;

  AgeGroupStatisticsError(this.message);

  @override
  List<Object> get props => [message];
}

class InsertDescriptionLoadingState extends LayoutStates {}
class SuccessToInsertDescriptionState extends LayoutStates {}
class FailedToInserDescriptionState extends LayoutStates {
  final String message;

  FailedToInserDescriptionState(this.message);

  @override
  List<Object> get props => [message];
}

class GetArticlesLoadState extends LayoutStates{}
class GetArticlesSuccessState extends LayoutStates{
  final List<ArticleModel> art;

  GetArticlesSuccessState(this.art);
}
class FailedToGetArticlesState extends LayoutStates{}

class GetRecordLoadState extends LayoutStates{}
class SuccessToGetRecordsState extends LayoutStates{}
class FailedToGetRecordState extends LayoutStates{}

class SuccessToInsertFileState extends LayoutStates{}




class FileLoading extends LayoutStates {}

class FileLoaded extends LayoutStates {
  final Map<String, List<String>> files;

  FileLoaded(this.files);
}

class FileError extends LayoutStates {
  final String message;

  FileError(this.message);
}

class GetAdvertsShowingSuccessState extends LayoutStates {
  List<AdvertModel>h;
  GetAdvertsShowingSuccessState(this.h);
}
class UpdateLoadState extends LayoutStates{}
class UpdateSuccessState extends LayoutStates{}
class FailedToUpdateState extends LayoutStates{}
class GetDaysSuccessState extends LayoutStates{}
class SuccessToGetAppointmentDayDoctor extends LayoutStates{}
class LoadToGetAppointmentDayDoctor extends LayoutStates{}
class FailToGetAppointmentDayDoctor extends LayoutStates{}

class SuccessToGetDaysDoctor extends LayoutStates{}
class LoadToGetDaysDoctor extends LayoutStates{}
class FailToGetDaysDoctor extends LayoutStates{}

class SuccessToSendReferal extends LayoutStates{}
class LoadToSendReferal extends LayoutStates{}
class FailToSendReferal extends LayoutStates{}

class SuccessToGetReferal extends LayoutStates{}
class LoadToGetReferal extends LayoutStates{}
class FailToGetReferal extends LayoutStates{}
class LayoutCheckboxToggledState extends LayoutStates {}

class SuccessToAttendVisit extends LayoutStates{}
class LoadToAttendVisit extends LayoutStates{}
class FailToAttendVisit extends LayoutStates{}


class SuccessToLogout extends LayoutStates{}
class LoadToLogout extends LayoutStates{}
class FailToLogout extends LayoutStates{}

class HandleNavigation extends LayoutStates{}

class RecordsUpdatedState extends LayoutStates {} //

class GetDonationsLoadState extends LayoutStates{}
class GetDonationsSuccessState extends LayoutStates{}
class FailedToGetDonationsState extends LayoutStates{}



class NotificationSuccess extends LayoutStates {
  final List<Noti> noti;

  NotificationSuccess(this.noti);
}
class GetLoadingLoadState extends LayoutStates{}

class DoctorStatisticsInitial extends LayoutStates {}

class DoctorStatisticsLoading extends LayoutStates {}

class DoctorStatisticsLoaded extends LayoutStates {

}

class DoctorStatisticsError extends LayoutStates {
  final String message;
  DoctorStatisticsError(this.message);
}


class fetchSttisticLoading extends LayoutStates{}
class fetchSttisticLoaded extends LayoutStates{
  final StatisticsModelDoctor profile;

  fetchSttisticLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}
class fetchSttisticError extends LayoutStates{
  final String message;

  fetchSttisticError(this.message);

  @override
  List<Object> get props => [message];
}