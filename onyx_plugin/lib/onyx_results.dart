part of onyx;

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
      for (var image in call.arguments["fingerprintTemplates"]) {
        fingerprintTemplates.add(OnyxFingerprintTemplate._(image));
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

  /// The enhanced Fingerprint Images.
  List<Uint8List> enhancedFingerprintImages = [];

  ///wsq Data
  List<Uint8List> wsqData = [];

  ///pgm Data
  List<Uint8List> pgmData = [];
  List<OnyxFingerprintTemplate> fingerprintTemplates = [];

  ///the full frame image.
  Uint8List? fullFrameImage;

  /// The liveness confidence.
  double? livenessConfidence;
  double? focusQuality;

  ///the nfiq scores
  List<int> nfiqScores = [];
  List<double> mlpScores = [];

  /// if the fingerprints have a match.  null if not checked.
  bool? hasMatches;
}
