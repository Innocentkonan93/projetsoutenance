// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pharma/models/services.dart';
// import 'package:pharma/models/villes.dart';
// import 'package:pharma/models/villes_list.dart';
// import 'package:pharma/screens/login/login_screen.dart';
// import 'package:http/http.dart' as http;

// class Search extends StatefulWidget {
//   @override
  
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {


//   Future<List> getData() async {
//     final res = await http.get("http://bad-event.com/pharma/getVille.php");
//     return json.decode(res.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Text(
//           'Pharmacies',
//           style: GoogleFonts.architectsDaughter(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 2,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.search,
//               size: 30,
//             ),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: DataSearch(),
//               );
//             },
//           )
//         ],
//       ),
//       body: FutureBuilder<List>(
//         future: getData(),
//         builder: (ctx, ss) {
//           if (ss.hasError) {
//             print("Erreur");
//           }
//           if (ss.hasData) {
//             return Column(
//               children: [
//                 Items(list: ss.data),
//               ],
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // actions for appbar
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       ),
//     ];
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // leading icon on the left on the appbar
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Center(
//       child: Container(
//         height: 100,
//         width: double.infinity,
//         color: Colors.deepOrangeAccent,
//       ),
//     );
//     // show some result based on the selection
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // show when someone searches for something
//     final suggestionList = query.isEmpty
//         ? filteredVille
//         : ville.where((element) => element.startsWith(query)).toList();
//     return ListView.builder(
//       itemBuilder: (context, i) {
//         return ListTile(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => VilleList()),
//             );
//           },
//           leading: Icon(Icons.location_city),
//           title: RichText(
//             text: TextSpan(
//                 text: suggestionList[i].substring(0, query.length),
//                 style:
//                     TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
//                 children: [
//                   TextSpan(
//                       text: suggestionList[i].substring(query.length),
//                       style: TextStyle(color: Colors.grey)),
//                 ]),
//           ),
//         );
//       },
//       itemCount: suggestionList.length,
//     );
//     throw UnimplementedError();
//   }
// }

// class DataSearch extends SearchDelegate<String> {
//   final mylist = [
//     "josco 1",
//     "Matai 1",
//     "Lorem 1",
//     "Voita 1",
//     "Coifi 1",
//     "POutch 1",
//     "Rafco 1",
//     "Mamen 1",
//     "Boff 1",
//   ];

//   final recentMylist = [
//     "josco 1",
//     "Matai 1",
//     "Lorem 1",
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // actions for appbar
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       ),
//     ];
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // leading icon on the left on the appbar
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Center(
//       child: Container(
//         height: 100,
//         width: double.infinity,
//         color: Colors.deepOrangeAccent,
//       ),
//     );
//     // show some result based on the selection
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // show when someone searches for something
//     final suggestionList = query.isEmpty
//         ? recentMylist
//         : mylist.where((element) => element.startsWith(query)).toList();
//     return ListView.builder(
//       itemBuilder: (context, i) {
//         return ListTile(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => VilleList()),
//             );
//           },
//           leading: Icon(Icons.location_city),
//           title: RichText(
//             text: TextSpan(
//                 text: suggestionList[i].substring(0, query.length),
//                 style:
//                     TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
//                 children: [
//                   TextSpan(
//                       text: suggestionList[i].substring(query.length),
//                       style: TextStyle(color: Colors.grey)),
//                 ]),
//           ),
//         );
//       },
//       itemCount: suggestionList.length,
//     );
//     throw UnimplementedError();
//   }
// }
