import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/models/advert_model.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';

class AdvertDetail extends StatelessWidget {
  AdvertDetail(advert, {super.key}) {
    this.advert = advert;
  }
  late final AdvertModel advert;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Detail Advert',
                style: TextStyle(
                    color: Colors.teal.shade300,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
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
            body: Center(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height / 2,
                      width: width / 2.5,
                      child: Image.network("${advert.advert_image}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("description: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal,
                                    fontSize: 18)),
                          ),
                          Container(
                            height: height / 2.2,
                            width: width / 2.2,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Colors.teal,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(24)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${advert.description}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: width / 9,
                              height: height / 15,
                              decoration: BoxDecoration(
                                  color: Colors.teal.shade300,
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.teal,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Center(
                                  child: Text("${advert.status}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 14))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
