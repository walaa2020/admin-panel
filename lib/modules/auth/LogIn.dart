import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/modules/doctor/home.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/constants/constant.dart';
import '../admin/home.dart';
import '../secretary/home.dart';



class LogInAll extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LayoutCubit(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){
if (state is LoginSuccessState && roleId==3){

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeS()));
}

else if (state is LoginSuccessState && roleId==2){

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeDoctor()));
}
else if (state is LoginSuccessState && roleId==1){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>Home()));
}
        },
        builder:  (context,state){
          var email=TextEditingController();
          var password=TextEditingController();
          Size size = MediaQuery.of(context).size;
          return
            Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.jpg'),
                          // استبدل 'images/background.jpg' بمسار الصورة الخاصة بك
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: size.height * 0.2),
                          const SizedBox(
                            height: 120,
                            width: 160,
                          ),
                          Center(
                            child:
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4, // تعديل العرض حسب احتياجاتك
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.1),
                                  TextFormField(
                                    controller:email ,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (input) {},
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "email",
                                      labelStyle: TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12),
                                      hintStyle: TextStyle(color: Colors.black),
                                      prefixIcon: Icon(Icons.person, color: Colors.teal.shade300),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.teal.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.teal.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.teal.shade300),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 5.5,),

                          Center(
                            child: SizedBox(
                              width: size.width * 0.4,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: password,
                                keyboardType: TextInputType.text,
                                onChanged: (input) {},
                                obscureText:LayoutCubit.get(context).ispassword?true:false ,
                                decoration: InputDecoration(
                                  labelText: 'password',
                                  labelStyle:  TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.all(12),
                                  hintStyle: const TextStyle(color: Colors.white),
                                  prefixIcon: Icon(Icons.lock, color: Colors.teal.shade300),
                                  suffixIcon:
                                  IconButton(
                                    icon: Icon(LayoutCubit.get(context).seffix),
                                    onPressed: () { LayoutCubit.get(context).changePasswordVisibility(); },),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal.shade300)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal.shade300)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal.shade300)
                                  ),
                                ),
                              ),
                            ),
                          ),



                          Padding(
                            padding: const EdgeInsets.only(top:40.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(1, -2),
                                      blurRadius: 5.0),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0, 1.0],
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
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all( Colors.teal.shade300),
                                    shadowColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                LayoutCubit.get(context).login(email: email.text, password: password.text);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      top: 3,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      "Log in",
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
                          SizedBox(height: size.height * 0.03),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        },

      ),
    );

  }
}
