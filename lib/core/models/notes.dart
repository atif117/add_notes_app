import 'package:get/get_connect/http/src/utils/utils.dart';

class Note {
  String? id;
  String? tital;
  String? description;
  DateTime? regDateTime;
  Note({this.description, this.id, this.regDateTime, this.tital});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["tital"] = tital;
    data["description"] = description;
    data["regDateTime"] = regDateTime;
    return data;
  }

  Note.fromJson(json, id) {
    this.id = id;
    tital = json["tital"];
    description = json["description"];
    regDateTime = json["regDateTime"].toDate();
  }
}
