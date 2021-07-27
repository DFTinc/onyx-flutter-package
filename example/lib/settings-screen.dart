import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onyx_plugin/onyx.dart';

/// Main scanner app widget
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    OnyxCamera.state.addListener(() async {
      setState(() {});
      if (isAutoStart && OnyxCamera.state.status == OnyxStatuses.configured) {
        await OnyxCamera.startOnyx();
      }
    });
  }

  //if onyx should start when configured.
  bool isAutoStart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Onyx camera Setup.'),
        ),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    onyxOptionInputs(),
                    onyxIOSOnlyOptions(),
                    onyxAndroidOnlyOptions()
                  ],
                )),
          )),
          buttonRow(),
        ]));
  }

  Widget buttonRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white, backgroundColor: Colors.blue),
        onPressed: () async {
          await OnyxCamera.configureOnyx();
        },
        child: Text('Set Onyx Configuration'),
      )),
      if (OnyxCamera.state.status != OnyxStatuses.initialized)
        Expanded(
            child: TextButton(
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.green),
          onPressed: () async {
            await OnyxCamera.startOnyx();
          },
          child: Text('Start Onyx'),
        ))
    ]);
  }

  ///the android only onyx configuration options.
  Widget onyxIOSOnlyOptions() {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(children: [
              const ListTile(
                title: Text('iOS Configuration Settings'),
                subtitle: Text('The following settings work only for iOS.'),
              ),
              Wrap(alignment: WrapAlignment.center, children: [
                CommonWidgets.settingsSwitch(
                    title: 'Return gray image',
                    subTitle: "If the gray image should be returned.",
                    initialValue: OnyxCamera.options.isGrayImageReturned,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isGrayImageReturned = value;
                      });
                    }),
                CommonWidgets.settingsSwitch(
                    title: 'Return black and white processed image',
                    subTitle:
                        "If the black and white processed image should be returned.",
                    initialValue:
                        OnyxCamera.options.isBlackWhiteProcessedImageReturned,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isBlackWhiteProcessedImageReturned =
                            value;
                      });
                    }),
                CommonWidgets.settingsSwitch(
                    title: 'Return gray raw wsq',
                    subTitle: "If the gray raw wsq should be returned.",
                    initialValue: OnyxCamera.options.isGrayRawWSQReturned,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isGrayRawWSQReturned = value;
                      });
                    }),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: "Back Button Text",
                        hintText: "Back Button Text"),
                    initialValue: OnyxCamera.options.backButtonText,
                    onChanged: (value) {
                      OnyxCamera.options.backButtonText = value;
                    }),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: "Base 64 image data",
                        hintText: "Base 64 image Button Text"),
                    initialValue: OnyxCamera.options.base64ImageData,
                    onChanged: (value) {
                      OnyxCamera.options.base64ImageData = value;
                    })
              ])
            ])));
  }

  ///the android only onyx configuration options.
  Widget onyxAndroidOnlyOptions() {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(children: [
              const ListTile(
                title: Text('Android Configuration Settings'),
                subtitle: Text('The following settings work only for android.'),
              ),
              Wrap(alignment: WrapAlignment.center, children: [
                CommonWidgets.settingsSwitch(
                    initialValue: OnyxCamera.options.isFullFrameImageReturned,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isFullFrameImageReturned = value;
                      });
                    },
                    title: 'Full Frame Images',
                    subTitle: "Returns the full frame images."),
                CommonWidgets.settingsSwitch(
                    initialValue:
                        OnyxCamera.options.isPGMFormatByteArrayReturned,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isPGMFormatByteArrayReturned = value;
                      });
                    },
                    title: 'PGM Format ByteArray Returned',
                    subTitle:
                        "Retrieves the fingerprints in a PGM formatted byte array."),
                CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isImageThreshold,
                  title: 'Threshold Image',
                  subTitle: 'Sets the image threshold',
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isImageThreshold = value;
                    });
                  },
                ),
                CommonWidgets.settingsSwitch(
                  title: "Use NFIQ Metrics",
                  subTitle: 'If the NFIQ metrics should be calculated.',
                  initialValue: OnyxCamera.options.isNFIQMetrics,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isNFIQMetrics = value;
                    });
                  },
                ),
                CommonWidgets.settingsSwitch(
                    initialValue: OnyxCamera.options.isFourFingerReticleUsed,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isFourFingerReticleUsed = value;
                      });
                    },
                    subTitle: 'If a four finger reticle should be used',
                    title: 'Four Finger Reticle Used'),
                CommonWidgets.settingsSwitch(
                    initialValue: OnyxCamera.options.isPerformQualityCheckMatch,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isPerformQualityCheckMatch = value;
                      });
                    },
                    title: 'Perform Quality Check Match',
                    subTitle:
                        'Onyx  performs a quality check when the prints are taken.'),
                CommonWidgets.settingsSwitch(
                    initialValue: OnyxCamera.options.isUploadMetrics,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isUploadMetrics = value;
                      });
                    },
                    subTitle:
                        'Onyx uploads the metrics related to the prints that are taken.',
                    title: 'Upload Metrics'),
                CommonWidgets.settingsSwitch(
                    initialValue:
                        OnyxCamera.options.isOnlyHighQualityImageReturned,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isOnlyHighQualityImageReturned =
                            value;
                      });
                    },
                    title: 'Only Return High Quality Images',
                    subTitle:
                        'Oynx only returns high quality images of the prints.'),
                CommonWidgets.settingsSwitch(
                    initialValue: OnyxCamera.options.isErrorOnNFIQ5Score,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isErrorOnNFIQ5Score = value;
                      });
                    },
                    subTitle:
                        'Onyx returns an error if the fingerprints have a NFIQ score of 5.',
                    title: 'Error on an NFIQ Score of 5'),
                CommonWidgets.settingsSwitch(
                    initialValue: OnyxCamera.options.isShutterSoundEnabled,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isShutterSoundEnabled = value;
                      });
                    },
                    title: 'Shutter Sound Enabled',
                    subTitle:
                        'Onyx makes a shutter sound when capturing fingerprints.'),
                CommonWidgets.settingsSwitch(
                    initialValue:
                        OnyxCamera.options.isCamera2PreviewStreamingUsed,
                    onChanged: (value) {
                      setState(() {
                        OnyxCamera.options.isCamera2PreviewStreamingUsed =
                            value;
                      });
                    },
                    title: 'Enable Camera 2 Preview Streaming',
                    subTitle: 'If camera 2 preview should be streamed.'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Layout Preference'),
                    new DropdownButton<LayoutPreference>(
                      items:
                          LayoutPreference.values.map((LayoutPreference value) {
                        return new DropdownMenuItem<LayoutPreference>(
                          value: value,
                          child: new Text(value.toValueString()),
                        );
                      }).toList(),
                      value: OnyxCamera.options.layoutPreference,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            OnyxCamera.options.layoutPreference = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "Target PPI", hintText: "Target PPI"),
                    initialValue:
                        (OnyxCamera.options.targetPPI ?? "").toString(),
                    onChanged: (value) {
                      OnyxCamera.options.targetPPI = double.tryParse(value);
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "Full Frame Scale Factor",
                        hintText: "Full Frame Scale Factor"),
                    initialValue:
                        (OnyxCamera.options.fullFrameScaleFactor ?? "")
                            .toString(),
                    onChanged: (value) {
                      if (double.tryParse(value) != null) {
                        OnyxCamera.options.fullFrameScaleFactor =
                            double.parse(value);
                      } else {
                        OnyxCamera.options.fullFrameScaleFactor = null;
                      }
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "Unique User Id",
                        hintText: "Unique User Id"),
                    initialValue:
                        (OnyxCamera.options.uniqueUserId ?? "").toString(),
                    onChanged: (value) {
                      OnyxCamera.options.uniqueUserId = value;
                    }),
                TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "Camera 2 Lens Focus Distance",
                        hintText: "Camera 2 Lens Focus Distance"),
                    initialValue:
                        (OnyxCamera.options.lensFocusDistanceCamera2 ?? "")
                            .toString(),
                    onChanged: (value) {
                      OnyxCamera.options.lensFocusDistanceCamera2 =
                          double.tryParse(value);
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "Thumb Scale Factor",
                        hintText: "Thumb Scale Factor"),
                    initialValue:
                        (OnyxCamera.options.thumbScaleFactor ?? "").toString(),
                    onChanged: (value) {
                      OnyxCamera.options.thumbScaleFactor =
                          double.tryParse(value);
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
              ])
            ])));
  }

  ///the onyx option inputs.
  Widget onyxOptionInputs() {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            child: Wrap(alignment: WrapAlignment.center, children: [
              TextFormField(
                  onChanged: (value) {
                    OnyxCamera.options.licenseKey = value;
                  },
                  textAlign: TextAlign.center,
                  initialValue: OnyxCamera.options.licenseKey,
                  decoration: InputDecoration(
                      labelText: "Onyx license key",
                      hintText: "Onyx license key")),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isRawImageReturned,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isRawImageReturned = value;
                    });
                  },
                  title: 'Raw Prints',
                  subTitle: "Retrieves unmodified fingerprint images."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isProcessedImageReturned,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isProcessedImageReturned = value;
                    });
                  },
                  title: 'Processed Prints',
                  subTitle: "Retrieves processed fingerprint images."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isEnhancedImageReturned,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isEnhancedImageReturned = value;
                    });
                  },
                  title: 'Enhanced Prints',
                  subTitle: "Retrieves enhanced fingerprint images."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isWSQImageReturned,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isWSQImageReturned = value;
                    });
                  },
                  title: 'WSQ Prints',
                  subTitle: "Displays WSQ fingerprints."),
              CommonWidgets.settingsSwitch(
                  initialValue:
                      OnyxCamera.options.isFingerprintTemplateImageReturned,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isFingerprintTemplateImageReturned =
                          value;
                    });
                  },
                  title: 'Print Templates',
                  subTitle: "Retrieves the fingerprint templates."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isConvertToISOTemplate,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isConvertToISOTemplate = value;
                    });
                  },
                  title: 'Convert to ISO Template',
                  subTitle: 'Retrieves ISO standard fingerprint templates'),
              CommonWidgets.settingsSwitch(
                  initialValue: isAutoStart,
                  onChanged: (value) {
                    setState(() {
                      isAutoStart = value;
                    });
                  },
                  title: 'Start App when configured.',
                  subTitle:
                      "starts the onyx camera as soon as it's been configured."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.isUseFlash,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.isUseFlash = value;
                    });
                  },
                  title: 'Use Flash',
                  subTitle: 'if the camera flash should be used by default.'),
              CommonWidgets.settingsSwitch(
                initialValue: OnyxCamera.options.isLoadingSpinnerShown,
                title: 'Show Loading Spinner',
                subTitle:
                    'If a spinner animation should be shown when onyx is busy.',
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.isLoadingSpinnerShown = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                title: 'Thumb Capture',
                subTitle: 'If the thumb' 's fingerprint should be captured.',
                initialValue: OnyxCamera.options.isThumbCapture,
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.isThumbCapture = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                title: "Manual Capture",
                subTitle:
                    'Sets the Onyx camera to allow manual fingerprint capture.',
                initialValue: OnyxCamera.options.isManualCapture,
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.isManualCapture = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                title: "Use Onyx Live",
                subTitle: 'If Onyx should be running in live mode.',
                initialValue: OnyxCamera.options.isOnyxLive,
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.isOnyxLive = value;
                  });
                },
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Image Crop Height",
                      hintText: "Image Crop Height"),
                  textAlign: TextAlign.right,
                  initialValue: OnyxCamera.options.cropSizeHeight.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.cropSizeHeight = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Image Crop Width",
                      hintText: "Image Crop Width"),
                  textAlign: TextAlign.right,
                  initialValue: OnyxCamera.options.cropSizeWidth.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.cropSizeWidth = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Crop Factor", hintText: "Crop Factor"),
                  textAlign: TextAlign.right,
                  initialValue: OnyxCamera.options.cropFactor.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.cropFactor = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: 'Recitcle Angle', hintText: "Recitcle Angle"),
                  initialValue: (OnyxCamera.options.reticleAngle != null)
                      ? OnyxCamera.options.reticleAngle.toString()
                      : "",
                  onChanged: (value) {
                    OnyxCamera.options.reticleAngle = double.tryParse(value);
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recitcle Orientation'),
                  new DropdownButton<ReticleOrientations>(
                    items: ReticleOrientations.values
                        .map((ReticleOrientations value) {
                      return new DropdownMenuItem<ReticleOrientations>(
                        value: value,
                        child: new Text(value.toValueString()),
                      );
                    }).toList(),
                    value: OnyxCamera.options.reticleOrientation,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          OnyxCamera.options.reticleOrientation = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Image Rotation'),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: new DropdownButton<int>(
                        hint: Text('Image Rotation'),
                        items: [
                          DropdownMenuItem(
                            child: Text("0"),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text("90"),
                            value: 90,
                          ),
                        ],
                        value: OnyxCamera.options.imageRotation,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              OnyxCamera.options.imageRotation = value;
                            });
                          }
                        },
                      )),
                ],
              )
            ])));
  }
}

class CommonWidgets {
  // the base switch used on this screen.
  static Widget settingsSwitch(
      {required bool initialValue,
      required void Function(bool) onChanged,
      required String title,
      String? subTitle}) {
    var subTitleWidget;
    if (subTitle != null) {
      subTitleWidget = Text(subTitle);
    }
    return SizedBox(
        width: 400,
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: initialValue,
                onChanged: (value) {
                  onChanged(value ?? false);
                },
                subtitle: subTitleWidget,
                title: Text(title),
              )),
            )));
  }

  static List<Widget> sectionTitle(String title) {
    return [
      Builder(builder: (context) {
        return Text(title, style: Theme.of(context).textTheme.headline5);
      }),
      Divider(
        color: Colors.grey,
      ),
    ];
  }
}
