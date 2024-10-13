import 'package:flutter/material.dart';

import '../admin/home.dart';






class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6)).then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     decoration: const BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: [
            //             Colors.white, //.withOpacity(0.5)
            //             Color(0xFF01579B),
            //           ],
            //           begin: Alignment.topLeft,
            //           end: Alignment.bottomLeft,
            //         ))),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/rania.jpg'),
                  // استبدل 'images/background.jpg' بمسار الصورة الخاصة بك
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'images/J.jpg',
                scale: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
