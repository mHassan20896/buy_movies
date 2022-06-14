import 'package:buy_movies/core/network/http.dart';
import 'package:buy_movies/core/widgets/drawer_list_view.dart';
import 'package:buy_movies/modules/movie_list/bloc/movie_bloc.dart';
import 'package:buy_movies/modules/movie_list/repository/repository.dart';
import 'package:buy_movies/modules/movie_list/view/payment_page.dart';
import 'package:buy_movies/utils/constants.dart';
import 'package:buy_movies/utils/navigator_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieBloc(MovieRepositoryV1(HttpService(client: Client()))),
      child: const _MovieListView(),
    );
  }
}

class _MovieListView extends StatefulWidget {
  const _MovieListView({Key? key}) : super(key: key);

  @override
  State<_MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<_MovieListView> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const FetchMovieEvent(Constants.apiKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: DrawerListView()),
      appBar: AppBar(
        title: const Text("Buy Movies"),
        actions: [_cartItemCountWidget()],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          final movieList = state.movieApiState.response;
          return GridView.builder(
            itemCount: state.movieApiState.response?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1.1,
                        child: Image.network(
                          'https://www.themoviedb.org/t/p/w1280${movieList![index].imageUrl}',
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieList[index].movieName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Price: ${movieList[index].price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => context.read<MovieBloc>().add(
                                    AddMovieToCartEvent(
                                        movieList[index], Constants.apiKey)),
                                child: const Icon(Icons.add),
                              ),
                              GestureDetector(
                                onTap: () => context.read<MovieBloc>().add(
                                    RemoveMovieFromCartEvent(
                                        movieList[index], Constants.apiKey)),
                                child: const Icon(Icons.remove),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _cartItemCountWidget() => BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => NavigatorX.pushPage(
              context,
              page: BlocProvider.value(
                value: context.read<MovieBloc>(),
                child: const PaymentPage(),
              ),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.shopping_cart),
                ),
                Text(
                  state.cartItems.length.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(width: 8.0)
              ],
            ),
          );
        },
      );
}
