extension NullableObject on Object? {
  bool get isNotNullOrEmpty {
    if (this != null) {
      if (this is String) {
        return (this as String).isNotEmpty;
      } else if (this is List) {
        return (this as List).isNotEmpty;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
