import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

///Mapping RemoteConfigValue To JSON
Map<String, dynamic> configDataToJson(Map<String, dynamic> configData) {
  return configData.map((key, value) {
    if (value is RemoteConfigValue) {
      return MapEntry(key, value.toJson());
    }
    return MapEntry(key, value);
  });
}

///Decode UTF-8 code
dynamic uTFToValue(List<dynamic> dynamicList) {
  List<int> utf8List = dynamicList.map((e) => e as int).toList();

  return const Utf8Codec().decode(utf8List);
}

/*///Mapping JSON To RemoteConfigValue
Map<String, dynamic> jsonToConfigData(Map<String, dynamic> json) {
  return json.map((key, value) {
    if (value is Map<String, dynamic> && value.containsKey('value')) {
      final dynamic configValue = value['value'];
      if (configValue is List) {
        if (configValue.isEmpty) {
          // Handle empty lists
          return MapEntry(key, RemoteConfigValue([], value['source']));
        } else if (configValue.first is int) {
          // Handle list of integers
          return MapEntry(key, RemoteConfigValue(List<int>.from(configValue), value['source']));
        } else if (configValue.first is String) {
          // Handle list of strings
          return MapEntry(key, RemoteConfigValue(List<String>.from(configValue).cast<int>(), value['source']));
        } else {
          // Handle other types of lists, if necessary
          return MapEntry(key, RemoteConfigValue(configValue.cast<int>(), value['source']));
        }
      } else {
        // Handle non-list values
        return MapEntry(key, RemoteConfigValue(configValue, value['source']));
      }
    } else if (value is List) {
      // Handle lists outside of RemoteConfigValue
      if (value.isNotEmpty && value.first is int) {
        return MapEntry(key, List<int>.from(value));
      } else if (value.isNotEmpty && value.first is String) {
        return MapEntry(key, List<String>.from(value));
      } else {
        return MapEntry(key, value);
      }
    }
    return MapEntry(key, value);
  });
}*/

/*
///JSON to Remote Config Value
RemoteConfigValue jsonToRemoteConfigValue(Map<String, dynamic> json) {
  if (!json.containsKey('value') || !json.containsKey('source')) {
    throw ArgumentError('Invalid JSON format: Missing "value" or "source" keys');
  }

  dynamic configValue = json['value'];
  String source = json['source'];

  if (configValue is List) {
    if (configValue.isEmpty) {
      // Handle empty list
      return RemoteConfigValue([], source);
    } else if (configValue.first is int) {
      // Handle list of integers
      return RemoteConfigValue(List<int>.from(configValue), source);
    } else if (configValue.first is String) {
      // Handle list of strings
      return RemoteConfigValue(List<String>.from(configValue), source);
    } else {
      // Handle list of other types
      return RemoteConfigValue(configValue, source);
    }
  }

  // Return the value directly if it's not a list
  return RemoteConfigValue(configValue, source);
}*/
