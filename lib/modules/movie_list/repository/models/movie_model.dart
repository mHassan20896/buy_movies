part of 'models.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.price,
    required this.movieName,
    required this.imageUrl,
  });

  final String movieName;
  final String imageUrl;
  final int price;

  MovieModel copyWith({
    String? movieName,
    int? price,
    String? imageUrl,
  }) =>
      MovieModel(
        price: price ?? this.price,
        movieName: movieName ?? this.movieName,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  @override
  List<Object> get props => [
        movieName,
        price,
        imageUrl,
      ];
}
