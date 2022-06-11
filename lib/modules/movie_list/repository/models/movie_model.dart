part of 'models.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.castMembers,
    required this.movieName,
    required this.imageUrl,
  });

  final String movieName;
  final String imageUrl;
  final List<String> castMembers;

  MovieModel copyWith({
    String? movieName,
    List<String>? castMembers,
    String? imageUrl,
  }) =>
      MovieModel(
        castMembers: castMembers ?? this.castMembers,
        movieName: movieName ?? this.movieName,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  @override
  List<Object> get props => [
        movieName,
        castMembers,
        imageUrl,
      ];
}
