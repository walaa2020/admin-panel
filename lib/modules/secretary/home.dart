import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:reda3/modules/secretary/profile.dart';
import 'package:reda3/modules/secretary/record.dart';
import 'package:reda3/modules/secretary/show_doactor.dart';
import '../../shared/components/constants/constant.dart';
import '../auth/LogIn.dart';
import 'Add_advertising.dart';
import 'add_wallet.dart';
import 'adverts.dart';
import 'all_adverts.dart';
import 'appointmqnts_record.dart';
import 'clinics.dart';
import 'first_page.dart';


class HomeS extends StatefulWidget {
  const HomeS({Key? key}) : super(key: key);

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Rail Example',
      theme: ThemeData(
        primaryColor: Colors.teal.shade300,
      ),
      home: const NavigationRailExample(),
    );
  }
}

class NavigationRailExample extends StatefulWidget {
  const NavigationRailExample({super.key});

  @override
  _NavigationRailExampleState createState() => _NavigationRailExampleState();
}

class _NavigationRailExampleState extends State<NavigationRailExample> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  int _selectedIndex = 0;

  // صفحات للتنقل بينهما
  final List<Widget> _pages = [
    // const FirstPage(),
    // ProfilePage(),
    ClinicsPage(),
    AddWallet(),
    ShowdoctorPage(),
    const RecordPage(),
    const AppointmentRecordPage(),
  AllAdverts(),
    Adverts(),
    Addadvertisingpage(),
    // نحن لا نحتاج إلى LoginPage هنا حيث سنتعامل مع تسجيل الخروج بشكل منفصل
  ];

  void _handleNavigation(int index) {
    if (index == 8) { // تحقق مما إذا كان الزر المضغوط هو "Log Out"
      _logout(); // تنفيذ دالة تسجيل الخروج
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _logout() async {
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  LogInAll()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        _handleNavigation(index); // استخدام الدالة للتعامل مع الاختيارات
                      },
                      labelType: labelType,
                      selectedIconTheme: IconThemeData(color: Colors.teal.shade300),
                      selectedLabelTextStyle: TextStyle(color: Colors.teal.shade300),
                      destinations: [
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.stacked_bar_chart_outlined),
                        //   selectedIcon: Icon(Icons.stacked_bar_chart),
                        //   label: Text("Statistics"),
                        // ),
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.person_outline),
                        //   selectedIcon: Icon(Icons.person),
                        //   label: Text('Profile'),
                        // ),
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: Text("Home"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.money),
                          selectedIcon: Icon(Icons.money),
                          label: Text("insert wallet"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.people_sharp),
                          selectedIcon: Icon(Icons.home),
                          label: Text("Show Doctors"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.receipt_outlined),
                          selectedIcon: Icon(Icons.receipt),
                          label: Text('Record'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.calendar_today_outlined),
                          selectedIcon: Icon(Icons.calendar_today),
                          label: Text('visits'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.document_scanner),
                          selectedIcon: Icon(Icons.document_scanner),
                          label: Text('advertise'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.document_scanner),
                          selectedIcon: Icon(Icons.document_scanner),
                          label: Text('advertise waiting'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.add_photo_alternate_rounded),
                          selectedIcon: Icon(Icons.add_photo_alternate_rounded),
                          label: Text('add advertise'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.exit_to_app_outlined),
                          selectedIcon: Icon(Icons.exit_to_app),
                          label: Text('Log Out'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: _pages[_selectedIndex],
            ),
          )
        ],
      ),
    );
  }
}
