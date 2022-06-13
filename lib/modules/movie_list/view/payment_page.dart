import 'package:buy_movies/modules/movie_list/bloc/movie_bloc.dart';
import 'package:buy_movies/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          final movieList = context.read<MovieBloc>().state.cartItems;
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(movieList[index].movieName),
              subtitle: Text('PRICE: \$${movieList[index].price.toString()}'),
              trailing: GestureDetector(
                onTap: () => context.read<MovieBloc>().add(
                    RemoveMovieFromCartEvent(
                        movieList[index], Constants.apiKey)),
                child: const Icon(Icons.remove),
              ),
            ),
            itemCount: state.cartItems.length,
          );
        },
      ),
    );
  }
}
