part of onyx;

/// The onyx state object.
class OnyxState extends ChangeNotifier {
  OnyxState._(
      [this._isError = false,
      this._status = OnyxStatuses.initialized,
      this._resultMessage = "Onyx Initialized"]) {
    _channel.setMethodCallHandler((call) async {
      print("messageType:" + call.method);
      switch (call.method) {
        case "onyx_configured":
          _setConfigured();
          break;
        case "onyx_error":
          _setError(call.arguments['errorMessage']);
          break;
        case "onyx_success":
          _setSuccess(call);
          break;
      }
    });
  }

  ///the current state.
  OnyxStatuses _status;

  ///gets the current state.
  OnyxStatuses get status => _status;

  /// if the current state is an error
  bool _isError;

  ///gets if the  current state is an error.
  bool get isError => _isError;

  ///The result message.
  String _resultMessage;

  ///The message related to the current state.
  ///If the _currentState was error, this would be the error message.
  String get resultMessage => _resultMessage;

  ///sets the state to configured.
  void _setConfigured() {
    _status = OnyxStatuses.configured;
    _resultMessage = "";
    this._isError = false;
    notifyListeners();
  }

  ///sets the error state.
  void _setError(String errorMsg) {
    this._status = OnyxStatuses.error;
    this._resultMessage = errorMsg;
    this._isError = true;
    notifyListeners();
  }

  ///sets the success state.
  void _setSuccess(MethodCall call) {
    OnyxCamera.results = new OnyxResults._loadResults(call);
    _status = OnyxStatuses.success;
    this._resultMessage = "";
    this._isError = false;
    notifyListeners();
  }
}
