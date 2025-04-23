extension AssetExtensions on String {
  // PNG File Extension with directory path
  String get png => "assets/images/$this.png";
  String get svg => "assets/images/$this.svg";

  // JPEG File Extension with directory path
  String get jpeg => "assets/images/$this.jpeg";
}
