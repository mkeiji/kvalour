import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/model/date/date.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
    selector: 'add-player-form',
    templateUrl: 'add_player_form_component.html',
    styleUrls: ['add_player_form_component.css'],
    directives: [coreDirectives, formDirectives])
class AddPlayerFormComponent implements OnInit {
    final _playerStreamer = StreamController<Object>();

    @Input() Player currentPlayer;
    @Output() Stream<Object> get addedPlayer => _playerStreamer.stream;

    bool isAddMode;
    Player player;
    String strBirthDate = Date.today().toString();

    AddPlayerFormComponent();

    @override
    void ngOnInit() {
        isAddMode = false;
        player = currentPlayer == null ? modelPlayer() : currentPlayer;
    }

    void clear() => player = modelPlayer();

    void changeAddMode() => isAddMode ? isAddMode = false : isAddMode = true;

    void onSubmit() {
        isAddMode = false;

        player.birthDate=Player.toDate(strBirthDate);
        _playerStreamer.add(player);
    }

    static Player modelPlayer() => Player(null, 0, Date.today(), 'Dave',
        '-', '-', '-', '-');
}