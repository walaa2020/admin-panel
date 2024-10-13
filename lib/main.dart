import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'cubit/blocobserver.dart';
import 'modules/auth/LogIn.dart';
import 'shared/network/cach_network.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialisation();

  // await CacheNetwork.clearSharedPreferences();
  // token=CacheNetwork.getCacheData(key: 'token');
  // role= CacheNetwork.getCacheDataInt(key: 'role');
  // print("role:$role");
  // print("token is  $token");
  // debugEmulateFlutterTesterEnvironment = true;
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  Colors.teal.shade300),
inputDecorationTheme: InputDecorationTheme(

  focusedBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.teal)

  ),
  prefixIconColor: Colors.teal
),
        iconTheme: IconThemeData(
          color: Colors.teal

        ),

        // useMaterial3: false,
      ),

      home:LogInAll(),

    );
  }
}

// flutter run -d edge --web-renderer html
// //

