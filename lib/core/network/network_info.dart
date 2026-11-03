/// Abstraction for connectivity checks.
/// Domain/data layers depend on this interface, not on a concrete plugin.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Prototype: assume online. Replace with connectivity_plus when needed.
    return true;
  }
}
