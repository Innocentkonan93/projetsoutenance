import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/Pharm/map_screen.dart';

class SliderList extends StatefulWidget {
  @override
  _SliderListState createState() => _SliderListState();
}

class _SliderListState extends State<SliderList> {
  void _launchURL(String tel) async =>
      await canLaunch('tel:$tel') ? await launch('tel:$tel') : throw 'Could not launch $tel';
  @override
  Widget build(BuildContext context) {
    final pharmsList = Provider.of<PharmsProvider>(context);
    final pharms = pharmsList.listPharms.where((element) => element.statut == 'ouvert').toList();
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 15),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.decelerate,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: pharms.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.11),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 70,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          border: Border.all(
                              color: i.statut == 'ouvert'
                                  ? Colors.teal
                                  : Colors.red.shade200,
                              width: 0.1),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: i.statut == 'ouvert'
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
                              color: i.statut == 'ouvert'
                                  ? Colors.teal
                                  : Colors.red.shade300,
                            ),
                            Text(
                              i.nom,
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_sharp,
                                size: 15,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                i.statut == 'ouvert' ?'Ouvert' : 'Fermée',
                                style: TextStyle(color: Colors.teal),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                child: IconButton(
                                  icon: Icon(Icons.call),
                                  onPressed: () {
                                   
                                      final number = i.tel.split('/');
                                      _launchURL('${number.last}');

                                  },
                                ),
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(i.id)));
                                  },
                                ),
                                backgroundColor: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
