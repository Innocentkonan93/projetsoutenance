import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/controllers/ville_provider.dart';
import 'package:pharm_point/services/api_helpers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Pharm/map_screen.dart';
import 'Pharm/map_screen.dart';

class GlobalMapScreen extends StatefulWidget {
  static const routeName = '/global-map';


  @override
  _GlobalMapScreenState createState() => _GlobalMapScreenState();
}

class _GlobalMapScreenState extends State<GlobalMapScreen> {
  void _launchURL(String tel) async =>
      await canLaunch('tel:$tel') ? await launch('tel:$tel') : throw 'Could not launch $tel';

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
    final villeList = Provider.of<VilleProvider>(context);
    final ville = villeList.listVilles;

    return new Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: new FlutterMap(
                options: MapOptions(
                  center: LatLng(6.8160619, -5.3511765),
                  zoom: 6.5,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(
                    markers: List.generate(ville.length, (index) {
                      return Marker(
                        width: 400.0,
                        height: 400.0,
                        point: LatLng(double.parse(ville[index].lati),
                            double.parse(ville[index].longi)),
                        builder: (ctx) => Container(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  final idVille = ville[index].id;
                                  final pharmsList =
                                      Provider.of<PharmsProvider>(context);
                                  final pharms = pharmsList.listPharms
                                      .where((element) =>
                                          element.idVille == idVille)
                                      .toList();
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    height: 390,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                          child: Row(
                                            children: [
                                              Text(ville[index]
                                                  .nom
                                                  .toUpperCase(), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),),
                                              Text(pharms.length.toString() + ' Pharmacie', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.teal),)
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Recherche une pharmacie',
                                                suffixIcon: Icon(Icons.search)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Expanded(

                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            color: Colors.grey.withOpacity(0.1),
                                            child: Scrollbar(
                                              child: ListView.builder(
                                                itemBuilder: (context, i) {
                                                  return Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 8,
                                                    ),
                                                    height: 80,
                                                    width: double.infinity,
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                pharms[i].nom,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              ),
                                                              Text(
                                                                pharms[i]
                                                                    .statut == 'ouvert' ? 'Ouvert' : 'Fermée',
                                                                style:
                                                                    TextStyle(),
                                                              )
                                                            ],
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              CircleAvatar(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .call),
                                                                  onPressed:
                                                                  (){
                                                                    final number = pharms[i].tel.split('/');
                                                                    _launchURL('${number.last}');
                                                                  }
                                                                ),
                                                              ),
                                                              CircleAvatar(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .location_pin,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) => MapScreen(
                                                                                  (pharms[i].id)
                                                                                )));
                                                                  },
                                                                ),
                                                                backgroundColor: Colors
                                                                    .redAccent
                                                                    .withOpacity(
                                                                        0.1),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount: pharms.length,
                                              ),
                                              isAlwaysShown: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}
