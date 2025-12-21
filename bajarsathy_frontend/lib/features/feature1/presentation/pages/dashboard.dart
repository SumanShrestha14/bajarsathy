import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_bloc.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_event.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_state.dart';
import 'package:bajarsathy_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricePage extends StatelessWidget {
  const PricePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prices')),
      body: BlocProvider(
        create: (_) => sl<PriceBloc>()..add(FetchDataEvent()),
        child: BlocBuilder<PriceBloc, PriceState>(
          builder: (context, state) {
            if (state is PriceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PriceLoaded) {
              final prices = state.prices;

              if (prices.isEmpty) {
                return const Center(child: Text('No prices found'));
              }

              return ListView.builder(
                itemCount: prices.length,
                itemBuilder: (context, index) {
                  final price = prices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(
                        price.product_name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Rs. ${price.avg_price} per ${price.unit}'),
                    ),
                  );
                },
              );
            }
            if (state is PriceError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
