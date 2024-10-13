import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/modules/admin/home.dart';



import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';


class ProfileCenter extends StatelessWidget {

  const ProfileCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var centerNameController=TextEditingController();
    var detailsController=TextEditingController();
    var mobileNumber=TextEditingController();
    var phoneNumber=TextEditingController();
    var addressController=TextEditingController();

    return BlocProvider<LayoutCubit>(
      create: (context)=>LayoutCubit(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){
if (state is ProfileSuccessState){
  AlertDialog alertdialog=AlertDialog(
    title: Text("",
    style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: primaryColor1.shade300),),
    content:Container(height: 50,
      child:
          const Text('profile updated successfully',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


    ),
    backgroundColor: Colors.white,
    actions: [
      TextButton(onPressed: (){
        LayoutCubit.get(context).onChanged(1);
        Navigator.pop(context);
      }, child: const Text("ok")),

    ],);
  showDialog(context: context, builder: (BuildContext context){
    return alertdialog;

}
  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
        },
        builder: (context,state){

          double height= MediaQuery.of(context).size.height;
          double width= MediaQuery.of(context).size.width;
var cubit=LayoutCubit.get(context);
          //
          return Scaffold(
            appBar: AppBar(
elevation: 0,
              backgroundColor: Colors.white12,
              iconTheme: IconThemeData(color: Colors.teal),
            ),
              body: SingleChildScrollView(
                child: Column(

                  children: [
                    // SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Center Information",style: TextStyle(color: Colors.teal.shade300,
                          fontSize: 24,fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: height/3,
                                  width: width/5,

                                  child: cubit.pickedImage==null?Icon(Icons.image,size: 50,color: Colors.teal.shade300,):Image.memory(
                                    cubit.webImage,fit:BoxFit.cover,

                                  ),
                                ),
                                SizedBox(height: height/30,),
                                OutlinedButton(onPressed: (){
                                  cubit.getImage();
                                  // cubit.getImage();
                                }, child: Text(""
                                    "Select image",style: TextStyle(color: Colors.teal.shade300,),))

                              ],
                            ),

                          ),

                          SizedBox(width:width/30,),
                          Expanded(flex: 2,
                            child: Column(
                              children: [
                                defaultTextFromField(
                                  controller: centerNameController,
                                  type: TextInputType.text,
                                  prefixIcon:  Icon(Icons.account_balance_sharp,color: Colors.teal.shade300,),
                                  label:"center name",
                                ),
                                SizedBox(height: height/40,),
                                defaultTextFromField(
                                  controller: detailsController,
                                  type: TextInputType.text,
                                  prefixIcon:  Icon(Icons.text_snippet_outlined,color: Colors.teal.shade300,),
                                  label:"details",
                                ),
                                SizedBox(height: height/40,),
                                defaultTextFromField(
                                  controller: phoneNumber,
                                  type: TextInputType.phone,
                                  prefixIcon:  Icon(Icons.phone,color: Colors.teal.shade300,),
                                  label:"phone number",
                                ),
                                SizedBox(height: height/40,),
                                defaultTextFromField(
                                  controller: mobileNumber,
                                  type: TextInputType.phone,
                                  prefixIcon:  Icon(Icons.send_to_mobile,color: Colors.teal.shade300,),
                                  label:"mobile phone",
                                ),
                                SizedBox(height: height/40,),
                                defaultTextFromField(
                                  controller: addressController,
                                  type: TextInputType.text,
                                  prefixIcon:  Icon(Icons.location_pin,color: Colors.teal.shade300,),
                                  label:"address",
                                ),
                                SizedBox(height: height/7,),
                                Container(
                                  width: width/6,
                                  height: height/18,
                                  decoration: BoxDecoration(

                                    color: Colors.teal.shade300,
                                    borderRadius: const BorderRadius.all(Radius.circular(34),
                                    ),),
                                  child: MaterialButton(onPressed: (){

cubit.profileCenter(cubit.webImage, centerNameController.text, mobileNumber.text, detailsController.text);
                                  },


                                    child: const Text("save",   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18,
                                    ),),),
                                ),
                              ],
                            )
                          ),

Expanded(child: SizedBox(width: width/5,))
                        ],
                      ),
                    ),
                  ],
                ),
              )

          );
        },

      ),);
  }
}
