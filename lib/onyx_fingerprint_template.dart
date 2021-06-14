part of onyx;

///the finderprint template that is returned from onyx
class OnyxFingerprintTemplate {
  OnyxFingerprintTemplate._(dynamic finger) {
    image = finger["image"];
    location = finger["location"];
    nfiqScore = finger["nfiqScore"];
    quality = finger["quality"];
    id = finger["customId"];
  }

  ///the fingerprint image.
  Uint8List? image;

  /// the location of the fingerprint.
  late String location;

  ///the nfiq score of the fingerprint.
  late int nfiqScore;

  ///the fingerprint's quality score.
  late int quality;

  ///the Id of the fingerprint result.
  late String id;
}
