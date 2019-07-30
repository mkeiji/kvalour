import 'package:angular_router/angular_router.dart';
import 'package:angulardart/src/route_paths.dart';
import 'components/player-detail/player_detail_component.template.dart' as player_detail_template;
import 'components/player/player_component.template.dart' as player_template;
import 'components/dashboard/dashboard_component.template.dart' as dashboard_template;

export 'route_paths.dart';

class Routes {
    static final player = RouteDefinition(
        routePath: RoutePaths.player,
        component: player_detail_template.PlayerDetailComponentNgFactory,
    );

    static final players = RouteDefinition(
        routePath: RoutePaths.players,
        component: player_template.PlayerComponentNgFactory,
    );

    static final dashboard = RouteDefinition(
        routePath: RoutePaths.dashboard,
        component: dashboard_template.DashboardComponentNgFactory,
    );

    static final all = <RouteDefinition>[
        player,
        players,
        dashboard,
        RouteDefinition.redirect(
            path: '',
            redirectTo: RoutePaths.dashboard.toUrl(),
        )
    ];
}