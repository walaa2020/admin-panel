import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../shared/components/components.dart';

class AddSecretariat extends StatelessWidget {
  const AddSecretariat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var learningGradesController = TextEditingController();
    var mobileNumberController = TextEditingController();
    var emailController = TextEditingController();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    var addressController = TextEditingController();
    var birthdateController = TextEditingController();
    final List<String> options = ['male', 'female'];
    String? gender;
    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is InsertSecretariatLoadingState) {
            showAlert(context, "loading...", Colors.teal);
          } else if (state is InsertSecretariatSuccessState) {
            Navigator.of(context).pop();
            showAlert(context, "success!", Colors.teal);
          } else if (state is FailedToInsertSecretariatState) {
            Navigator.of(context).pop();
            showAlert(context, "error", Colors.red);
          }
        },
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          var cubit = LayoutCubit.get(context);

          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Insert Secretariat",
                    style: TextStyle(
                        color: Colors.teal.shade300,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Row(
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
                                  style: TextStyle(color: Colors.teal.shade300),
                                ))
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
                                controller: usernameController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.teal.shade300,
                                ),
                                label: "user name",
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
                              defaultTextFromField(
                                controller: birthdateController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.add_location,
                                  color: Colors.teal.shade300,
                                ),
                                label: "birthdate",
                              ),
                              SizedBox(
                                height: height / 15,
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
                                controller: mobileNumberController,
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
                              defaultTextFromField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                prefixIcon: Icon(
                                  Icons.text_snippet_outlined,
                                  color: Colors.teal.shade300,
                                ),
                                label: "email",
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              defaultTextFromField(
                                controller: passwordController,
                                type: TextInputType.text,
                                prefixIcon: Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Colors.teal.shade300,
                                ),
                                label: "password",
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
                                  gender = newValue;
                                  print(gender);
                                },
                                borderRadius: BorderRadius.circular(24),
                                decoration: InputDecoration(
                                  labelText: 'Select gender',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
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
                      LayoutCubit.get(context).insertSecretariat(
                          learningGrades: learningGradesController.text,
                          firstName: firstnameController.text,
                          lastName: lastnameController.text,
                          email: emailController.text,
                          passwordCentre: passwordController.text,
                          userName: usernameController.text,
                          address: addressController.text,
                          phone: mobileNumberController.text,
                          gender: cubit.selectedOption.toString(),
                          birth: birthdateController.text,
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
            ),
          ));
        },
      ),
    );
  }
}
