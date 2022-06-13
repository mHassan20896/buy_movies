import 'package:buy_movies/core/network/api_state.dart';
import 'package:buy_movies/modules/movie_list/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this.movieRepository) : super(const MovieState()) {
    on<FetchMovieEvent>(_fetchMovie);
    on<AddMovieToCartEvent>(_addMovieToCart);
    on<RemoveMovieFromCartEvent>(_removeMovieFromCart);
  }

  final MovieRepository movieRepository;

  Future<void> _fetchMovie(
      FetchMovieEvent event, Emitter<MovieState> emit) async {
    emit(
      state..movieApiState.copyWith(apiResponseState: ApiResponseState.loading),
    );
    final apiState =
        await apiCall(() => movieRepository.fetchMovies(event.apiKey));
    emit(state.copyWith(movieApiState: apiState));
  }

  void _addMovieToCart(AddMovieToCartEvent event, Emitter<MovieState> emit) {
    final cartItmes = [event.movie, ...state.cartItems];

    emit(state.copyWith(cartItems: cartItmes));
  }

  void _removeMovieFromCart(
      RemoveMovieFromCartEvent event, Emitter<MovieState> emit) {
    final cartItmes = [...state.cartItems];
    final index = cartItmes.indexWhere((element) => element == event.movie);
    cartItmes.removeAt(index);

    emit(state.copyWith(cartItems: cartItmes));
  }
}
