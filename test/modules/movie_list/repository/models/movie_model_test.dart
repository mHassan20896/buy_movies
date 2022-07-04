import 'package:buy_movies/modules/movie_list/repository/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MovieModel', () {
    const msMarvel = MovieModel(
      price: 123,
      movieName: 'Ms. Marvel',
      imageUrl: 'www.disneyplus.com',
    );
    const msMarvelCopy = MovieModel(
      price: 123,
      movieName: 'Ms. Marvel',
      imageUrl: 'www.disneyplus.com',
    );
    const drStranger = MovieModel(
      price: 324,
      movieName: 'Dr. Stranger',
      imageUrl: 'www.disneyplus.com',
    );

    expect(msMarvel == msMarvelCopy, true, reason: 'Both objects are same');
    expect(msMarvel != drStranger, true, reason: 'Both objects are different');
  });
}
