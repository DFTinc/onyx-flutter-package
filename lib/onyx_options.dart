part of 'onyx.dart';

///the settings for the onyx plugin
class OnyxOptions {
  ///The onyx license key
  String? licenseKey = "";

  ///If the gray image should be returned.
  ///This configuration option is only supported by iOS.
  bool isGrayImageReturned = false;

  ///If the black and white processed image should be returned.
  ///This configuration option is only supported by iOS.
  bool isBlackWhiteProcessedImageReturned = false;

  ///If the gray raw WSQ should be returned.
  ///This configuration option is only supported by iOS.
  bool isGrayRawWSQReturned = false;

  ///The text of the back button.
  ///This configuration option is only supported by iOS.
  String backButtonText = "";

  ///sets the image data to be displayed on the capture screen to this base 64 string.
  ///This configuration option is only supported by iOS.
  String base64ImageData = "";

  ///the onyx layout preferences.
  ///This configuration option is only supported by Android.
  LayoutPreference layoutPreference = LayoutPreference.FULL;

  ///If the raw image is to be returned.
  bool isRawImageReturned = true;

  ///If the processed image is to be returned.
  bool isProcessedImageReturned = true;

  ///If the enhanced image is to be returned.
  bool isEnhancedImageReturned = true;

  ///If the WSQ image should be returned.
  bool isWSQImageReturned = true;

  ///If the fingerprint template image should be returned.
  bool isFingerprintTemplateImageReturned = true;

  ///If the loading spinner should be shown.
  bool isLoadingSpinnerShown = false;

  ///If the image threshold should be set.
  ///This configuration option is only supported by Android.
  bool isImageThreshold = false;

  ///The width to crop the image by.
  double cropSizeWidth = 300;

  ///The height to crop the image by.
  double cropSizeHeight = 512;

  ///The crop factor for the image.
  double cropFactor = 1.0;

  ///The targeted pixels per inch.
  ///Suggested values are around 500.0.
  ///This configuration option is only supported by Android.
  double? targetPPI;

  ///If the thumb is captured
  bool isThumbCapture = false;

  ///If it's a manual capture.
  bool isManualCapture = false;

  ///If onyx is live.
  bool isOnyxLive = false;

  ///if the full frame image should be returned.
  ///This configuration option is only supported by Android.
  bool isFullFrameImageReturned = false;

  /// The scale factor of the full frame image.
  ///This configuration option is only supported by Android.
  double? fullFrameScaleFactor;

  ///The Pgm Format Byte Array flag
  ///This configuration option is only supported by Android.
  bool isPGMFormatByteArrayReturned = false;

  ///If NFIQ metrics are needed.
  ///This configuration option is only supported by Android.
  bool isNFIQMetrics = false;

  ///The number to rotate the image by.
  int imageRotation = 0;

  /// Flag determines if the results should be converted to an ISO template.
  bool isConvertToISOTemplate = false;

  ///The reticle angle.
  ///This property overrides the value set by the [reticleOrientation] property.
  double? reticleAngle;

  ///The reticle orientation.
  ///This property is overridden by the [reticleAngle] property when it's set.
  ReticleOrientations reticleOrientation = ReticleOrientations.LEFT;

  ///Flag determines if the 4 finger reticle should be used.
  ///This configuration option is only supported by Android.
  bool isFourFingerReticleUsed = true;

  ///Flag determines if a quality check match should be performed.
  ///This configuration option is only supported by Android.
  bool isPerformQualityCheckMatch = false;

  ///Determines if the metrics should be uploaded.
  ///This configuration option is only supported by Android.
  bool isUploadMetrics = false;

  /// flag determines if only high quality images should be returned.
  ///This configuration option is only supported by Android.
  bool isOnlyHighQualityImageReturned = false;

  ///flag determines if an error should be raised for low nfiq5 scores.
  ///This configuration option is only supported by Android.
  bool isErrorOnNFIQ5Score = false;

  ///flag determines if the flash should be on by default.
  bool isUseFlash = true;

  ///if the shutter sound should be enabled.
  ///This configuration option is only supported by Android.
  bool isShutterSoundEnabled = false;

  ///if the 2nd device camera should be used for preview streaming.
  ///This configuration option is only supported by Android.
  bool isCamera2PreviewStreamingUsed = false;

  ///the unique id of the user. (null if not available)
  ///This configuration option is only supported by Android.
  String? uniqueUserId;

  ///the lense focus distance for the 2nd camera.
  ///This configuration option is only supported by Android.
  double? lensFocusDistanceCamera2;

  ///the thumb scale factor.
  ///This configuration option is only supported by Android.
  double? thumbScaleFactor;

  ///returns the options as a serialized list.
  dynamic toParams() {
    return <String, dynamic>{
      "licenseKey": licenseKey,
      "isGrayImageReturned": isGrayImageReturned,
      "isBlackWhiteProcessedImageReturned": isBlackWhiteProcessedImageReturned,
      "isGrayRawWSQReturned": isGrayRawWSQReturned,
      "backButtonText": backButtonText,
      "base64ImageData": base64ImageData,
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
      "thumbScaleFactor": (thumbScaleFactor ?? "").toString(),
      "isUseFlash": isUseFlash.toString()
    };
  }
}
