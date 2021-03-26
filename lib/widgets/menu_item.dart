import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/controllers/ville_provider.dart';
import 'package:pharm_point/screens/home_screen.dart';
import 'package:pharm_point/screens/ville_screen.dart';
import 'package:pharm_point/services/api_helpers.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatefulWidget {
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
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
      print('cool');
    }
  }

  @override
  void initState() {
    super.initState();
    getVilles();
    getPharms();
  }

  double top = 0;
  double left = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Health Point'), Icon(Icons.location_on)],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FadeInRightBig(
        child: Stack(
          children: [
            _stackChildren(
              'Pharmacies',
              Icons.medical_services,
              0.6,
              Colors.orangeAccent,
              () {
                getVilles();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            _stackChildren(
              'Hôpitaux',
              Icons.medical_services,
              0.4,
              Colors.white,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service bientôt disponible'),
                  ),
                );
              },
            ),
            _stackChildren(
              'Hôpitaux',
              Icons.medical_services,
              0.2,
              Colors.white,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service bientôt disponible'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _stackChildren(
    String title,
    IconData icon,
    double bottom,
    Color color,
    Function onTap, {
    Image image,
  }) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * bottom,
      right: MediaQuery.of(context).size.width * 0.28,
      left: MediaQuery.of(context).size.width * 0.28,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          elevation: 25,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: color,
            ),
            height: 130,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
