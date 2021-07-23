part of onyx;

///the onyx results class.
class OnyxResults {
  OnyxResults._([this.livenessConfidence = 0]);
  OnyxResults._loadResults(MethodCall call, [this.livenessConfidence = 0]) {
    if (call.arguments["rawFingerprintImages"] != null) {
      for (var image in call.arguments["rawFingerprintImages"]) {
        rawFingerprintImages.add(image);
      }
    }
    if (call.arguments["processedFingerprintImages"] != null) {
      for (var image in call.arguments["processedFingerprintImages"]) {
        processedFingerprintImages.add(image);
      }
    }
    if (call.arguments["enhancedFingerprintImages"] != null) {
      for (var image in call.arguments["enhancedFingerprintImages"]) {
        enhancedFingerprintImages.add(image);
      }
    }
    if (call.arguments["blackWhiteProcessedFingerprintImages"] != null) {
      for (var image
          in call.arguments["blackWhiteProcessedFingerprintImages"]) {
        blackWhiteProcessedFingerprintImages.add(image);
      }
    }
    if (call.arguments["wsqData"] != null) {
      for (var image in call.arguments["wsqData"]) {
        wsqData.add(image);
      }
    }
    if (call.arguments["pgmData"] != null) {
      for (var image in call.arguments["pgmData"]) {
        pgmData.add(image);
      }
    }
    if (call.arguments["fingerprintTemplates"] != null) {
      for (var template in call.arguments["fingerprintTemplates"]) {
        fingerprintTemplates.add(OnyxFingerprintTemplate._(template));
      }
    }
    if (call.arguments["iosFingerprintTemplates"] != null) {
      for (var template in call.arguments["iosFingerprintTemplates"]) {
        fingerprintTemplates.add(OnyxFingerprintTemplate._iOS(template));
      }
    }
    if (call.arguments["iosISOFingerprintTemplates"] != null) {
      for (var template in call.arguments["iosISOFingerprintTemplates"]) {
        isoFingerprintTemplates.add(OnyxFingerprintTemplate._iOS(template));
      }
    }
    fullFrameImage = call.arguments["fullFrameImage"];
    livenessConfidence = call.arguments["livenessConfidence"];
    if (call.arguments["nfiqScores"] != null) {
      for (var score in call.arguments["nfiqScores"]) {
        if (score != 0) {
          nfiqScores.add(score);
        }
      }
    }
    if (call.arguments["mlpScores"] != null) {
      for (var score in call.arguments["mlpScores"]) {
        if (score != 0) {
          mlpScores.add(score);
        }
      }
    }
    hasMatches = call.arguments["hasMatches"];
    focusQuality = call.arguments["focusQuality"];
  }

  /// The raw fingerprint images.
  List<Uint8List> rawFingerprintImages = [];

  /// The processed fingerprint images.
  List<Uint8List> processedFingerprintImages = [];

  /// The enhanced fingerprint Images.
  List<Uint8List> enhancedFingerprintImages = [];

  /// The black and white processed fingerprint Images.
  /// Only returned in iOS
  List<Uint8List> blackWhiteProcessedFingerprintImages = [];

  ///wsq Data
  List<Uint8List> wsqData = [];

  ///pgm Data
  /// Only returned in Android.
  List<Uint8List> pgmData = [];

  ///the fingerprint templates.
  List<OnyxFingerprintTemplate> fingerprintTemplates = [];

  ///the IDO fingerprint templates.
  List<OnyxFingerprintTemplate> isoFingerprintTemplates = [];

  ///the full frame image.
  /// Only returned in Android.
  Uint8List? fullFrameImage;

  /// The liveness confidence.
  double? livenessConfidence;

  ///the focus quality.
  double? focusQuality;

  ///the nfiq scores
  List<int> nfiqScores = [];

  ///the mlp scores for the images.
  List<double> mlpScores = [];

  /// if the fingerprints have a match.  null if not checked.
  /// Only returned in Android.
  bool? hasMatches;
}
