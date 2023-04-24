import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class PPP extends StatefulWidget {
  const PPP({Key? key}) : super(key: key);

  @override
  _PPPState createState() => _PPPState();
}

class _PPPState extends State<PPP> {
  List<Expense> sales = [];

  Future<String> getJsonFromFirebase() async {
    return await rootBundle.loadString('assets/data.json');
    // String url = 'https://fir-84100-default-rtdb.firebaseio.com/data.json';
    // http.Response response = await http.get(Uri.parse(url));
    // return response.body;
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
    loadExpenseData();
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
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          child: DropdownButton<String>(
                            value: 'Option 1',
                            items: <String>[
                              'Option 1',
                              'Option 2',
                              'Option 3',
                              'Option 4'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // loadExpenseData();
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
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
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
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
                              yValueMapper: (Expense details, _) =>
                                  details.Groceries,
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
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent)),
                          primaryYAxis: NumericAxis(
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
                              yValueMapper: (Expense details, _) =>
                                  details.Leisure,
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
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent)),
                          primaryYAxis: NumericAxis(
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
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
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent)),
                          primaryYAxis: NumericAxis(
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
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
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent)),
                          primaryYAxis: NumericAxis(
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
                              yValueMapper: (Expense details, _) =>
                                  details.Insurance,
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
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent)),
                          primaryYAxis: NumericAxis(
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
                              yValueMapper: (Expense details, _) =>
                                  details.Medical,
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
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent),
                              minorGridLines: const MinorGridLines(
                                  color: Colors.transparent)),
                          primaryYAxis: NumericAxis(
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                            minorGridLines:
                                const MinorGridLines(color: Colors.transparent),
                          ),
                          series: <ChartSeries>[
                            BarSeries<Expense, String>(
                              dataSource: sales,
                              xValueMapper: (Expense details, _) =>
                                  details.month,
                              yValueMapper: (Expense details, _) =>
                                  details.Utilities,
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
                ],
              ),
            )));
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
  final int Housing;
  final int Groceries;
  final int Entertainment;
  final int Transportation;
  final int Leisure;
  final int Medical;
  final int Insurance;
  final int Utilities;

  factory Expense.fromJson(Map<String, dynamic> parsedJson) {
    return Expense(
        parsedJson['month'].toString(),
        parsedJson['Housing'],
        parsedJson['Groceries'],
        parsedJson['Entertainment'],
        parsedJson['Transportation'],
        parsedJson['Leisure'],
        parsedJson['Medical'],
        parsedJson['Insurance'],
        parsedJson['Utilities']);
  }
}
