import 'package:flutter/material.dart';

class Information_visit extends StatelessWidget {
  const Information_visit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    var descriptionController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('images/rania.jpg'),
          //       // استبدل 'images/background.jpg' بمسار الصورة الخاصة بك
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(child:
                    Text(
                      'AlReda',
                      style: TextStyle(
                        color: Colors.teal.shade300,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(2, 2),
                          ),
                        ],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back,color: Color(0xFF01579B),),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],

                ),
                SizedBox(height: 10,),

                Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 120,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          // width: width / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " Personal Detail ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:  Colors.teal.shade300,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor:  Colors.teal.shade300,),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "First Name:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "first name ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 200,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Last Name:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "last name ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 200,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Gender:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            " Male ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Phone:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "09763878 ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 213,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Date:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "1/1/2024 ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 219,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Name doctor:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "dwfdeplf ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Name Clinic:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "adfcrefvrf",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 190,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Timer:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "2:00",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 235,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Adress:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "rania ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 13),
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),



                        ),
                        SizedBox(
                          height:height/25,
                        ),
                        Text("Information The Home Visite",
                          textAlign:TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.red,fontSize: 18),),
                        SizedBox(
                          height:height/60,
                        ),
                        SizedBox(height: 30,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:  Colors.teal.shade300,
                                width: 1
                            ),

                          ),
                          height: height/3.5,
                          width:width/1.2,
                          child:
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(children: [
                                  Text("description:  ",
                                    textAlign:TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                                  Text( "patient is good state and ..."
                                      "patient is good state and ..."
                                      "patient is good state and ..."
                                      "patient is good state and ...patient is good state and ..."
                                      // "patient is good spatient is good state and ...tate and ...patient is good state and ..."
                                      "patient is good state and ...jjkhk"
                                      " ",
                                    textAlign:TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                                ],),

                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                  ],

                ),




              ],
            ),
          ),
        ],
      ),

    );
  }
}
