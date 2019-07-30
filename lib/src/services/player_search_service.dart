import 'dart:async';
import 'dart:convert';
import 'package:angulardart/src/models/player.dart';
import 'package:http/http.dart';


class PlayerSearchService {
    final Client _http;

    PlayerSearchService(this._http);

    Future<List<Player>> search(String term) async {
        try {
            final response = await _http.get('app/players/?name=$term');
            return (_extractData(response) as List)
                .map((json) => Player.fromJson(json))
                .toList();
        } catch (e) {
            throw _handleError(e);
        }
    }

    dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

    Exception _handleError(dynamic e) {
        print(e);
        return Exception('Server error; cause: $e');
    }
}