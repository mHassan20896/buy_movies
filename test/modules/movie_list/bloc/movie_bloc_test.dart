import 'package:bloc_test/bloc_test.dart';
import 'package:buy_movies/core/exception/custom_exception.dart';
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
      'emits [MovieState.movieApiState.success] when FetchMovieEvent is added.',
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

    blocTest<MovieBloc, MovieState>(
      'emits [MovieState.movieApiState.failure] when FetchMovieEvent is added.',
      setUp: () => when(() => movieRepository.fetchMovies(any()))
          .thenThrow(const CustomException('message')),
      build: () => MovieBloc(movieRepository),
      act: (bloc) => bloc.add(const FetchMovieEvent('test')),
      expect: () => const <MovieState>[
        MovieState(
          movieApiState: ApiState(apiResponseState: ApiResponseState.loading),
        ),
        MovieState(
          movieApiState: ApiState(
            apiResponseState: ApiResponseState.error,
            e: CustomException('message'),
          ),
        ),
      ],
    );
  });
}
