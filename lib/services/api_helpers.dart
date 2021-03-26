import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:pharm_point/models/HTTPResponse.dart';
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/villes.dart';

class AllVilles {
  static Future<HTTPResponse<List<Villes>>> getAllVilles() async {
    String url = 'http://bad-event.com/pharma/getVille.php';
    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Villes> _villes = [];
        body.forEach((e) {
          Villes villes = Villes.fromJson(e);
          _villes.add(villes);
        });
        return HTTPResponse(
          true,
          _villes,
          responseCode: response.statusCode,
        );
      } else {
        return HTTPResponse(
          false,
          null,
          message: 'Erreur du server',
          responseCode: response.statusCode,
        );
      }
    } on SocketException {
      return HTTPResponse(false, null,
          message: 'Vérifier votre connexion internet');
    } on FormatException {
      return HTTPResponse(false, null,
          message: 'Mauvaise réponse du server, réessayez');
    } catch (e) {
      return HTTPResponse(false, null,
          message: 'Une erreur est survenue, réessayez');
    }
  }
}

class AllPhams {
  static Future<HTTPResponse<List<Pharms>>> getAllPharms() async {
    String url = 'http://bad-event.com/pharma/getAllPharm.php';
    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        print('cool');
        var body = jsonDecode(response.body);
        List<Pharms> _pharms = [];
        body.forEach((e) {
          Pharms pharms = Pharms.fromJson(e);
          _pharms.add(pharms);
        });
        return HTTPResponse(
          true,
          _pharms,
          responseCode: response.statusCode,
        );
      } else {
        return HTTPResponse(
          false,
          null,
          message: 'Erreur du server',
          responseCode: response.statusCode,
        );
      }
    } on SocketException {
      return HTTPResponse(false, null,
          message: 'Vérifier votre connexion internet');
    } on FormatException {
      return HTTPResponse(false, null,
          message: 'Mauvaise réponse du server, réessayez');
    } catch (e) {
      return HTTPResponse(false, null,
          message: 'Une erreur est survenue, réessayez');
    }
  }
}
