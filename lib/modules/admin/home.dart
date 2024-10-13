import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../auth/LogIn.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit()..startTimer(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is SuccessToLogout) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LogInAll()));
          }
        },
        builder: (context, state) {
          NavigationRailLabelType labelType = NavigationRailLabelType.all;
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: Row(
              children: [
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: NavigationRail(
                            selectedIndex: cubit.selectedIndex,
                            onDestinationSelected: (index) {
                              cubit.handleNavigationAdmin(index);
                            },
                            labelType: labelType,
                            selectedIconTheme:
                                IconThemeData(color: Colors.teal.shade300),
                            selectedLabelTextStyle:
                                TextStyle(color: Colors.teal.shade300),
                            destinations: const [
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
                                // padding: ,
                                icon: Icon(Icons.add_business_outlined),
                                label: Text("add clinic"),
                              ),
                              NavigationRailDestination(
                                // padding: ,
                                icon: Icon(Icons.group_add),
                                label: Text("add doctor"),
                              ),
                              NavigationRailDestination(
                                // padding: ,
                                icon: Icon(Icons.group_add),
                                label: Text("add secretariat"),
                              ),
                              NavigationRailDestination(
                                // padding: ,
                                icon: Icon(Icons.notifications_active),
                                label: Text("notification"),
                              ),
                              NavigationRailDestination(
                                // padding: ,
                                icon: Icon(Icons.description),
                                label: Text("waited adverts"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.image),
                                // selectedIcon: Icon(Icons.local_hospital),
                                label: Text("advetrs"),
                              ),
                              NavigationRailDestination(
                                // padding: ,
                                icon: Icon(Icons.group),
                                label: Text("doctors"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.local_hospital),
                                // selectedIcon: Icon(Icons.local_hospital),
                                label: Text("clinics"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.group),
                                // selectedIcon: Icon(Icons.local_hospital),
                                label: Text("patient"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.monetization_on_rounded),
                                // selectedIcon: Icon(Icons.local_hospital),
                                label: Text("donations"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.monetization_on_rounded),
                                // selectedIcon: Icon(Icons.local_hospital),
                                label: Text("payments"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.logout),
                                // selectedIcon: Icon(Icons.local_hospital),
                                label: Text("logout"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                IconButton(
                                    onPressed: () {
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
                                    },
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Icon(
                                        Icons.notifications,
                                        size: 45,
                                        color: Colors.teal.shade300,
                                      ),
                                    )),
                                if (cubit.noti.length > 0)
                                  Positioned(
                                    right: 10,
                                    top: 0,
                                    child: Container(
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
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                'AlReda',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.teal.shade300,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.white,
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
                      const SizedBox(
                        height: 40.0,
                      ),
                      Expanded(
                          flex: 10, child: cubit.screen[cubit.selectedIndex])
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
