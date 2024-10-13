import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';

class Nots extends StatelessWidget {
  const Nots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getRecord()
        ..getNotiDoctor(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xF3F3F3),
            body: state is NotificationSuccess
                ? cubit.noti.isEmpty
                    ? Center(
                        child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu,
                              size: 24,
                              color: Colors.grey[500],
                            ),
                            Text(
                              "No Notification ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ListView.builder(
                          itemCount: state.noti.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                    leading: Icon(
                                      Icons.notifications,
                                      color: Colors.teal,
                                    ),
                                    title: Text(
                                      "${state.noti[index].title}",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.teal),
                                    ),
                                    subtitle: Text(
                                      " ${state.noti[index].data}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.teal.shade300,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextButton(
                                        child: Text(
                                          "mark as read",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          cubit.readNot(
                                              "${cubit.noti[index].id}");
                                        },
                                      ),
                                    )
                                    // IconButton(
                                    //     icon: const Icon(Icons.cancel),
                                    //     onPressed: () {
                                    //       cubit.readNot("${cubit.noti[index].id}");
                                    //     }
                                    // ),
                                    ),
                              ),
                            );
                          },
                        ),
                      )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
