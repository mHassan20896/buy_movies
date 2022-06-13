import 'package:buy_movies/modules/movie_list/bloc/movie_bloc.dart';
import 'package:buy_movies/modules/movie_list/repository/models/models.dart';
import 'package:buy_movies/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(movieList[index].movieName),
                    subtitle:
                        Text('PRICE: \$${movieList[index].price.toString()}'),
                    trailing: GestureDetector(
                      onTap: () => context.read<MovieBloc>().add(
                          RemoveMovieFromCartEvent(
                              movieList[index], Constants.apiKey)),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  itemCount: state.cartItems.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Total: \$${movieList.reduce((value, element) => MovieModel(price: value.price + element.price, movieName: 'movieName', imageUrl: 'imageUrl')).price}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          ToastContext().init(context);
                          Toast.show("Payment Successfull",
                              duration: Toast.lengthShort,
                              gravity: Toast.center);
                        },
                        child: const Text('Payment'))
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
