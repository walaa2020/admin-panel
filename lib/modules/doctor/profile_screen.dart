import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../models/clinic_model.dart';
import '../../shared/components/constants/constant.dart';
class ProfileDoctor extends StatelessWidget {
  const ProfileDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return BlocProvider<LayoutCubit>(
      create: (BuildContext context) =>LayoutCubit()..getClinic()..fetchProfile(idRole!),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
          listener: (context,state){

          },
          builder: (context,state){
            var cubit =LayoutCubit.get(context);
            Clinic? foundClinic;
           List<Clinic>c= cubit.clinics;
            Clinic? findClinicById(List<Clinic> clinics, String id) {
              try {
                int clinicId = int.parse(id);
                return clinics.firstWhere((clinic) => clinic.id == clinicId);
              } catch (e) {
                return null;
              }
            }

            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              foundClinic = findClinicById(c, "${state.profile.clinicsId}");
              return  Scaffold(body: SizedBox(

                child: Row(
                  children:[
                    Padding(
                      padding:  EdgeInsets.only(left:width/20),
                      child: Column(children: [
                        Padding(
                          padding:  EdgeInsets.only(top: height/11,),
                          child: CircleAvatar(//backgroundColor:primaryColor1,
                            radius:width/14 ,
                          backgroundImage: NetworkImage("${state.profile.doctorImg}")),
                        ),
                        SizedBox(
                          height: height/25,
                        ),
                        Text("${state.profile.userName}",
                          textAlign:TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.teal.shade200,fontSize: 18),),
                        SizedBox(
                          height: height/40,
                        ),
                         Text("${state.profile.specializationsId}",
                          textAlign:TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.normal,color:  Colors.black,fontSize: 14),),
                      ],),
                    ),
                    SizedBox(
                      width: width/20,
                    ),
                    Column(

                      children: [

                        SizedBox(
                          height: height/60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:height/25,
                              ),
                              Text("Profissional Detail",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.red,fontSize: 18),),
                              SizedBox(
                                height:height/90,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color:  Colors.teal.shade300,
                                      width: 1
                                  ),

                                ),
                                height: height/3.5,
                                width:width/2,
                                child:
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text("name:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text("Dr.${state.profile.firstName} ${state.profile.lastName}  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                      Row(children: [
                                        Text("user name:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text("Dr.${state.profile.userName}  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                      Row(children: [
                                        Text("learning grades:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text("${state.profile.learningGrades}  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                      Row(children: [
                                        Text("specialization:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text(" ${state.profile.specializationsId}  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                      Row(children: [
                                        Text("clinc:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text("${foundClinic?.clinicName}",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                    ],
                                  ),
                                ),
                              ),



                              SizedBox(
                                height:height/25,
                              ),
                              Text("Contact Details ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18),),
                              SizedBox(
                                height:height/90,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.teal.shade300,
                                      width: 1
                                  ),
                                ),
                                height: height/3.5,
                                width: width/2,
                                // width: cubit.isExpand?width/2.5:width/1.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text("email:",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text("${state.profile.email} ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                      Row(children: [
                                        Text("phone number:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text("${state.profile.phone} ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),
                                      Row(children: [
                                        Text("address:  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                        Text(" ${state.profile.address}  ",
                                          textAlign:TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                      ],),

                                    ],
                                  ),
                                ),
                              )


                            ],),
                        )

                      ],
                    ),
                  ],
                ),
              ),);
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown state'));
            }
        // return Scaffold(body: SizedBox(
        //
        //   child: Row(
        //     children:[
        //       Padding(
        //         padding:  EdgeInsets.only(left:width/20),
        //         child: Column(children: [
        //           Padding(
        //             padding:  EdgeInsets.only(top: height/11,),
        //             child: CircleAvatar(backgroundColor:primaryColor1,radius:width/14 ,),
        //           ),
        //           SizedBox(
        //             height: height/25,
        //           ),
        //            Text("Alreda",
        //             textAlign:TextAlign.left,
        //             style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.teal.shade200,fontSize: 18),),
        //           SizedBox(
        //             height: height/40,
        //           ),
        //           const Text("Microsurgy",
        //             textAlign:TextAlign.left,
        //             style: TextStyle(fontWeight: FontWeight.normal,color:  Colors.black,fontSize: 14),),
        //         ],),
        //       ),
        //       SizedBox(
        //         width: width/20,
        //       ),
        //       Column(
        //
        //         children: [
        //
        //           SizedBox(
        //             height: height/60,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(20.0),
        //             child: Column(mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 SizedBox(
        //                   height:height/25,
        //                 ),
        //                 Text("Profissional Detail",
        //                   textAlign:TextAlign.left,
        //                   style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.red,fontSize: 18),),
        //                 SizedBox(
        //                   height:height/90,
        //                 ),
        //                 Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(8),
        //                     border: Border.all(
        //                         color:  Colors.teal.shade300,
        //                         width: 1
        //                     ),
        //
        //                   ),
        //                   height: height/3.5,
        //                   width:width/2,
        //                   child:
        //                   Padding(
        //                     padding: const EdgeInsets.all(20.0),
        //                     child: Column(
        //                       children: [
        //                         Row(children: [
        //                           Text("learning grades:  ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
        //                           Text("bachelor of medicine   ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
        //                         ],),
        //                         Row(children: [
        //                           Text("clinc:  ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
        //                           Text("neorology   ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
        //                         ],),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //
        //
        //
        //                 SizedBox(
        //                   height:height/25,
        //                 ),
        //                 Text("Contact Details ",
        //                   textAlign:TextAlign.left,
        //                   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18),),
        //                 SizedBox(
        //                   height:height/90,
        //                 ),
        //                 Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(8),
        //                     border: Border.all(
        //                         color: Colors.teal.shade300,
        //                         width: 1
        //                     ),
        //                   ),
        //                   height: height/3.5,
        //                    width: width/2,
        //                    // width: cubit.isExpand?width/2.5:width/1.7,
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(20.0),
        //                     child: Column(
        //                       children: [
        //                         Row(children: [
        //                           Text("email:",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
        //                           Text("reda3@gmail.com   ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
        //                         ],),
        //                         Row(children: [
        //                           Text("phone number:  ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
        //                           Text("09432323234   ",
        //                             textAlign:TextAlign.left,
        //                             style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
        //                         ],)
        //                       ],
        //                     ),
        //                   ),
        //                 )
        //
        //
        //               ],),
        //           )
        //
        //         ],
        //       ),
        //     ],
        //   ),
        // ),);
      }),
    );
  }
}
