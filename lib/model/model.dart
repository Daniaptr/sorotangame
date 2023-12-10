class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String short_description;
  final String game_url;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String tanggal_rilis;
  final String freetogame_profile_url;

  const Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.short_description,
    required this.game_url,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.tanggal_rilis,
    required this.freetogame_profile_url,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'thumbnail': String thumbnail,
        'short_description': String short_description,
        'game_url': String game_url,
        'genre': String genre,
        'platform': String platform,
        'publisher': String publisher,
        'developer': String developer,
        'tanggal_rilis': String tanggal_rilis,
        'freetogame_profile_url': String freetogame_profile_url,
      } =>
        Game(
          id: id,
          title: title,
          thumbnail: thumbnail,
          short_description: short_description,
          game_url: game_url,
          genre: genre,
          platform: platform,
          publisher: publisher,
          developer: developer,
          tanggal_rilis: tanggal_rilis,
          freetogame_profile_url: freetogame_profile_url,
        ),
      _ => throw const FormatException('Failed to load Game.'),
    };
  }
}
