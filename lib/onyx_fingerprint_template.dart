part of onyx;

///the finderprint template that is returned from onyx
class OnyxFingerprintTemplate {
  OnyxFingerprintTemplate._(dynamic finger) {
    file = finger["image"];
    location = finger["location"];
    nfiqScore = finger["nfiqScore"];
    quality = finger["quality"];
    id = finger["customId"];
  }

  OnyxFingerprintTemplate._iOS(dynamic image) {
    file = image;
  }

  ///the fingerprint image.
  Uint8List? file;

  /// the location of the fingerprint.
  late String location = "";

  ///the nfiq score of the fingerprint.
  late int nfiqScore = -1;

  ///the fingerprint's quality score.
  late int quality = -1;

  ///the Id of the fingerprint result.
  late String id = "";
}
