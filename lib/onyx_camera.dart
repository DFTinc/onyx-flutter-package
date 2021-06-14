part of onyx;

///The method channel used for communicating with the activities.
const MethodChannel _channel =
    const MethodChannel('com.dft.onyx_plugin/methodChannel');

/// the onyx camera utility class.
class OnyxCamera {
  /// The current state of the onyx camera.
  static final OnyxState _state = new OnyxState._();

  ///the fingerprint results.
  static OnyxResults results = new OnyxResults._();

  /// The Onyx State object.
  /// Add a listener for state change events.
  static OnyxState get state => _state;

  ///The onyx configuration options.
  static OnyxOptions options = new OnyxOptions();

  ///Configures onyx with the values in the [OnyxCamera.options] class.
  static Future<void> configureOnyx() async {
    //state listener used to starts onyx if needed.
    await _channel.invokeMethod('configureOnyx', options.toParams());
  }

  /// Starts onyx.
  static Future<void> startOnyx() async {
    await _channel.invokeMethod('startOnyx');
  }
}
