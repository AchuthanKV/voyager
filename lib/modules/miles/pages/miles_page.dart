import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:voyager/modules/miles/pages/claim_miles.dart';
import 'package:voyager/modules/miles/pages/donate_miles.dart';

class MilesPage extends StatefulWidget {
  @override
  _MilesPageState createState() => _MilesPageState();
}

class _MilesPageState extends State<MilesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                child: Text('Claim Miles'),
              ),
              Tab(
                child: Text('Donate Miles'),
              ),
            ],
          ),
          body: TabBarView(children: [ClaimMilesPage(), DonateMilesPage()]),
        ),
      ),
    );
  }
}
