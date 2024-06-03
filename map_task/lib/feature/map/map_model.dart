import 'dart:convert';

class FeatureCollection {
  String type;
  List<Feature> features;

  FeatureCollection({
    required this.type,
    required this.features,
  });

  factory FeatureCollection.fromJson(Map<String, dynamic> json) {
    return FeatureCollection(
      type: json['type'],
      features: List<Feature>.from(
          json['features'].map((feature) => Feature.fromJson(feature))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'features': features.map((feature) => feature.toJson()).toList(),
    };
  }
}

class Feature {
  String type;
  Properties properties;
  Geometry geometry;

  Feature({
  required  this.type,
  required  this.properties,
  required  this.geometry,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      type: json['type'],
      properties: Properties.fromJson(json['properties']),
      geometry: Geometry.fromJson(json['geometry']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'properties': properties.toJson(),
      'geometry': geometry.toJson(),
    };
  }
}

class Properties {
  int scalerank;
  String name;
  dynamic comment;
  dynamic nameAlt;
  double latY;
  double longX;
  String region;
  dynamic subregion;
  String featureclass;

  Properties({
 required  this.scalerank,
 required  this.name,
 required  this.comment,
 required  this.nameAlt,
 required  this.latY,
 required  this.longX,
 required  this.region,
 required  this.subregion,
 required  this.featureclass,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      scalerank: json['scalerank'],
      name: json['name'],
      comment: json['comment'],
      nameAlt: json['name_alt'],
      latY: json['lat_y'],
      longX: json['long_x'],
      region: json['region'],
      subregion: json['subregion'],
      featureclass: json['featureclass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scalerank': scalerank,
      'name': name,
      'comment': comment,
      'name_alt': nameAlt,
      'lat_y': latY,
      'long_x': longX,
      'region': region,
      'subregion': subregion,
      'featureclass': featureclass,
    };
  }
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({
   required this.type,
   required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

// void main() {
//   // JSON string
//   String jsonString = '''
//   {
//     "type": "FeatureCollection",
//     "features": [
//       {
//         "type": "Feature",
//         "properties": {
//           "scalerank": 2,
//           "name": "Niagara Falls",
//           "comment": null,
//           "name_alt": null,
//           "lat_y": 43.087653,
//           "long_x": -79.044073,
//           "region": "North America",
//           "subregion": null,
//           "featureclass": "waterfall"
//         },
//         "geometry": {
//           "type": "Point",
//           "coordinates": [
//             -79.04411780507252,
//             43.08771393436908
//           ]
//         }
//       },
//       {
//         "type": "Feature",
//         "properties": {
//           "scalerank": 2,
//           "name": "Niagara Falls",
//           "comment": null,
//           "name_alt": null,
//           "lat_y": 43.087653,
//           "long_x": -79.044073,
//           "region": "North America",
//           "subregion": null,
//           "featureclass": "waterfall"
//         },
//         "geometry": {
//           "type": "Point",
//           "coordinates": [
//             -79.04411780507252,
//             43.08771393436908
//           ]
//         }
//       }
//     ]
//   }
//   ''';
//
//   // Convert JSON string to Dart object
//   Map<String, dynamic> jsonMap = json.decode(jsonString);
//   FeatureCollection featureCollection = FeatureCollection.fromJson(jsonMap);
//
//   // Convert Dart object back to JSON string
//   String convertedJsonString = json.encode(featureCollection);
//   print(convertedJsonString);
// }
