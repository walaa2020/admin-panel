import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/styles/colors.dart';

class UpdateAdvert extends StatelessWidget {
  final TextEditingController descriptionController = TextEditingController();
  UpdateAdvert(this.id);
  late int id;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Update Advert",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor1.shade300,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white12,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
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
                        SizedBox(height: height / 30),
                        OutlinedButton(
                          onPressed: () {
                            cubit.getImage();
                          },
                          child: Text(
                            "Select image",
                            style: TextStyle(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 80),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: descriptionController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle:
                                    TextStyle(color: Colors.teal.shade300),
                                contentPadding: const EdgeInsets.all(30),
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.shade300,
                              offset: Offset(1, -2),
                              blurRadius: 5.0,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 1.0],
                            colors: [
                              Colors.green.withOpacity(0.1),
                              Colors.lightGreenAccent.withOpacity(0.9),
                            ],
                          ),
                          color: Colors.teal.shade300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 18,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.teal.shade300,
                              ),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              cubit.editadv(cubit.webImage,
                                  descriptionController.text, id);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 8),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
