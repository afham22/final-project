import 'package:bugetify_app/demographic.dart';
import 'package:bugetify_app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class Feature extends StatefulWidget {
  const Feature({Key? key}) : super(key: key);

  @override
  _FeatureState createState() => _FeatureState();
}

class _FeatureState extends State<Feature> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Demographic'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart),
                  SizedBox(width: 8),
                  Text('PPP'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Demographic(),
          Text('Likes Page'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
