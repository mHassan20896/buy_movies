part of 'movie_bloc.dart';

class MovieState extends Equatable {
  const MovieState({
    this.movieApiState = const ApiState(),
    this.cartItems = const [],
  });

  final ApiState<List<MovieModel>> movieApiState;
  final List<MovieModel> cartItems;

  MovieState copyWith({
    ApiState<List<MovieModel>>? movieApiState,
    List<MovieModel>? cartItems,
  }) =>
      MovieState(
        movieApiState: movieApiState ?? this.movieApiState,
        cartItems: cartItems ?? this.cartItems,
      );

  @override
  List<Object> get props => [movieApiState, cartItems];
}
