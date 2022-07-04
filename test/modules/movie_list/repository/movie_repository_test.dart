import 'package:buy_movies/core/exception/custom_exception.dart';
import 'package:buy_movies/core/network/http.dart';
import 'package:buy_movies/modules/movie_list/repository/repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  late HttpService httpService;

  setUpAll(() {
    httpService = MockHttpService();
  });

  group('MovieRepository', () {
    late MovieRepository movieRepository = MovieRepositoryV1(httpService);

    test('Intialization', () {
      expect(movieRepository, isA<MovieRepositoryV1>());
    });

    group('fetchMovies', () {
      test('Success', () {
        final json = {
          'page': 1,
          'results': [
            {
              'adult': false,
              'backdrop_path': '/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg',
              'genre_ids': [14, 28, 12],
              'id': 453395,
              'original_language': 'en',
              'original_title': 'Doctor Strange in the Multiverse of Madness',
              'overview':
                  'Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.',
              'popularity': 11059.21,
              'poster_path': '/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg',
              'release_date': '2022-05-04',
              'title': 'Doctor Strange in the Multiverse of Madness',
              'video': false,
              'vote_average': 7.5,
              'vote_count': 3912
            },
          ],
          'total_pages': 123,
          'total_results': 46578,
        };

        when(() => httpService.get(
                path: any(named: 'path'),
                queryParams: any(named: 'queryParams')))
            .thenAnswer((invocation) async => Left(json));

        expectLater(
          movieRepository.fetchMovies('apiKey'),
          completion(
            const [
              MovieModel(
                price: 3912,
                movieName: 'Doctor Strange in the Multiverse of Madness',
                imageUrl: '/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg',
              )
            ],
          ),
        );
      });
    });
  });
}
