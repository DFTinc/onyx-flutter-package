part of onyx;

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

///the settings for the onyx plugin
class OnyxOptions {
  OnyxOptions(
      [this.licenseKey = "7318-4496-5417-3-2",
      this.isRawImageReturned = true,
      this.cropFactor = 1.0,
      this.cropSizeHeight = 512,
      this.cropSizeWidth = 300,
      this.isProcessedImageReturned = true,
      this.isEnhancedImageReturned = true,
      this.isWSQImageReturned = true,
      this.isFingerprintTemplateImageReturned = true,
      this.isLoadingSpinnerShown = false,
      this.isImageThreshold = false,
      this.isThumbCapture = false,
      this.isManualCapture = false,
      this.isOnyxLive = false,
      this.isNFIQMetrics = false,
      this.isPGMFormatByteArrayReturned = false,
      this.isConvertToISOTemplate = false,
      this.imageRotation = 0,
      this.isFullFrameImageReturned = false,
      this.layoutPreference = LayoutPreference.FULL,
      this.reticleOrientation = ReticleOrientations.LEFT,
      this.isFourFingerReticleUsed = true,
      this.isPerformQualityCheckMatch = false,
      this.isUploadMetrics = false,
      this.isOnlyHighQualityImageReturned = false,
      this.isErrorOnNFIQ5Score = false,
      this.isShutterSoundEnabled = false,
      this.isCamera2PreviewStreamingUsed = false]);

  ///The onyx lisense key
  String? licenseKey;

  ///the onyx layout preferences.
  LayoutPreference layoutPreference;

  ///If the raw image is to be returned.
  bool isRawImageReturned;

  ///If the processed image is to be returned.
  bool isProcessedImageReturned;

  ///If the enhanced image is to be returned.
  bool isEnhancedImageReturned;

  ///If the WSQ image should be returned.
  bool isWSQImageReturned;

  ///If the fingerprint template image should be returned.
  bool isFingerprintTemplateImageReturned;

  ///If the loading spinner should be shown.
  bool isLoadingSpinnerShown;

  ///If the image threshold should be set.
  bool isImageThreshold;

  ///The width to crop the image by.
  double cropSizeWidth;

  ///The height to crop the image by.
  double cropSizeHeight;

  ///The crop factor for the image.
  double cropFactor;

  ///The targeted pixels per inch.
  ///Suggested values are around 500.0.
  double? targetPPI;

  ///If the thumb is captured
  bool isThumbCapture;

  ///If it's a manual capture.
  bool isManualCapture;

  ///If onyx is live.
  bool isOnyxLive;

  ///if the full frame image should be returned.
  bool isFullFrameImageReturned;

  /// The scale factor of the full frame image.
  double? fullFrameScaleFactor;

  ///The Pgm Format Byte Array flag
  bool isPGMFormatByteArrayReturned;

  ///If NFIQ metrics are needed.
  bool isNFIQMetrics;

  ///The number to rotate the image by.
  int imageRotation;

  /// Flag determines if the results should be converted to an ISO template.
  bool isConvertToISOTemplate;

  ///The reticle angle.
  ///This property overrides the value set by the [reticleOrientation] property.
  double? reticleAngle;

  ///The reticle orientation.
  ///This property is overridden by the [reticleAngle] property when it's set.
  ReticleOrientations reticleOrientation;

  ///Flag determines if the 4 finger reticle should be used.
  bool isFourFingerReticleUsed;

  ///Flag determines if a quality check match should be performed.
  bool isPerformQualityCheckMatch;

  ///Determines if the metrics should be uploaded.
  bool isUploadMetrics;

  /// flag determines if only high quality images should be returned.
  bool isOnlyHighQualityImageReturned;

  ///flag determines if an error should be raised for low nfiq5 scores.
  bool isErrorOnNFIQ5Score;

  ///if the shutter sound should be enabled.
  bool isShutterSoundEnabled;

  ///if the 2nd device camera should be used for preview streaming.
  bool isCamera2PreviewStreamingUsed;

  ///the unique id of the user. (null if not avaliable)
  String? uniqueUserId;

  ///the lense focus distance for the 2nd camera.
  double? lensFocusDistanceCamera2;

  ///the thumb scale factor.
  double? thumbScaleFactor;

  ///returns the options as a serialized list.
  dynamic toParams() {
    return <String, dynamic>{
      "licenseKey": licenseKey,
      "isReturnRawImage": isRawImageReturned.toString(),
      "isProcessedImageReturned": isProcessedImageReturned.toString(),
      "isEnhancedImageReturned": isEnhancedImageReturned.toString(),
      "isWSQImageReturned": isWSQImageReturned.toString(),
      "isFingerprintTemplateImageReturned":
          isFingerprintTemplateImageReturned.toString(),
      "isLoadingSpinnerShown": isLoadingSpinnerShown.toString(),
      "isImageThreshold": isImageThreshold.toString(),
      "cropSizeWidth": cropSizeWidth.toString(),
      "cropSizeHeight": cropSizeHeight.toString(),
      "cropFactor": cropFactor.toString(),
      // java doesn't do nullable doubles, and thus -1 indicates that there is no PPI.
      "targetPPI": (targetPPI ?? -1.0).toString(),
      "isThumbCapture": isThumbCapture.toString(),
      "isManualCapture": isManualCapture.toString(),
      "isOnyxLive": isOnyxLive.toString(),
      "isNFIQMetrics": isNFIQMetrics.toString(),
      "imageRotation": imageRotation.toString(),
      "reticleAngle": (reticleAngle ?? "").toString(),
      "reticleOrientation": reticleOrientation.toValueString(),
      "isFullFrameImageReturned": isFullFrameImageReturned.toString(),
      "FullFrameScaleFactor": (fullFrameScaleFactor ?? "").toString(),
      "isPGMFormatByteArrayReturned": isPGMFormatByteArrayReturned.toString(),
      "isConvertToISOTemplate": isConvertToISOTemplate.toString(),
      "layoutPreference": layoutPreference.toValueString(),
      "isFourFingerReticleUsed": isFourFingerReticleUsed.toString(),
      "isPerformQualityCheckMatch": isPerformQualityCheckMatch.toString(),
      "isUploadMetrics": isUploadMetrics.toString(),
      "isOnlyHighQualityImageReturned":
          isOnlyHighQualityImageReturned.toString(),
      "isErrorOnNFIQ5Score": isErrorOnNFIQ5Score.toString(),
      "isShutterSoundEnabled": isShutterSoundEnabled.toString(),
      "isCamera2PreviewStreamingUsed": isCamera2PreviewStreamingUsed.toString(),
      "uniqueUserId": (uniqueUserId ?? ""),
      "lensFocusDistanceCamera2": (lensFocusDistanceCamera2 ?? "").toString(),
      "thumbScaleFactor": (thumbScaleFactor ?? "").toString()
    };
  }
}
