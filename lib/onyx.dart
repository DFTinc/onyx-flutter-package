///the onyx fingerprint plugin.
library onyx;

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part "onyx_camera.dart";
part "onyx_options.dart";
part "onyx_results.dart";
part "onyx_state.dart";
part "onyx_statuses.dart";
part "onyx_fingerprint_template.dart";

enum ReticleOrientations { LEFT, RIGHT, THUMB_PORTRAIT }

extension ReticleOrientationExtension on ReticleOrientations {
  String toValueString() {
    return this.toString().split('.').last;
  }
}

enum LayoutPreference { FULL, UPPER_THIRD }

extension LayoutPreferenceExtension on LayoutPreference {
  String toValueString() {
    return this.toString().split('.').last;
  }
}
