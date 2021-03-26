import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/controllers/ville_provider.dart';
import 'package:pharm_point/screens/global_map_screen.dart';
import 'package:pharm_point/services/api_helpers.dart';
import 'package:pharm_point/widgets/pharms_grid.dart';
import 'package:pharm_point/widgets/slider_list.dart';

import 'package:pharm_point/widgets/ville_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  getVilles() async {
    var provider = Provider.of<VilleProvider>(context, listen: false);
    var resp = await AllVilles.getAllVilles();
    if (resp.isSuccesful) {
      provider.setVilleList(resp.data);
    }
  }

  getPharms() async {
    var provider = Provider.of<PharmsProvider>(context, listen: false);
    var resp = await AllPhams.getAllPharms();
    if (resp.isSuccesful) {
      provider.setPharmsList(resp.data);
    }
  }

  @override
  void initState() {
    super.initState();
    getVilles();
    getPharms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacie',style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: (){
              Navigator.of(context).pushNamed(GlobalMapScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text('Par ville', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),),
                ],
              ),
            ),
            SizedBox(height: 10),
            VillesList(),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text('Les ouvertes', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),),
                ],
              ),
            ),
            Consumer<PharmsProvider>(
              builder: (ctx, pharm, child) => Container(
                height: 400,
                child: Center(
                  child: PharmsGrid(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text('De garde', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),),
                ],
              ),
            ),
            SliderList(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){},
      ),
    );
  }
}
