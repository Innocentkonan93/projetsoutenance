import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/controllers/ville_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Pharm/map_screen.dart';

class VilleScreen extends StatefulWidget {
  static const routeName = 'ville-screen/';

  @override
  _VilleScreenState createState() => _VilleScreenState();
}

class _VilleScreenState extends State<VilleScreen> {
  void _launchURL(String tel) async =>
      await canLaunch('tel:$tel') ? await launch('tel:$tel') : throw 'Could not launch $tel';
  @override
  Widget build(BuildContext context) {
    final villeId = ModalRoute.of(context).settings.arguments as String;
    final villeList = Provider.of<VilleProvider>(context);
    final villes =
        villeList.listVilles.firstWhere((element) => element.id == villeId);
    final pharmList = Provider.of<PharmsProvider>(context);
    final pharms = pharmList.listPharms;
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: villes.id,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'http://bad-event.com/pharma/pharmImg/${villes.image}'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300,
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            child: BackButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(villes.nom.toUpperCase(), style: TextStyle(
                        fontSize: 27, color: Colors.white,
                      ),)
                    ],)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                return  Container(
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
              itemCount:pharms.length ,
            ),
          ),
        ],
      ),
    );
  }
}
