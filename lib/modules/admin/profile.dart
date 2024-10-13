import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/modules/admin/edit_profile.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getProfile(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          return BlocBuilder<LayoutCubit, LayoutStates>(
              builder: (context, state) {
            if (state is GetProfileLoadState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetProfileSuccessState) {
              return Scaffold(
                body: state.pro != null
                    ? SizedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width / 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: height / 11,
                                    ),
                                    child: CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          NetworkImage("${state.pro!.image}"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 25,
                                  ),
                                  Text(
                                    "${state.pro!.centerName}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal.shade300,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width / 20,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: height / 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height / 25,
                                      ),
                                      const Text(
                                        "Description",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: height / 90,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.teal.shade300,
                                              width: 1),
                                        ),
                                        height: height / 3.5,
                                        width: width / 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${state.pro!.description}",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 25,
                                      ),
                                      const Text(
                                        "Contact Details ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: height / 90,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.teal.shade300,
                                              width: 1),
                                        ),
                                        height: height / 4.3,
                                        width: width / 2,
                                        // width: cubit.isExpand?width/2.5:width/1.7,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "email:",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .teal.shade300,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "phone number:  ",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .teal.shade300,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    "${state.pro!.phone} ",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black54,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 90,
                                      ),
                                      Container(
                                        width: width / 6,
                                        height: height / 18,
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade300,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(34),
                                          ),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ProfileCenter()));
                                          },
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              const Text(
                                                "Edit",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 10,
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
        },
      ),
    );
  }
}
