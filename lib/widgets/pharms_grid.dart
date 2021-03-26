import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/screens/Pharm/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmsGrid extends StatefulWidget {
  @override
  _PharmsGridState createState() => _PharmsGridState();
}

class _PharmsGridState extends State<PharmsGrid> {
  void _launchURL(String tel) async =>
      await canLaunch('tel:$tel') ? await launch('tel:$tel') : throw 'Could not launch $tel';
  //
  _showModalBottom() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      builder: (content) {
        return Container(
          padding: EdgeInsets.all(8),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.call,
                        size: 35,
                        color: Colors.teal,
                      ),
                      Text('Appeler')
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 35,
                        color: Colors.orange.shade900,
                      ),
                      Text('Localiser')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.teal, width: 0.5),
                    ),
                    color: Colors.transparent,
                    elevation: 0.0,
                    onPressed: () {},
                    child: Text('Consulter'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pharmList = Provider.of<PharmsProvider>(context);
    final pharms = pharmList.listPharms.where((element) => element.statut == 'ouvert').toList();
    final size = MediaQuery.of(context).size;
    // .where((element) => element.idVille == '1')
    // .toList();
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 3,
        crossAxisSpacing: size.height * 0.02,
        mainAxisSpacing: size.width * 0.04,
      ),
      itemCount: pharms.length > 0 ? 9 : pharms.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              builder: (content) {
                return Container(
                  padding: EdgeInsets.all(8),
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pharms[i].nom,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            onPressed: () {
                              final number = pharms[i].tel.split('/');
                              _launchURL('${number.last}');
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 20,
                                  color: Colors.teal,
                                ),
                                Text(
                                  'Appeler',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigator.of(context).pushNamed(
                              //   MapScreen.nameRoute,
                              //   arguments: pharms[i].id,
                              // );

                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MapScreen(pharms[i].id);
                                  });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 20,
                                  color: Colors.orange.shade900,
                                ),
                                Text(
                                  'Localiser',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            color: Colors.teal,
                            elevation: 0.0,
                            onPressed: () {},
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Consulter',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border.all(
                  color: pharms[i].statut == 'ouvert'
                      ? Colors.teal
                      : Colors.red.shade200,
                  width: 0.1),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: pharms[i].statut == 'ouvert'
                      ? Colors.teal.withOpacity(0.9)
                      : Colors.red.withOpacity(0.9),
                  offset: Offset(
                    0.3,
                    0.4,
                  ),
                  blurRadius: 1,
                  spreadRadius: 0.3,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services,
                  size: 27,
                  color: pharms[i].statut == 'ouvert'
                      ? Colors.teal
                      : Colors.red.shade300,
                ),
                Text(
                  pharms[i].nom,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
