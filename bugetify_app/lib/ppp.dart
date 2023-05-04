import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PPP extends StatefulWidget {
  const PPP({Key? key}) : super(key: key);

  @override
  _PPPState createState() => _PPPState();
}

class _PPPState extends State<PPP> {
  String _token = '';
  bool _showCharts = false;
  List<Expense> sales = [];
  String _selectedLocation = 'Bangalore';

  Future<List<dynamic>> getJsonFromFirebase(String city) async {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var url = "http://192.168.1.13:5000/PPPCalculation";
    http
        .post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token!
      },
      body: jsonEncode(<String, String>{
        'city': city,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List<dynamic>;
        completer.complete(jsonData); // Resolve the future with the data
      } else {
        completer.completeError('Failed to load data from Firebase');
      }
    }).catchError((error) {
      completer.completeError(error);
    });
    // Return the future associated with the Completer object
    return completer.future;
  }

  // Future<String> getJsonFromFirebase(String city) async {
  //   try {
  //     var url = Uri.parse('http://172.20.10.13:5000/PPPCalculation');
  //     Response response = await post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode({'city': city}),
  //     );
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       print('verification failed');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return 'error';
  // }

  Future loadExpenseData() async {
    final List<dynamic> jsonResponse =
        await getJsonFromFirebase(_selectedLocation);
    for (Map<String, dynamic> i in jsonResponse) {
      sales.add(Expense.fromJson(i));
    }
  }

  @override
  void initState() {
    _getTokenFromPrefs();
    super.initState();
  }

  Future<void> _getTokenFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      _token = token!;
    });
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
                            value: _selectedLocation,
                            items: <String>[
                              'Kochi',
                              'Bangalore',
                              'Kolkata',
                              'Mumbai',
                              'Lucknow',
                              'Patna',
                              'Hyderabad',
                              'Chennai',
                              'Raipur',
                              'Delhi',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLocation = value.toString();
                              });
                            },
                          ),
                        ),
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
                      future: getJsonFromFirebase(_selectedLocation),
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
                                xValueMapper: (Expense details, _) {
                                  String label =
                                      '${details.dest_city}, ${details.cur_city}';
                                  return label.replaceAll(
                                      RegExp(', |null|,null'), '');
                                },
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
      this.dest_city,
      this.cur_city,
      this.Housing,
      this.Groceries,
      this.Entertainment,
      this.Transportation,
      this.Leisure,
      this.Medical,
      this.Insurance,
      this.Utilities);
  final String dest_city;
  final String cur_city;
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
        parsedJson['dest_city'].toString(),
        parsedJson['cur_city'].toString(),
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
