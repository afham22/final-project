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

  Future<String> getJsonFromFirebase() async {
    return await rootBundle.loadString('assets/data.json');
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
    super.initState();
    loadExpenseData();
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
                  color: Color(0xFFF5CEB8),
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image: AssetImage("assets/img/undraw_pilates_gpdb.png"),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    InfoCard(
                      icon: 'assets/img/credit-card.svg',
                      label: 'Transfer via\nCard number',
                      amount: '\$1200',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InfoCard(
                      icon: 'assets/img/credit-card.svg',
                      label: 'Transfer via\nOnline Banks',
                      amount: '\$150',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Container(
          //   // Here the height of the container is 45% of our total height
          //   height: size.height * .45,
          //   decoration: BoxDecoration(
          //     color: Color(0xFFF5CEB8),
          //     image: DecorationImage(
          //       alignment: Alignment.centerLeft,
          //       image: AssetImage("assets/img/undraw_pilates_gpdb.png"),
          //     ),
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     InfoCard(
          //       icon: 'assets/img/credit-card.svg',
          //       label: 'Transfer via\nCard number',
          //       amount: '\$1200',
          //     ),
          //     InfoCard(
          //       icon: 'assets/img/credit-card.svg',
          //       label: 'Transfer via\nOnline Banks',
          //       amount: '\$150',
          //     ),
          //   ],
          // ),
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
            height: 40,
          )
        ]),
      ),
    );
  }
}
