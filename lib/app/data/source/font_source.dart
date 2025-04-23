enum FontSource {
  poppins,
}

extension FontSourceExtension on FontSource {
  String get value {
    switch (this) {
      case FontSource.poppins:
        return "poppins";
    }
  }
}
