import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../shared/components/components.dart';

class AddClinic extends StatelessWidget {
  const AddClinic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var centerNameController = TextEditingController();
    var detailsController = TextEditingController();

    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is InsertClinicLoadingState) {
            showAlert(context, "loading...", Colors.teal);
          } else if (state is InsertClinicSuccessState) {
            Navigator.of(context).pop();
            showAlert(context, "success!", Colors.teal);
          } else if (state is FailedToInsertClinicState) {
            Navigator.of(context).pop();
            showAlert(context, "error", Colors.red);
          }
        },
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          var cubit = LayoutCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "INSERT CLINIC",
                          style: TextStyle(
                              color: Colors.teal.shade300,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
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
                                    height: height / 3,
                                    width: width / 5,
                                    child: cubit.pickedImage == null
                                        ? Icon(
                                            Icons.image,
                                            size: 50,
                                            color: Colors.teal.shade300,
                                          )
                                        : Image.memory(
                                            cubit.webImage,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(
                                    height: height / 30,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      cubit.getImage();
                                    },
                                    child: Text(
                                      ""
                                      "Select image",
                                      style: TextStyle(
                                        color: Colors.teal.shade300,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width / 30,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height / 30,
                                    ),
                                    defaultTextFromField(
                                      controller: centerNameController,
                                      type: TextInputType.text,
                                      prefixIcon: Icon(
                                        Icons.account_balance_sharp,
                                        color: Colors.teal.shade300,
                                      ),
                                      label: "clinic name",
                                    ),
                                    SizedBox(
                                      height: height / 40,
                                    ),
                                    defaultTextFromField(
                                      controller: detailsController,
                                      type: TextInputType.text,
                                      prefixIcon: Icon(
                                        Icons.text_snippet_outlined,
                                        color: Colors.teal.shade300,
                                      ),
                                      label: "description",
                                    ),
                                    SizedBox(
                                      height: height / 7,
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
                                          cubit.insertClinic(
                                              cubit.webImage,
                                              centerNameController.text,
                                              detailsController.text);
                                        },
                                        child: const Text(
                                          "insert",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                child: SizedBox(
                              width: width / 5,
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
