import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/modules/doctor/showfile.dart';
import 'package:reda3/modules/doctor/insert_description.dart';
import 'package:reda3/shared/components/components.dart';
import 'package:reda3/shared/components/constants/constant.dart';
import 'package:reda3/shared/styles/colors.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../models/doctor_model.dart';
import '../../models/patient_detail.dart';

class RecordPatientDetail1 extends StatelessWidget {
  RecordPatientDetail1(this.record,this.r);
  late int r;
  late PatientDetails record;
  String? idDoctor;
  String? idClinic;
  final String apiUrl = 'http://127.0.0.1:8000/api/storeXrayAndAnalysis/$idRole';
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;

    var descriptionController=TextEditingController();
    final List<String> options = ['radiograph', 'analysis',];
    return BlocProvider<LayoutCubit>(

      create: (context)=>LayoutCubit()..getListDoctor()..getClinic()..getRecord(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(

        listener: (context,state){

          if (state is FileSendState){
            final cubit = BlocProvider.of<LayoutCubit>(context);
            AlertDialog alertdilog=AlertDialog(title: Text("insert file to record patient",
              style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: primaryColor1.shade300),),
              content:Container(height: 200,
                child:     Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected File: ${cubit.filePath}'),
                    SizedBox(height: 15,),
                    DropdownButtonFormField<String>(
                      value:  LayoutCubit.get(context).selectedOptiond ,
                      items: options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),

                      onChanged: ( newValue) {
                        LayoutCubit.get(context).dropButtonTextFromFieldOnChanged(newValue!);
                        print (newValue);
                      },


                      decoration: InputDecoration(
                        labelText: 'Select type file',
                        border: OutlineInputBorder(),
                      ),
                    ),

                  ],
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("cancel")),
                TextButton(onPressed: (){

                  // cubit.uploadFile(cubit.filePath!);

                }, child: Text("ok"))
              ],);
            showDialog(context: context, builder: (BuildContext context){
              return alertdilog;
            });
          }

