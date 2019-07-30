import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:angulardart/src/services/player_search_service.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../route_paths.dart';

@Component(
    selector: 'player-search',
    templateUrl: 'player_search_component.html',
    styleUrls: ['player_search_component.css'],
    directives: [coreDirectives],
    providers: [ClassProvider(PlayerSearchService)],
    pipes: [commonPipes],
)
class PlayerSearchComponent implements OnInit {
    PlayerSearchService _playerSearchService;
    Router _router;
    String searchBoxValue;
    Stream<List<Player>> players;
    StreamController<String> _searchTerms = StreamController<String>.broadcast();

    PlayerSearchComponent(this._playerSearchService, this._router);

    void search(String term) => _searchTerms.add(term);

    void ngOnInit() async {
        players = _searchTerms.stream
            .transform(debounce(Duration(milliseconds: 300)))
            .distinct()
            .transform(switchMap((term) => term.isEmpty
                ? Stream<List<Player>>.fromIterable([<Player>[]])
                : _playerSearchService.search(term)
                    .asStream()))
                    .handleError((e) => print(e));
    }

    String _playerUrl(int id) =>
        RoutePaths.player.toUrl(parameters: {idParam: '$id'});

    Future<NavigationResult> gotoDetail(Player player) {
        ngOnInit();
        return _router.navigate(_playerUrl(player.id));
    }
}