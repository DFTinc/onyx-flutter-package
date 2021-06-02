part of onyx;

class OnyxFingerprintTemplate {
  OnyxFingerprintTemplate._(dynamic finger) {
    image = finger["image"];
    location = finger["location"];
    nfiqScore = finger["nfiqScore"];
    quality = finger["quality"];
    id = finger["customId"];
  }

  Uint8List? image;
  late String location;
  late int nfiqScore;
  late int quality;
  late String id;
}
