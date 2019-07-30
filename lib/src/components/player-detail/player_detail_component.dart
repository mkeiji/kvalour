import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angulardart/src/components/edit-player-form/edit_player_form_component.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:angulardart/src/services/player_service.dart';
import 'package:angular_router/angular_router.dart';
import '../../route_paths.dart';

@Component(
    selector: 'player-detail-component',
    templateUrl: 'player_detail_component.html',
    styleUrls: ['player_detail_component.css'],
    directives: [coreDirectives, formDirectives, EditPlayerFormComponent])
class PlayerDetailComponent implements OnActivate {
    final PlayerService _playerService;
    final Location _location;
    Player player;

    PlayerDetailComponent(this._playerService, this._location);

    @override
    void onActivate(_, RouterState current) async {
        final id = getId(current.parameters);
        if (id != null) player = await (_playerService.get(id));
    }

    int getId(Map<String, String> parameters) {
        final id = parameters[idParam];
        return id == null ? null : int.tryParse(id);
    }

    void goBack() => _location.back();

    Future<void> save(Player savedPlayer) async =>
        await _playerService.update(savedPlayer);
}
