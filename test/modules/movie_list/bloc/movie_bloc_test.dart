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
    group('Fetch Movie', () {
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

    group('Add/Remove Movie to Cart', () {
      const drStrangers = MovieModel(
        price: 12,
        movieName: 'Dr Strangers',
        imageUrl: 'www.disneyplus.com',
      );

      const msMarvel = MovieModel(
        price: 120,
        movieName: 'Ms. Marvel',
        imageUrl: 'www.disneyplus.com',
      );

      const lostInSpace = MovieModel(
        price: 130,
        movieName: 'Lost in Space',
        imageUrl: 'www.netflix.com',
      );

      const startup = MovieModel(
        price: 240,
        movieName: 'Startup',
        imageUrl: 'www.netflix.com',
      );

      const the100 = MovieModel(
        price: 340,
        movieName: 'The 100',
        imageUrl: 'www.netflix.com',
      );

      const seedState = MovieState(
        movieApiState: ApiState(
          apiResponseState: ApiResponseState.success,
          response: [
            drStrangers,
            msMarvel,
            lostInSpace,
            startup,
            the100,
          ],
        ),
      );

      blocTest<MovieBloc, MovieState>(
        'emits [MovieState.movieApiState.success] when AddMovieToCartEvent is added.',
        seed: () => seedState,
        build: () => MovieBloc(movieRepository),
        act: (bloc) => bloc
          ..add(
            const AddMovieToCartEvent(drStrangers, 'apiKey'),
          )
          ..add(
            const AddMovieToCartEvent(drStrangers, 'apiKey'),
          )
          ..add(
            const AddMovieToCartEvent(msMarvel, 'apiKey'),
          ),
        expect: () => <MovieState>[
          seedState.copyWith(cartItems: [drStrangers]),
          seedState.copyWith(cartItems: [drStrangers, drStrangers]),
          seedState.copyWith(cartItems: [msMarvel, drStrangers, drStrangers]),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'emits [MovieState.movieApiState.success] when RemoveMovieFromCartEvent is added.',
        seed: () =>
            seedState.copyWith(cartItems: [msMarvel, drStrangers, drStrangers]),
        build: () => MovieBloc(movieRepository),
        act: (bloc) => bloc
          ..add(
            const RemoveMovieFromCartEvent(drStrangers, 'apiKey'),
          )
          ..add(
            const RemoveMovieFromCartEvent(msMarvel, 'apiKey'),
          ),
        expect: () => <MovieState>[
          seedState.copyWith(cartItems: [msMarvel, drStrangers]),
          seedState.copyWith(cartItems: [drStrangers]),
        ],
      );
    });
  });
}
