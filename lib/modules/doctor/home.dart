import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_cubit.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/modules/auth/LogIn.dart';
class HomeDoctor extends StatelessWidget {
  const HomeDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width= MediaQuery.of(context).size.width;
    return  BlocProvider<LayoutCubit>(
      create: (context)=>LayoutCubit()..getNotiDoctor()..startTimer(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(listener: (context, state) {
        if (state is SuccessToLogout){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInAll()));
        }

      },
        builder:  (context, state) {
          NavigationRailLabelType labelType = NavigationRailLabelType.all;
        var cubit=LayoutCubit.get(context);
        return  Scaffold(
          backgroundColor: Colors.grey[100],
            // appBar: AppBar(backgroundColor:primaryColor1.shade400,
            //   leading: IconButton(
            //     onPressed: () {
            //       cubit.isExpanded();
            //     },
            //     icon: Icon(Icons.menu,color: white,),
            //   ),
            //   elevation: 0,
            //   title: Center(
            //     child: Text("Alreda",
            //       textAlign:TextAlign.left,
            //       style: TextStyle(fontWeight: FontWeight.bold,color: white),),
            //   ),),
            body: Container(
              width: double.infinity,
              child: Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Let's start by adding the Navigation Rail
                    // NavigationRail(
                    //
                    //     onDestinationSelected: ( index){
                    //       cubit.onChanged(index);
                    //     },
                    //   selectedIndex: cubit.selectedIndex,
                    //     extended: cubit.isExpand,
                    //     backgroundColor: Colors.deepPurple.shade200,
                    //     unselectedIconTheme:
                    //     IconThemeData(color: white, opacity: 1),
                    //     unselectedLabelTextStyle: TextStyle(
                    //       color: white,
                    //     ),
                    //     selectedIconTheme:
                    //     IconThemeData(color: Colors.deepPurple.shade900),
                    //     destinations: [
                    //       NavigationRailDestination(
                    //         icon: Icon(Icons.bar_chart),
                    //         label: Text("Dashboard"),
                    //       ),
                    //       NavigationRailDestination(
                    //         // padding: ,
                    //         icon: Icon(Icons.person),
                    //         label: Text("profile"),
                    //       ),
                    //       NavigationRailDestination(
                    //         icon: Icon(Icons.apps),
                    //         label: Text("appointment"),
                    //       ),
                    //       // NavigationRailDestination(
                    //       //   icon: Icon(Icons.file_copy_rounded),
                    //       //   label: Text("records"),
                    //       // ),
                    //       NavigationRailDestination(
                    //         icon: Icon(Icons.article),
                    //         label: Text("add Article"),
                    //       ),
                    //       NavigationRailDestination(
                    //         icon: Icon(Icons.login),
                    //         label: Text("referals"),
                    //       ),
                    //
                    //
                    //     ],
                    //
                    //  ),
                    NavigationRail(
                      selectedIndex:cubit.selectedIndex1,
                      onDestinationSelected: ( index){

                        cubit.handleNavigationDoctor(index);
                      },
                      labelType: labelType,
                      selectedIconTheme: IconThemeData(color: Colors.teal.shade300),
                      selectedLabelTextStyle: TextStyle(color: Colors.teal.shade300),
                      // unselectedIconTheme: IconThemeData(color: Colors.teal.shade300),
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.bar_chart),
                          label: Text("Dashboard"),
                        ),
                        NavigationRailDestination(
                          // padding: ,
                          icon: Icon(Icons.person),
                          label: Text("profile"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.apps),
                          label: Text("appointment"),
                        ),
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.file_copy_rounded),
                        //   label: Text("records"),
                        // ),
                        NavigationRailDestination(
                          icon: Icon(Icons.article),
                          label: Text("add Article"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.login),
                          label: Text("referals"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.notifications_active),
                          label: Text("notification"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.article),
                          label: Text("articles"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.date_range),
                          label: Text("add_appointment"),
                        ),
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.notifications_active),
                        //   label: Text("notification"),
                        // ),
                        NavigationRailDestination(
                          icon: Icon(Icons.logout),
                          label: Text("logout"),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [


                                Stack(
                                  children: [
                                    IconButton(onPressed: (){



                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return AlertDialog(
                                        //       title: Text("Notifications",style: TextStyle(fontSize: 18,color: Colors.teal,fontWeight: FontWeight.bold),),
                                        //       content: Container(
                                        //         width: 600,
                                        //         height: 600,
                                        //
                                        //         child:state is NotificationSuccess?
                                        //         ListView.builder(
                                        //           itemCount: state.noti.length,
                                        //           itemBuilder: (context, index) {
                                        //             return Padding(
                                        //               padding: const EdgeInsets.all(12.0),
                                        //               child:
                                        //               Container(
                                        //                 decoration: BoxDecoration(
                                        //                     color: Colors.grey[200],
                                        //                     borderRadius: BorderRadius.circular(8)),
                                        //                 child: ListTile(
                                        //
                                        //                   title: Text(
                                        //                     "${state.noti[index].title}",
                                        //                     style: const TextStyle(fontSize: 18,color: Colors.teal),
                                        //                   ),
                                        //                   subtitle: Text(
                                        //                     " ${state.noti[index].data}" ,
                                        //                     style: const TextStyle(fontSize: 12),
                                        //                   ),
                                        //                   trailing: IconButton(
                                        //                       icon: const Icon(Icons.cancel),
                                        //                       onPressed: () {
                                        //                         cubit.readNot("${cubit.noti[index].id}");
                                        //                       }
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             );
                                        //           },
                                        //         ):Center(child: CircularProgressIndicator()),
                                        //       ),
                                        //       backgroundColor: Colors.white,
                                        //       actions: [
                                        //         TextButton(
                                        //           onPressed: () {
                                        //             Navigator.of(context).pop();
                                        //           },
                                        //           child: Text("Close"),
                                        //         ),
                                        //       ],
                                        //     );
                                        //   },
                                        // );

                                    }, icon: Padding(
                                      padding: const EdgeInsets.only(bottom:20.0),
                                      child: Icon(Icons.notifications,size: 45,color: Colors.teal.shade300,),
                                    )),
                                    if (cubit.noti.length > 0)
                                      Positioned(
                                        right: 10,
                                        top: 0,
                                        child:  Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Text(
                                            '${cubit.noti.length}',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'AlReda',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.teal.shade300,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color:Colors.white,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(flex: 10,
                              child: cubit.screenDoctor[cubit.selectedIndex1]),
                        ],
                      ),
                    )

                  ]),
            )
        );
        },

      ),
    );
  }
}