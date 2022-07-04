import 'package:buy_movies/modules/movie_list/repository/entity/movies_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MovieEntity tests', () {
    final json = {
      'page': 1,
      'results': [
        {
          'adult': false,
          'backdrop_path': '/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg',
          'genre_ids': [14, 28, 12],
          'id': 453395,
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

    final movieEntity = MovieEntityList.fromJson(json);

    expect(
      movieEntity,
      isA<MovieEntityList>()
          .having(
            (p0) => p0.page,
            'page',
            1,
          )
          .having(
            (p0) => p0.totalPages,
            'totalPages',
            123,
          ),
    );

    expect(movieEntity.toJson(), json);
  });
}
