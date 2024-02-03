import 'dart:convert';

Geo geoFromJson(String str) => Geo.fromJson(json.decode(str));
String geoToJson(Geo data) => json.encode(data.toJson());
class Geo {
  Geo({
      this.lat, 
      this.lng,});

  Geo.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  String? lat;
  String? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}