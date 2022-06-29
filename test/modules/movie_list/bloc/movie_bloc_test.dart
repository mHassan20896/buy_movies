import 'package:bloc_test/bloc_test.dart';
import 'package:buy_movies/core/network/api_state.dart';
import 'package:buy_movies/modules/movie_list/bloc/movie_bloc.dart';
import 'package:buy_movies/modules/movie_list/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository movieRepository;

  setUpAll(() {
    movieRepository = MockMovieRepository();
  });

  group('MovieBloc', () {
    blocTest<MovieBloc, MovieState>(
      'emits [MovieState.movieApiState] when FetchMovieEvent is added.',
      setUp: () => when(() => movieRepository.fetchMovies(any()))
          .thenAnswer((invocation) async => []),
      build: () => MovieBloc(movieRepository),
      act: (bloc) => bloc.add(const FetchMovieEvent('test')),
      expect: () => const <MovieState>[
        MovieState(
          movieApiState: ApiState(apiResponseState: ApiResponseState.loading),
        ),
        MovieState(
          movieApiState: ApiState(
            apiResponseState: ApiResponseState.success,
            response: [],
          ),
          cartItems: [],
        ),
      ],
    );
  });
}
