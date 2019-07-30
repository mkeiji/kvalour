import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
    static final players = RoutePath(path: 'players');
    static final dashboard = RoutePath(path: 'dashboard');
    static final player = RoutePath(path: '${players.path}/:$idParam');
}