import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/shared/styles/colors.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../models/doctor_model.dart';
import '../../models/secretariat_model.dart';

class DoctorInformation extends StatelessWidget {
  DoctorInformation(doctors, rol) {
    this.rol = rol;
    rol == 1 ? this.doctors = doctors : this.secretariat = doctors;
  }
  late final Data doctors;
  late final int rol;
  late final Secretariat secretariat;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit()..getClinic(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  rol == 1 ? " Doctor Information" : " Secretariat Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor1.shade300),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.teal,
                  ),
                ),
                backgroundColor: Colors.white12,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width / 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: height / 11,
                                ),
                                child: CircleAvatar(
                                  radius: width / 14,
                                  backgroundImage: rol == 1
                                      ? NetworkImage("${doctors.doctorImg}")
                                      : NetworkImage(
                                          "${secretariat.secretary_img}"),
                                ),
                              ),
                              SizedBox(
                                height: height / 25,
                              ),
                              rol == 1
                                  ? Text(
                                      "${doctors.firstName}"
                                      "-",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor1.shade300,
                                          fontSize: 18),
                                    )
                                  : Text(
                                      "${secretariat.firstName} ${secretariat.lastName}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor1.shade300,
                                          fontSize: 18),
                                    ),
                              SizedBox(
                                height: height / 40,
                              ),
                              rol == 1
                                  ? Text(
                                      "${doctors.specializationsId}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: primaryColor1.shade300,
                                          fontSize: 14),
                                    )
                                  : Container()
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height / 25,
                                  ),
                                  Text(
                                    "Profissional Detail",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor1.shade900,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: height / 90,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: primaryColor1.shade300,
                                          width: 1),
                                    ),
                                    height: height / 3.5,
                                    width: width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "first name:  ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        primaryColor1.shade300,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                rol == 1
                                                    ? "${doctors.firstName}   "
                                                    : "${secretariat.firstName}   ",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "last name:  ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        primaryColor1.shade300,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                rol == 1
                                                    ? "${doctors.lastName}   "
                                                    : "${secretariat.lastName}   ",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "learning grades:  ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        primaryColor1.shade300,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                rol == 1
                                                    ? "${doctors.learningGrades}   "
                                                    : "${secretariat.learningGrades}   ",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          rol == 1
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "clinic:  ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: primaryColor1
                                                              .shade300,
                                                          fontSize: 14),
                                                    ),
                                                    const Text(
                                                      "neorology   ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          rol == 1
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "specialization:  ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: primaryColor1
                                                              .shade300,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "${doctors.specializationsId}   ",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          Row(
                                            children: [
                                              Text(
                                                "address:  ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        primaryColor1.shade300,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                rol == 1
                                                    ? "${doctors.address}   "
                                                    : "${secretariat.address}   ",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
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
                                    height: height / 25,
                                  ),
                                  Text(
                                    "Contact Details ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor1.shade900,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: height / 90,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: primaryColor1.shade300,
                                          width: 1),
                                    ),
                                    height: height / 3.5,
                                    width: width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "phone number:  ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        primaryColor1.shade300,
                                                    fontSize: 14),
                                              ),
                                              const Text(
                                                "09432323234   ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
