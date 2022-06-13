import 'package:buy_movies/modules/movie_list/bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(state.cartItems[index].movieName),
            ),
            itemCount: state.cartItems.length,
          );
        },
      ),
    );
  }
}
