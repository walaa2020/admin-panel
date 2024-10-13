import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_cubit.dart';

import 'package:reda3/shared/components/components.dart';
import 'package:reda3/shared/components/constants/constant.dart';

import '../../cubit/admin_cubit/layout_state.dart';
class InsertAppointment extends StatelessWidget {
  InsertAppointment(){

  }

  @override
  Widget build(BuildContext context) {
    var startController=TextEditingController();
    var endController=TextEditingController();
    var fromController=TextEditingController();
    var toController=TextEditingController();
    var dateController=TextEditingController();

    final List<String> options = ['center', 'home'];
    double width= MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context)=>LayoutCubit(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){
          if(state is AppointmentLoadingState){
            showAlert(context,"loading...",Colors.teal);
          }

          if (state is AppointmentSuccessState){
            Navigator.of(context).pop();
            showAlert(context,"success!",Colors.teal);
          }

          else if(state is FailedToAppointmentState){
            Navigator.of(context).pop();
            showAlert(context,"error",Colors.red);
          }
        },
        builder:  (context,state){
          return
            Scaffold(
                // appBar: AppBar(
                //   title: Text('INSERT APPOINTMENT',style:  TextStyle(color: Colors.teal,
                //       fontSize: 24,fontWeight: FontWeight.bold),),
                //   leading: IconButton(
                //     onPressed: (){
                //       Navigator.pop(context);
                //     },
                //     icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.teal,),
                //   ),),

                body: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width/3,
                      child:Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('INSERT APPOINTMENT',style:  TextStyle(color: Colors.teal,
                                fontSize: 24,fontWeight: FontWeight.bold),),

                            SizedBox(height: 40,),
                            Container(
                              width: width/3,
                              child: TextField(
                                decoration: InputDecoration(labelText: 'appointment_date',    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),),
                                controller: dateController,
                              ),
                            ),

                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("slot time ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey[600],fontSize: 18),),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: width/3,
                              child: TextField(
                                decoration: InputDecoration(labelText: 'From',border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),),

                                controller: fromController,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: width/3,
                              child: TextField(
                                decoration: InputDecoration(labelText: 'To',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                controller: toController,
                              ),
                            ),
                            SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(onPressed: (){
                                LayoutCubit.get(context).addEmployee(
                                    fromController.text,toController.text
                                );

                              }, child: Text("insert",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,decoration: TextDecoration.underline,decorationColor: Colors.teal,decorationStyle: TextDecorationStyle.solid),)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                                width:width/2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        color: Colors.teal, width: 2)),

                                child:  ListView.builder(
                                    itemCount: LayoutCubit.get(context).itemCount,
                                    padding: EdgeInsets.all(12),
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        // leading: Image.asset(
                                        //   cubit.products[index][2],
                                        //   height: 36,
                                        // ),
                                        title: Text(
                                          "time",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        subtitle: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "from:${LayoutCubit.get(context).times[index].from!}" ,
                                              style: const TextStyle(fontSize: 12),
                                            ),

                                            Text(
                                              "to:${LayoutCubit.get(context).times[index].to!}" ,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: width/5,
                                            ),
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          child: const Icon(
                                            Icons.delete,
                                          ),
                                          onTap: () {
                                            LayoutCubit.get(context).removeEmployee(index);
                                            for( var item in LayoutCubit.get(context).times )
                                            {
                                              print(item
                                              );
                                            }
                                          },
                                        ),

                                      );})
                            ),
                          ),
                        ),
                        OutlinedButton(

                          onPressed: () {
                            LayoutCubit.get(context).convertMap();
                            LayoutCubit.get(context).insertAppointmen(
                              LayoutCubit.get(context).maps,
                              idDoc!,
                              dateController.text.toString(),
                              LayoutCubit.get(context).selectedOptionType.toString(),


                            );
                            // LayoutCubit.get(context).times.removeRange(0,LayoutCubit.get(context).times.length-1);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red),
                            minimumSize: MaterialStateProperty.all(Size(300, 50)),
                            // Set the background color to red
                          ),

                          child: Text(
                            "insert",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    )
                  ],
                )
            );
        },

      ),
    );

  }
}
