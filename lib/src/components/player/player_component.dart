import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angulardart/src/components/add-player-form/add_player_form_component.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:angulardart/src/services/player_service.dart';

import '../../route_paths.dart';

@Component(
    selector: 'player-component',
    templateUrl: 'player_component.html',
    styleUrls: ['player_component.css'],
    directives: [
        coreDirectives,
        formDirectives,
        AddPlayerFormComponent],
    pipes: [commonPipes],
)
class PlayerComponent implements OnInit {
    final PlayerService _playerService;
    final Router _router;

    List<Player> players;

    PlayerComponent(this._playerService, this._router);

    @override
    void ngOnInit() => this._getPlayers();

    void _getPlayers() {
        _playerService.getAll().then((players) => this.players = players);
    }

    String _playerUrl(int id) =>
        RoutePaths.player.toUrl(parameters: {idParam: '$id'});

    Future<NavigationResult> gotoDetail(int id) =>
        _router.navigate(_playerUrl(id));

    Future<void> add(Player newPlayer) async {
        players.add(await _playerService.create(newPlayer));
    }

    Future<void> delete(Player player) async {
        await _playerService.delete(player.id);
        players.remove(player);
    }
}
