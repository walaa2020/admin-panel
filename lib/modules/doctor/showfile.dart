import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/styles/colors.dart';

class FileScreen extends StatelessWidget {
  final int r;

  FileScreen(this.r);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..fetchFiles(r),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: primaryColor1.shade900,
            ),
          ),
          title: Text(
            "Files",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor1.shade900,
              fontSize: 18,
            ),
          ),
        ),
        body: BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            if (state is FileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView(
                  children: [
                    _buildHorizontalFileList(state.files['X_ray']!, 'X-ray Files'),
                    SizedBox(height: 50),
                    _buildHorizontalFileList(state.files['analysis']!, 'Analysis Files'),
                  ],
                ),
              );
            } else if (state is FileError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Press the button to fetch files'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalFileList(List<String> files, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.teal),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 150, // يمكنك تعديل هذا الارتفاع حسب الحاجة
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: files.map((file) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: Container(
                    width: 200, // يمكنك تعديل هذا العرض حسب الحاجة
                    child: ListTile(
                      title: Text(file.split('/').last),
                      subtitle: Text(_extractDate(file)),
                      onTap: () => _openFile(file),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _extractDate(String filePath) {
    final fileName = filePath.split('/').last;
    final regex = RegExp(r'(\d{4}-\d{2}-\d{2})');
    final match = regex.firstMatch(fileName);
    return match != null ? match.group(0)! : 'Unknown Date';
  }

  void _openFile(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
