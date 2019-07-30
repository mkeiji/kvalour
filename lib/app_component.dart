import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angulardart/src/components/player-search/player_search_component.dart';
import 'package:angulardart/src/route_paths.dart';
import 'package:angulardart/src/routes.dart';
import 'package:angulardart/src/services/player_service.dart';

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [routerDirectives, PlayerSearchComponent],
    providers: [ClassProvider(PlayerService)],
    exports: [RoutePaths, Routes],
)
class AppComponent {
    final title = 'K-Valour';
}
