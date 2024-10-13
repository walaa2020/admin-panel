import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'AlReda',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.teal.shade300,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.white,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return constraints.maxWidth > 600
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _buildCards(),
                                )
                                    : Column(
                                  children: _buildCards(),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Week Appointment",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                    color: Colors.teal.shade300,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 400,
                              ),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                plotAreaBorderWidth: 5,
                                series: <ChartSeries>[
                                  ColumnSeries<SalesData, String>(
                                    dataSource: <SalesData>[
                                      SalesData('Saturday', 30, Colors.red),
                                      SalesData('Sunday', 50, Colors.green),
                                      SalesData('Monday', 40, Colors.blue),
                                      SalesData('Tuesday', 60, Colors.orange),
                                      SalesData('Wednesday', 70, Colors.purple),
                                      SalesData('Thursday', 55, Colors.yellow),
                                    ],
                                    xValueMapper: (SalesData sales, _) => sales.day,
                                    yValueMapper: (SalesData sales, _) => sales.sales,
                                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                                    pointColorMapper: (SalesData sales, _) => sales.color,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return constraints.maxWidth > 600
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _buildPieCharts(),
                                )
                                    : Column(
                                  children: _buildPieCharts(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildCards() {
    return [
      Flexible(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "Number Patients",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "905 Patients",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Flexible(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital_sharp,
                      size: 26.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "Number Clinics",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "16 Clinics",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Flexible(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 20.0,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "Number Doctors",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "35 Doctors",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildPieCharts() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Clinics Appointment",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: Colors.teal.shade300,
            ),
          ),
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                dataSource: <PieData>[
                  PieData('Dental', 2),
                  PieData('Gastroenterological', 4),
                  PieData('Dermatology', 2),
                  PieData('Neurology', 2),
                ],
                xValueMapper: (PieData data, _) => data.platform,
                yValueMapper: (PieData data, _) => data.usage,
                dataLabelMapper: (PieData data, _) => data.platform,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Doctors Appointment",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: Colors.teal.shade300,
            ),
          ),
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                dataSource: <PieData>[
                  PieData('D.Rania', 5),
                  PieData('D.Areej', 3),
                  PieData('D.Rasha', 2),
                  PieData('D.Walaa', 2),
                ],
                xValueMapper: (PieData data, _) => data.platform,
                yValueMapper: (PieData data, _) => data.usage,
                dataLabelMapper: (PieData data, _) => data.platform,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}

class SalesData {
  final String day;
  final double sales;
  final Color color;

  SalesData(this.day, this.sales, this.color);
}

class PieData {
  final String platform;
  final double usage;

  PieData(this.platform, this.usage);
}
