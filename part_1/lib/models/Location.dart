class Location {
  String name;
  String theme;
  String description;
  String imageUrl;
  String locationUrl;
  int id;
  Location(
      {int id,
      String name,
      String description,
      String theme,
      String imageUrl,
      String locationUrl}) {
    this.description = description;
    this.id = id;
    this.imageUrl = imageUrl;
    this.locationUrl = locationUrl;
    this.name = name;
    this.theme = theme;
  }
}
