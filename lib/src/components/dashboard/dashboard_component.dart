import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angulardart/src/components/player-search/player_search_component.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:angulardart/src/services/player_service.dart';

import '../../route_paths.dart';

@Component(
    selector: 'dashboard',
    templateUrl: 'dashboard_component.html',
    styleUrls: ['dashboard_component.css'],
    directives: [coreDirectives, routerDirectives, PlayerSearchComponent],
)
class DashboardComponent implements OnInit{
    final PlayerService _playerService;

    List<Player> players;

    DashboardComponent(this._playerService);

    @override
    void ngOnInit() async {
        players = (await this._playerService.getAll())
            .skip(1)
            .take(3)
            .toList();
    }

    String playerUrl(int id) => RoutePaths.player.toUrl(parameters: {idParam: '$id'});
}
