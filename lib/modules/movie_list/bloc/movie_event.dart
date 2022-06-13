part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent(this.apiKey);
  final String apiKey;

  @override
  List<Object> get props => [apiKey];
}

class FetchMovieEvent extends MovieEvent {
  const FetchMovieEvent(super.apiKey);
}

class AddMovieToCartEvent extends MovieEvent {
  const AddMovieToCartEvent(this.movie, super.apiKey);

  final MovieModel movie;

  @override
  List<Object> get props => [movie, apiKey];
}

class RemoveMovieFromCartEvent extends MovieEvent {
  const RemoveMovieFromCartEvent(this.movie, super.apiKey);

  final MovieModel movie;

  @override
  List<Object> get props => [movie, apiKey];
}
