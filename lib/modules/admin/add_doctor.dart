import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/models/clinic_model.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../shared/components/components.dart';

class AddDoctor extends StatelessWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var specializationController = TextEditingController();
    var learningGradesController = TextEditingController();
    var mobileNumber = TextEditingController();
    var emailController = TextEditingController();
    var addressController = TextEditingController();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    final List<String> options = ['male', 'female'];
    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit()..getClinic(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is InsertDoctorLoadingState) {
            showAlert(context, "loading...", Colors.teal);
          } else if (state is InsertDoctorSuccessState) {
            Navigator.of(context).pop();
            showAlert(context, "success!", Colors.teal);
          } else if (state is FailedToInsertDoctorState) {
            Navigator.of(context).pop();
            showAlert(context, "error", Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          var img = cubit.pickedImage.toString();

          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Insert Doctor",
                      style: TextStyle(
                          color: Colors.teal.shade300,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
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
                              defaultTextFromField(
                                controller: firstnameController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.teal.shade300,
                                ),
                                label: "first name",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: lastnameController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.teal.shade300,
                                ),
                                label: "last name",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: specializationController,
                                type: TextInputType.phone,
                                prefixIcon: Icon(
                                  Icons.folder_special_outlined,
                                  color: Colors.teal.shade300,
                                ),
                                label: "specialization",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: learningGradesController,
                                type: TextInputType.phone,
                                prefixIcon: Icon(
                                  Icons.folder_special,
                                  color: Colors.teal.shade300,
                                ),
                                label: "learning grades",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              DropdownButtonFormField<Clinic>(
                                value: cubit.clinics.isEmpty
                                    ? null
                                    : cubit.selectedClinic,
                                items: cubit.clinics.map((Clinic clinic) {
                                  return DropdownMenuItem<Clinic>(
                                    value: clinic,
                                    child: Text(clinic.clinicName!),
                                  );
                                }).toList(),
                                onChanged: (Clinic? newClinic) {
                                  if (newClinic != null) {
                                    cubit.selectedClinic =
                                        cubit.selectop(newClinic);
                                  }
                                },
                                borderRadius: BorderRadius.circular(24),
                                decoration: InputDecoration(
                                  labelText: 'Select clinic',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
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
                                    cubit.insertDoctor(
                                        specializations:
                                            specializationController.text,
                                        learningGrades:
                                            learningGradesController.text,
                                        firstName: firstnameController.text,
                                        lastName: lastnameController.text,
                                        email: emailController.text,
                                        passwordCentre: passwordController.text,
                                        userName: usernameController.text,
                                        gender: cubit.selectedOption.toString(),
                                        address: addressController.text,
                                        phone: mobileNumber.text,
                                        clinicsId:
                                            cubit.selectedClinic!.id.toString(),
                                        img: cubit.webImage);
                                  },
                                  child: const Text(
                                    "save",
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
                      SizedBox(
                        width: width / 30,
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              defaultTextFromField(
                                controller: mobileNumber,
                                type: TextInputType.number,
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.teal.shade300,
                                ),
                                label: "mobile phone",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              DropdownButtonFormField<String>(
                                value: LayoutCubit.get(context).selectedOption,
                                items: options.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  LayoutCubit.get(context)
                                      .dropButtonTextFromFieldOnChange(
                                          newValue!);
                                },
                                borderRadius: BorderRadius.circular(24),
                                decoration: InputDecoration(
                                  labelText: 'Select gender',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: addressController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.add_location,
                                  color: Colors.teal.shade300,
                                ),
                                label: "address",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color: Colors.teal.shade300,
                                ),
                                label: "email",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: usernameController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.teal.shade300,
                                ),
                                label: "username",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: passwordController,
                                type: TextInputType.text,
                                prefixIcon: Icon(Icons.remove_red_eye_rounded,
                                    color: Colors.teal.shade300),
                                label: "password",
                              ),
                            ],
                          )),

                      // Expanded(child: SizedBox(width: width/5,))
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
