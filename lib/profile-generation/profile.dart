class Profiless {
  // ignore: non_constant_identifier_names
  String full_name,
      bio,
      city,
      country,
      // ignore: non_constant_identifier_names
      service_provider,
      // ignore: non_constant_identifier_names
      photo_url,
      username,
      ip;
  int followers, following;
  double lat, lang;

  Profiless(
      {this.bio,
      this.city,
      this.country,
      this.followers,
      this.following,
      // ignore: non_constant_identifier_names
      this.full_name,
      this.ip,
      this.lang,
      this.lat,
      // ignore: non_constant_identifier_names
      this.photo_url,
      // ignore: non_constant_identifier_names
      this.service_provider,
      this.username});
}
