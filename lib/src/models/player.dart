import 'package:angular_components/angular_components.dart';
import "package:intl/intl.dart";

class Player {
  final int id;
  int number;
  Date birthDate;
  String name;
  String lastName;
  String nationality;
  String position;
  String image;

  Player(this.id, this.number, this.birthDate, this.name, this.lastName,
      this.nationality, this.position, this.image);

  factory Player.fromJson(Map<String, dynamic> player) =>
      Player(
          _toInt(player['id']),
          _toInt(player['number']),
          toDate(player['birthDate']),
          player['name'],
          player['lastName'],
          player['nationality'],
          player['position'],
          player['image']
      );

  Map toJson() => {
    'id'         : id                   ,
    'number'     : number               ,
    'birthDate'  : birthDate.toString() ,
    'name'       : name                 ,
    'lastName'   : lastName             ,
    'nationality': nationality          ,
    'position'   : position             ,
    'image'      : image
  };

  static Date toDate(date) => date is Date ? date : Date.parse(date,
      new DateFormat('yyyy-MM-dd'));

  static void saveBirthDate(Player player, String birthDate) =>
      player.birthDate = toDate(birthDate);
}


int _toInt(id) => id is int ? id : int.parse(id);
