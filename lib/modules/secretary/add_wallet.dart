import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import 'package:http/http.dart' as http;
import '../../shared/components/constants/constant.dart';

class AddWallet extends StatelessWidget {
  const AddWallet({super.key});

  // تعديل دالة insertWallet لتعرض AlertDialog
  Future<void> insertWallet(BuildContext context, String id, String amount) async {
    var headers = {
      'Authorization': 'Bearer ${token!}',
    };

    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/wallet-charging'));
    request.fields.addAll({
      'amount': amount,
      'wallet_id': id,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      _showAlertDialog(context, 'Success', 'Wallet inserted successfully!');
    } else {
      print(response.reasonPhrase);
      _showAlertDialog(context, 'Error', 'Failed to insert wallet: ${response.reasonPhrase}');
    }
  }

  // دالة لعرض AlertDialog
  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK",style: TextStyle(color: Colors.teal),),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الحوار
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var headerController = TextEditingController();
    var contentController = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.only(right: width / 4, left: width / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height / 20),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    "Insert Wallet",
                    style: TextStyle(
                        color: Colors.teal.shade300,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: height / 9),
                Container(
                  width: width,
                  child: buildTextFormField("wallet_id", Icons.code, headerController),
                ),
                SizedBox(height: height / 30),
                Container(
                  width: width,
                  child: buildTextFormField("money", Icons.monetization_on_outlined, contentController),
                ),
                SizedBox(height: height / 10),
                Center(
                  child: Container(
                    width: width / 6,
                    height: height / 18,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade300,
                      borderRadius: BorderRadius.all(
                        Radius.circular(34),
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        await insertWallet(context, headerController.text, contentController.text);
                      },
                      child: Text(
                        "Insert",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// دالة لإنشاء TextFormField
Widget buildTextFormField(String labelText, IconData iconData, TextEditingController controller) {
  return Container(
    width: 100,
    child: TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      onChanged: (input) {},
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.all(12),
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          iconData,
          color: Colors.teal.shade300,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade300),
        ),
      ),
    ),
  );
}
