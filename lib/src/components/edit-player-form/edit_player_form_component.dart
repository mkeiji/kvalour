import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angulardart/src/models/player.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
    selector: 'edit-player-form',
    templateUrl: 'edit_player_form_component.html',
    directives: [coreDirectives, formDirectives])
class EditPlayerFormComponent implements OnInit {
    final _playerStreamer = StreamController<Object>();

    @Input() Player currentPlayer;
    @Output() Stream<Object> get savedPlayer => _playerStreamer.stream;

    bool isEditMode;
    Player player;
    String strBirthDate;

    EditPlayerFormComponent();

    @override
    void ngOnInit() {
        isEditMode = false;
        player = currentPlayer;
        strBirthDate = player.birthDate.toString();
    }

    void onSubmit() {
        changeEditMode();
        Player.saveBirthDate(player, strBirthDate);
        _playerStreamer.add(player);
    }

    void changeEditMode() => isEditMode = isEditMode ? isEditMode = false : isEditMode = true;
}