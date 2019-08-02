import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:angular_components/angular_components.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:intl/intl.dart';
class InMemoryDataService extends MockClient {
    static final _mockDbPlayers = [
        {'id':  1, 'number':  1, 'birthDate': '1991-05-01', 'name': 'Tyson'  , 'lastName': 'Farago'        , 'nationality': 'Canada' , 'position': 'Goalkeeper', 'image': 'assets/Tyson-Farago-min.jpg'},
        {'id':  2, 'number':  2, 'birthDate': '1999-05-06', 'name': 'Raphaël', 'lastName': 'Garcia'        , 'nationality': 'Canada' , 'position': 'Defender'  , 'image': 'assets/Raphael-Garcia-min.jpg'},
        {'id':  3, 'number':  3, 'birthDate': '1993-07-27', 'name': 'Skylar' , 'lastName': 'Thomas'        , 'nationality': 'Canada' , 'position': 'Defender'  , 'image': 'assets/Skylar-Thomas-min.jpg'},
        {'id':  4, 'number':  4, 'birthDate': '1993-05-02', 'name': 'Jordan' , 'lastName': 'Murrell'       , 'nationality': 'Canada' , 'position': 'Defender'  , 'image': 'assets/Jordan-Murrel-min.jpg'},
        {'id':  5, 'number':  5, 'birthDate': '1995-09-15', 'name': 'Louis'  , 'lastName': 'Béland-Goyette', 'nationality': 'Canada' , 'position': 'Midfielder', 'image': 'assets/Louis-Beland-Goyette-min.jpg'},
        {'id':  6, 'number':  6, 'birthDate': '1991-09-06', 'name': 'Martín' , 'lastName': 'Arguiñarena'   , 'nationality': 'Uruguay', 'position': 'Defender'  , 'image': 'assets/Martin-Arguinarena-min.jpg'},
        {'id':  7, 'number':  7, 'birthDate': '1995-03-04', 'name': 'Dylan'  , 'lastName': 'Sacramento'    , 'nationality': 'Canada' , 'position': 'Midfielder', 'image': 'assets/Dylan-Sacramento-min.jpg'},
        {'id':  8, 'number':  8, 'birthDate': '1997-02-18', 'name': 'Diego'  , 'lastName': 'Gutiérrez'     , 'nationality': 'Canada' , 'position': 'Midfielder', 'image': 'assets/Diego-Gutierrez-min.jpg'},
        {'id':  9, 'number':  9, 'birthDate': '1995-07-09', 'name': 'Michael', 'lastName': 'Petrasso'      , 'nationality': 'Canada' , 'position': 'Midfielder', 'image': 'assets/Michael-Petrasso-min.jpg'},
        {'id': 10, 'number': 10, 'birthDate': '1995-01-20', 'name': 'Dylan'  , 'lastName': 'Carreiro'      , 'nationality': 'Canada' , 'position': 'Midfielder', 'image': 'assets/Dylan-Carreiro-min.jpg'},
        {'id': 11, 'number': 11, 'birthDate': '1999-01-03', 'name': 'Glenn'  , 'lastName': 'Muenkat'       , 'nationality': 'Canada' , 'position': 'Midfielder', 'image': 'assets/Glenn-Muenkat-min.jpg'}
    ];

    static List<Player> _playersDb;
    static int _nextId;

    static Future<Response> _handler(Request request) async {
        if (_playersDb == null) resetDb();
        var data;
        switch (request.method) {

            case 'GET':
                final id = int.tryParse(request.url.pathSegments.last);
                if (id != null) {
                    data = _playersDb
                        .firstWhere((player) => player.id == id);
                } else {
                    String prefix = request.url.queryParameters['name'] ?? '';
                    final regExp = RegExp(prefix, caseSensitive: false);
                    data = _playersDb.where((player) => player.name.contains(regExp)).toList();
                }
                break;

            case 'POST':
                var newPlayer = _processPlayerFromRequestBody(
                    _nextId++, request.body);

                _playersDb.add(newPlayer);
                data = newPlayer;
                break;

            case 'PUT':
                Player updatedPlayer = Player.fromJson(json.decode(request.body));
                Player targetPlayer = _playersDb.firstWhere((h) => h.id == updatedPlayer.id);
                _updatePlayerInDb(updatedPlayer, targetPlayer);
                data = targetPlayer;
                break;

            case 'DELETE':
                var id = int.parse(request.url.pathSegments.last);
                _playersDb.removeWhere((player) => player.id == id);
                break;

            default:
                throw 'Unimplemented HTTP method ${request.method}';
        }

        return Response(json.encode({'data': data}), 200,
            headers: {'content-type': 'application/json'});
    }
    
    static Player _processPlayerFromRequestBody(int id, String requestBody) {
        var number = json.decode(requestBody)['number'] != null
            ? json.decode(requestBody)['number']
            : 0;

        var birthDate = json.decode(requestBody)['birthDate'] != null
            ? _toDate(json.decode(requestBody)['birthDate'])
            : Date.today();

        var name = json.decode(requestBody)['name'] != null
            ? json.decode(requestBody)['name']
            : 'empty';

        var lastName = json.decode(requestBody)['lastName'] != null
            ? json.decode(requestBody)['lastName']
            : 'empty';

        var nationality = json.decode(requestBody)['nationality'] != null
            ? json.decode(requestBody)['nationality']
            : 'empty';

        var position = json.decode(requestBody)['position'] != null
            ? json.decode(requestBody)['position']
            : 'empty';

        var image = json.decode(requestBody)['image'] != null
            ? json.decode(requestBody)['image']
            : 'empty';

        return Player(id, number, birthDate, name,
            lastName, nationality, position, image);
    }

    static void _updatePlayerInDb(Player update, Player target) {
        target.number = update.number;
        target.birthDate = update.birthDate;
        target.name = update.name;
        target.lastName = update.lastName;
        target.position = update.position;
        target.nationality = update.nationality;

    }

    static resetDb() {
        _playersDb = _mockDbPlayers.map((json) => Player.fromJson(json)).toList();
        _nextId = _playersDb.map((player) => player.id).fold(0, max) + 1;
    }

    static String lookUpName(int id) =>
        _playersDb.firstWhere((player) => player.id == id, orElse: null)?.name;
    InMemoryDataService() : super(_handler);

    static Date _toDate(date) => date is Date ? date : Date.parse(date,
        new DateFormat('yyyy-MM-dd'));
}