          if(state is LoadToSendReferal){
            Navigator.of(context).pop();
            showAlert(context,"loading...",Colors.teal);
          }
          else if (state is SuccessToSendReferal){
            Navigator.of(context).pop();
            showAlert(context,"referal send successfuly!",Colors.teal);

          }
          else if(state is FailToSendReferal){
            Navigator.of(context).pop();
            showAlert(context,"error",Colors.red);
          }

        },
        builder:  (context,state){

          final cubit = BlocProvider.of<LayoutCubit>(context);
          if (record != null) {
            return
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined,
                      color: primaryColor1.shade900,),
                  ),
                  title: Text("Record Patient",

                    style: TextStyle(fontWeight: FontWeight.bold,
                      color: primaryColor1.shade900,
                      fontSize: 18,
                    ),
                  ),
                ),
                body:
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(

                        width: width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Personal Detail",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: primaryColor1,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor: primaryColor1
                                  ),),

                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("first name :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.firstName} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("last name :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.lastName} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("father name :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.fatherName} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                  ],),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("mobile num:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.phone} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("adress :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.address} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("gender :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.gender} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                  ],),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("birth date :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.gender}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("Social State :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.socialStatus} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("job:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.job} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                  ],),
                                SizedBox(
                                  height: 8,
                                ),

                                Text("contact for contgent state",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: primaryColor1,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor: primaryColor1
                                  ),),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("first name :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.firstNameAlternate} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("last name :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${record.lastNameAlternate} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),
                                    Column(crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                      children: [

                                        Text("phone num:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),),
                                        Text("${ record.mobileNumber} ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600],
                                              fontSize: 13),),
                                      ],),

                                  ],),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("medical history",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: primaryColor1,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor: primaryColor1),),
                                SizedBox(
                                  height: 3,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Text("previous operations :",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(" ${record.previousOperations}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                          fontSize: 13,),),
                                    ),
                                  ],),
                                SizedBox(
                                  height: 2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Text("Allergy to medications:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text("${record.allergyToMedication}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                          fontSize: 13,),),
                                    ),
                                  ],),
                                SizedBox(
                                  height: 2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Text("chronic diseases:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(" ${record.chronicDiseases}",
                                        textAlign: TextAlign.left,

                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                          fontSize: 13,),),
                                    ),
                                  ],),
                                SizedBox(
                                  height: height / 15,
                                ),
                                r==1?Container(): Row(
                                  children: [
                                    ElevatedButton(onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sooo(record)));

                                      // AlertDialog alertdilog = AlertDialog(
                                      //   title: Text("edit",
                                      //     style: Theme
                                      //         .of(context)
                                      //         .textTheme
                                      //         .headline4!
                                      //         .copyWith(fontSize: 24,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal),),
                                      //   content: Container(height: height / 1.8,
                                      //       width: width / 1.8,
                                      //       decoration: BoxDecoration(
                                      //           borderRadius: BorderRadius
                                      //               .circular(4)),
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.all(10.0),
                                      //         child: Column(
                                      //             mainAxisAlignment: MainAxisAlignment
                                      //                 .start,
                                      //             crossAxisAlignment: CrossAxisAlignment
                                      //                 .start,
                                      //             children: [
                                      //               defaultTextFromField(
                                      //                   controller: descriptionController,
                                      //                   type: TextInputType.text,
                                      //                   prefixIcon: Container(
                                      //                     width: 1,),
                                      //                   label: "description",
                                      //                   line: 12),
                                      //             ]
                                      //         ),
                                      //       )),
                                      //   backgroundColor: Colors.white,
                                      //   actions: [ TextButton(onPressed: () {
                                      //     Navigator.pop(context);
                                      //   }, child: Text("cancel")),
                                      //     TextButton(onPressed: () {
                                      //      cubit.insertDescriptionByDoctor(idrec: record.id,des: descriptionController.text);
                                      //     }, child: Text("ok")),
                                      //
                                      //
                                      //   ],);
                                      // showDialog(context: context,
                                      //     builder: (BuildContext context) {
                                      //       return alertdilog;
                                      //     });
                                    },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal),
                                      // minWidth: width/8,
                                      child: Text("insert description", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,

                                      ),),),
                                    SizedBox(
                                      width: width / 40,
                                    ),
                                    ElevatedButton(onPressed: () {
                                      AlertDialog alertdilog = AlertDialog(
                                        title: Text("referal",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal),),
                                        content: Container(height: height / 1.8,
                                            width: width / 1.8,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(4)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    // Container(
                                                    //   child: DropdownButtonFormField<
                                                    //       Clinic>(
                                                    //     dropdownColor: primaryColor1[50],
                                                    //     borderRadius: BorderRadius
                                                    //         .circular(24),
                                                    //     focusColor: Colors.white,
                                                    //     decoration: InputDecoration(
                                                    //       labelText: 'Select clinic',
                                                    //       border: OutlineInputBorder(
                                                    //           borderRadius: BorderRadius
                                                    //               .circular(24)),
                                                    //     ),
                                                    //     value: cubit.clinics
                                                    //         .isEmpty
                                                    //         ? null
                                                    //         : cubit
                                                    //         .selectedClinic,
                                                    //     items: cubit.clinics.map((
                                                    //         Clinic clinic) {
                                                    //       return DropdownMenuItem<
                                                    //           Clinic>(
                                                    //         value: clinic,
                                                    //         child: Text(clinic
                                                    //             .clinicName!),
                                                    //       );
                                                    //     }).toList(),
                                                    //     onChanged: (
                                                    //         Clinic? newClinic) {
                                                    //       if (newClinic != null) {
                                                    //         cubit
                                                    //             .onchangedDropDownButton(
                                                    //             newClinic);
                                                    //         print(
                                                    //             'You selected: ${cubit
                                                    //                 .selectedClinic!
                                                    //                 .id
                                                    //                 .toString()}');
                                                    //         idClinic = cubit
                                                    //             .selectedClinic!
                                                    //             .id.toString();
                                                    //       }
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height: height / 40,),
                                                    Container(
                                                      child: DropdownButtonFormField<
                                                          Data>(
                                                        dropdownColor: primaryColor1[50],
                                                        borderRadius: BorderRadius
                                                            .circular(24),
                                                        focusColor: Colors.white,
                                                        decoration: InputDecoration(
                                                          labelText: 'Select doctor',
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(24)),
                                                        ),
                                                        value:
                                                        cubit.listDoctors.isEmpty
                                                            ? null
                                                            : cubit
                                                            .selectedDoctor,
                                                        items: cubit.listDoctors
                                                            .map((Data doctor) {
                                                          return DropdownMenuItem<
                                                              Data>(
                                                            value: doctor,
                                                            child: Text(
                                                                doctor.userName!),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                            Data? newDoctor) {
                                                          if (newDoctor != null) {
                                                            cubit
                                                                .onChangedDropDownButtonDoctor(
                                                                newDoctor);
                                                            idDoctor = cubit
                                                                .selectedDoctor!
                                                                .id!.toString();
                                                          }
                                                        },
                                                      ),
                                                    ),

                                                  ]
                                              ),
                                            )),
                                        backgroundColor: Colors.white,
                                        actions: [
                                          TextButton(onPressed: () {
                                            Navigator.pop(context);
                                          }, child: Text("cancel")),
                                          TextButton(onPressed: () {
                                            // int idDoc= int.parse(idDoctor!);

                                            cubit.sendReferal(idRecord: record.id.toString(), idDoctor: idDoctor.toString());

                                          }, child: Text("ok"))
                                        ],);
                                      showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return alertdilog;
                                          });
                                    },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal),
                                      child: Text("referal", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),),),


                                    SizedBox(
                                      width: width / 40,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) => FileScreen(record.id)));
                                        },
                                        child: Text("show file", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),)),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                                r==1?Container(): Row(children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal),
                                      onPressed: () =>_uploadAnalysisFile(context),
                                      // {
                                      //   // cubit.openFileExplorer();
                                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadFileScreen()));
                                      // },
                                      child: Text(
                                        "insert Analysis Files", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),)),
                                  SizedBox(
                                    width: width / 44,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal),
                                      onPressed: () => _pickAndUploadFile(context),
                                      // onPressed: ()
                                      // {
                                      //
                                      //   // cubit.openFileExplorer();
                                      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadFileScreen()));
                                      // },
                                      child: Text(
                                        "insert X-ray Files", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),)),
                                ],),
                                r==1?                     ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) => FileScreen(record.id)));
                                    },
                                    child: Text("show file", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),)):Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width/10,),
                      SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("detail description:",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade900,fontSize: 24
                            ),),
                            SizedBox(height:30,),
                            ...record.descriptions.map((desc) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Doctor Name:   ',style: TextStyle(fontWeight: FontWeight.bold,color:primaryColor1,fontSize: 15)),
                                      Text(' ${desc['Doctor Name']}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Date:   ',  style: TextStyle(fontWeight: FontWeight.bold,color:primaryColor1,fontSize: 15)),
                                      Text(' ${desc['date']}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Description:  ',  style: TextStyle(fontWeight: FontWeight.bold,color:primaryColor1,fontSize: 15)),
                                      Text(' ${desc['description']}'),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Container(height:1,color: Colors.black54,width:width/3.5),
                                  SizedBox(height: 20,),
                                ],
                              );
                            }),
                          ],),
                      )


                    ],
                  ),
                ),
              );}
          else {
            // Loading indicator when data is being fetched
            return Center(child: CircularProgressIndicator());
          }

        },

      ),
    );
  }

  void _pickAndUploadFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        List<String?> filePaths = result.files.where((file) => file is PlatformFile).map((file) => file.path).toList();
        context.read<LayoutCubit>().uploadFile(apiUrl, filePaths);
      }
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }
  void _uploadAnalysisFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        List<String?> filePaths = result.files.where((file) => file is PlatformFile).map((file) => file.path).toList();
        context.read<LayoutCubit>().uploadAnalysisFile(apiUrl, filePaths);
      }
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }
}

