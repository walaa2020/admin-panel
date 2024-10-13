import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/modules/doctor/record.dart';
import 'package:reda3/modules/doctor/showfile.dart';
import 'package:reda3/shared/components/components.dart';
import 'package:reda3/shared/components/constants/constant.dart';
import 'package:reda3/shared/styles/colors.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../models/doctor_model.dart';
import '../../models/patient_detail.dart';

class Sooo extends StatelessWidget {

  Sooo(this.record);
  late PatientDetails record;
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;

    var descriptionController=TextEditingController();

    return BlocProvider<LayoutCubit>(

      create: (context)=>LayoutCubit(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(

        listener: (context,state) async {
          if (state is SuccessToInsertDescriptionState){
            await    LayoutCubit.get(context).getRecord();
            PatientDetails? selectedRecord =LayoutCubit.get(context).r[record.id!-1];
            // PatientDetails? selectedRecord = LayoutCubit.get(context).r.firstWhere(
            //          (record) => record.id == record.id,

            // );
            if(selectedRecord !=null){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RecordPatientDetail1(selectedRecord, 2)));
            }
          }
        },
        builder:  (context,state){

          final cubit = BlocProvider.of<LayoutCubit>(context);
          {
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
                  child: Column(
                      children: [
                        defaultTextFromField(
                            controller: descriptionController,
                            type: TextInputType.text,
                            prefixIcon: Container(
                              width: 1,),
                            label: "description",
                            line: 12),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            SizedBox(width: width/1.2,),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("cancel")),
                            SizedBox(width: 30,),
                            TextButton(onPressed: () {
                              cubit.insertDescriptionByDoctor(idrec: record.id,des: descriptionController.text);
                            }, child: Text("ok")),

                          ],
                        ),
                      ]
                  ),
                ),
              );}


        },

      ),
    );
  }

}

