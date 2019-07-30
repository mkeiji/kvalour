import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:angulardart/src/models/player.dart';

class PlayerService {
    static const _playersUrl = 'api/players'; // mock URL to web API
    static final _headers = {'Content-Type': 'application/json'};
    final Client _http;

    PlayerService(this._http);

    Future<List<Player>> getAll() async {
        try {
            final response = await _http.get(_playersUrl);
            final players = (_extractData(response) as List)
                .map((json) => Player.fromJson(json))
                .toList();
            return players;
        } catch (e) {
            throw _handleError(e);
        }
    }

    dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

    Exception _handleError(dynamic e) {
        print(e);
        return Exception('Server error; cause: $e');
    }

    Future<Player> get(int id) async {
        try {
            final response = await _http.get('$_playersUrl/$id');
            return Player.fromJson(_extractData(response));
        } catch (e) {
            throw _handleError(e);
        }
    }

    Future<Player> update(Player player) async {
        try {
            final url = '$_playersUrl/${player.id}';
            final response = await _http.put(
                url,
                headers: _headers,
                body: json.encode(player));

            return Player.fromJson(_extractData(response));
        } catch (e) {
            throw _handleError(e);
        }
    }

    Future<Player> create(Player newPlayer) async {
        try {
            final response = await _http.post(
                _playersUrl,
                headers: _headers,
                body: json.encode(newPlayer));

            return Player.fromJson(_extractData(response));
        } catch (e) {
            throw _handleError(e);
        }
    }

    Future<void> delete(int id) async {
        try {
            final url = '$_playersUrl/$id';
            await _http.delete(url, headers: _headers);
        } catch (e) {
            throw _handleError(e);
        }
    }
}
