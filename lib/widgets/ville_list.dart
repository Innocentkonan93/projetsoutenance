import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/controllers/ville_provider.dart';
import 'package:pharm_point/screens/ville_screen.dart';
import 'package:pharm_point/services/api_helpers.dart';
import 'package:provider/provider.dart';

class VillesList extends StatefulWidget {
  @override
  _VillesListState createState() => _VillesListState();
}

class _VillesListState extends State<VillesList> {
  getVilles() async {
    var provider = Provider.of<VilleProvider>(context, listen: false);
    var resp = await AllVilles.getAllVilles();
    if (resp.isSuccesful) {
      provider.setVilleList(resp.data);
    }
  }

  @override
  void initState() {
    super.initState();
    getVilles();
  }

  @override
  Widget build(BuildContext context) {
    final villeList = Provider.of<VilleProvider>(context);
    final ville = villeList.listVilles;
    return Container(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ville.length,
        itemBuilder: (ctx, i) {
          return Hero(
            tag: 'ville[i].id',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  VilleScreen.routeName,
                  arguments: ville[i].id,
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://bad-event.com/pharma/pharmImg/${ville[i].image}'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    ville[i].nom.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
