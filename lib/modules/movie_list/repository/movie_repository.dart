part of 'repository.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> fetchMovies(String apiKey);
}

class MovieRepositoryV1 extends MovieRepository {
  MovieRepositoryV1(this.httpService);

  final HttpService httpService;

  @override
  Future<List<MovieModel>> fetchMovies(String apiKey) async {
    final json = await httpService.get(
      path: '3/movie/popular',
      queryParams: {"api_key": apiKey},
    );

    final movieEntity = MovieEntityList.fromJson(json.left);

    final List<MovieModel> movieModelList =
        movieEntity.results.map((movie) => _toMovieModel(movie)).toList();

    return movieModelList;
  }

  MovieModel _toMovieModel(Movie movie) => MovieModel(
        price: movie.voteCount,
        movieName: movie.title,
        imageUrl: movie.posterPath,
      );
}
