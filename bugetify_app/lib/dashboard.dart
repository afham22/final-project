import 'dart:convert';

import 'package:bugetify_app/components/inforcard.dart';
import 'package:bugetify_app/ppp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Expense> sales = [];

  Future<List<dynamic>> getJsonFromFirebase() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    return json.decode(jsonString);
    // String url = 'https://fir-84100-default-rtdb.firebaseio.com/data.json';
    // http.Response response = await http.get(Uri.parse(url));
    // return response.body;
  }

  Future loadExpenseData() async {
    final List<dynamic> jsonResponse = await getJsonFromFirebase();
    for (Map<String, dynamic> i in jsonResponse) {
      if (i.containsKey('month')) {
        sales.add(Expense.fromJson(i));
      }
    }
  }

  @override
  void initState() {
    loadExpenseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                height: size.height * .45,
                decoration: BoxDecoration(
                  color: Colors.pink.shade400,
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image: AssetImage("assets/img/undraw_pilates_gpdb.png"),
                  ),
                ),
              ),
              FutureBuilder(
                future: getJsonFromFirebase(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // If the future has completed successfully and returned data
                    var data = snapshot.data;
                    var goldValue = data[3]['gold'].toStringAsFixed(2);
                    var dollarValue = data[3]['dollar'].toStringAsFixed(2);
                    return Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          InfoCard(
                            icon: 'assets/img/gold.svg',
                            label: 'Today\'s\nGold Price',
                            amount: '\₹$goldValue',
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InfoCard(
                            icon: 'assets/img/rupee.svg',
                            label: '1 USD :\n ',
                            amount: '\₹$dollarValue',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // If the future completed with an error
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    // If the future hasn't completed yet
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Housing'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) => details.Housing,
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
          SizedBox(
            height: 16,
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Groceries'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) {
                        String label = '${details.month}';
                        return label.replaceAll(RegExp(', |null|,null'), '');
                      },
                      yValueMapper: (Expense details, _) => details.Groceries,
                      color: Colors.green,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Leisure'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) => details.Leisure,
                      color: Colors.blue,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Entertainment'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) =>
                          details.Entertainment,
                      color: Colors.black,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Transportation'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) =>
                          details.Transportation,
                      color: Colors.yellow,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Insurance'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) => details.Insurance,
                      color: Colors.brown,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Medical'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) => details.Medical,
                      color: Colors.orange,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: getJsonFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: 'Utilities'),
                  primaryXAxis: CategoryAxis(
                      majorGridLines:
                          const MajorGridLines(color: Colors.transparent),
                      minorGridLines:
                          const MinorGridLines(color: Colors.transparent)),
                  primaryYAxis: NumericAxis(
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent),
                    minorGridLines:
                        const MinorGridLines(color: Colors.transparent),
                  ),
                  series: <ChartSeries>[
                    BarSeries<Expense, String>(
                      dataSource: sales,
                      xValueMapper: (Expense details, _) => details.month,
                      yValueMapper: (Expense details, _) => details.Utilities,
                      color: Colors.pink,
                      width: 0.4,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(
            height: 40,
          )
        ]),
      ),
    );
  }
}

class Expense {
  Expense(
      this.month,
      this.Housing,
      this.Groceries,
      this.Entertainment,
      this.Transportation,
      this.Leisure,
      this.Medical,
      this.Insurance,
      this.Utilities);
  final String month;
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
        parsedJson['month'].toString(),
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
