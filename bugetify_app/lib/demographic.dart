// import 'package:flutter/material.dart';

// class Demographic extends StatelessWidget {
//   const Demographic({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class Demographic extends StatefulWidget {
  const Demographic({Key? key}) : super(key: key);

  @override
  _DemographicState createState() => _DemographicState();
}

class _DemographicState extends State<Demographic> {
  List<Expense> sales = [];
  bool _showCharts = false;

  Future<String> getJsonFromFirebase() async {
    // return await rootBundle.loadString('assets/data.json');
    String url = 'http://192.168.1.12:5000/DemoCompare';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadExpenseData() async {
    final String jsonString = await getJsonFromFirebase();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      sales.add(Expense.fromJson(i));
    }
  }

  @override
  void initState() {
    //  loadExpenseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade300,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              _showCharts = false;
                              sales.clear();
                            });
                            await loadExpenseData();
                            setState(() {
                              _showCharts = true;
                            });
                          },
                          child: Text('Apply'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.pinkAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Housing'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Housing,
                                color: Colors.red,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Groceries'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Groceries,
                                color: Colors.green,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Leisure'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Leisure,
                                color: Colors.blue,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Entertainment'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Entertainment,
                                color: Colors.black,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Transportation'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Transportation,
                                color: Colors.yellow,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Insurance'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Insurance,
                                color: Colors.brown,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Medical'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Medical,
                                color: Colors.orange,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  if (_showCharts)
                    FutureBuilder(
                      future: getJsonFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: 'Utilities'),
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                    color: Colors.transparent),
                                minorGridLines: const MinorGridLines(
                                    color: Colors.transparent)),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries>[
                              BarSeries<Expense, String>(
                                dataSource: sales,
                                xValueMapper: (Expense details, _) =>
                                    details.Name,
                                yValueMapper: (Expense details, _) =>
                                    details.Utilities,
                                color: Colors.pink,
                                width: 0.4,
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                ],
              ),
            )));
  }
}

class Expense {
  Expense(
      this.Name,
      this.Housing,
      this.Groceries,
      this.Entertainment,
      this.Transportation,
      this.Leisure,
      this.Medical,
      this.Insurance,
      this.Utilities);
  final String Name;
  final num Housing;
  final num Groceries;
  final num Entertainment;
  final num Transportation;
  final num Leisure;
  final num Medical;
  final num Insurance;
  final num Utilities;

  factory Expense.fromJson(Map<String, dynamic> parsedJson) {
    return Expense(
        parsedJson['Name'].toString(),
        parsedJson.containsKey('Housing')
            ? num.parse(parsedJson['Housing'])
            : 0,
        parsedJson.containsKey('Groceries')
            ? num.parse(parsedJson['Groceries'])
            : 0,
        parsedJson.containsKey('Entertainment')
            ? num.parse(parsedJson['Entertainment'])
            : 0,
        parsedJson.containsKey('Transportation')
            ? num.parse(parsedJson['Transportation'])
            : 0,
        parsedJson.containsKey('Leisure')
            ? num.parse(parsedJson['Leisure'])
            : 0,
        parsedJson.containsKey('Medical')
            ? num.parse(parsedJson['Medical'])
            : 0,
        parsedJson.containsKey('Insurance')
            ? num.parse(parsedJson['Insurance'])
            : 0,
        parsedJson.containsKey('Utilities')
            ? num.parse(parsedJson['Utilities'])
            : 0);
  }
}
