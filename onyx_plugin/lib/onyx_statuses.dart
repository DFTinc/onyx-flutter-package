part of onyx;

///The onyx States.
enum OnyxStatuses {
  /// The initial onyx state (onyx has NOT been configured yet)
  initialized,

  /// onyx has been configured
  configured,

  /// onyx has returned an error.  See the error message.
  error,

  /// onyx has returned successfully.  (See the payload)
  success
}

extension OnyxStatusExtensions on OnyxStatuses {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
