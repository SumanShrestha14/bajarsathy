import 'dart:math';

import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_bloc.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_event.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_state.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/pages/single_product_details.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/price_list_item.dart';
import 'package:bajarsathy_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VegetablePricesSection extends StatelessWidget {
  const VegetablePricesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Current Prices',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          BlocProvider(
            create: (_) => sl<PriceBloc>()..add(FetchDataEvent()),
            child: BlocBuilder<PriceBloc, PriceState>(
              builder: (context, state) {
                if (state is PriceLoading) {
                  return Container(
                    height: 300,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                  );
                }

                if (state is PriceLoaded) {
                  final prices = state.prices;

                  if (prices.isEmpty) {
                    return Container(
                      height: 200,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_food_beverage,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'No vegetable prices available',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final displayCount = min(5, prices.length);

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: displayCount,
                          itemBuilder: (context, index) {
                            return PriceListItem(
                              price: prices[index],
                              index: index,
                              totalItems: displayCount,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VegetableDetailsPage(
                                      price: prices[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }

                if (state is PriceError) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 50, color: Colors.red),
                          const SizedBox(height: 10),
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              context.read<PriceBloc>().add(FetchDataEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
