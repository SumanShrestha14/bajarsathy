import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/usecases/get_single_price.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/single_price_bloc.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/single_price_event.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/single_price_state.dart';
import 'package:bajarsathy_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VegetableDetailsPage extends StatefulWidget {
  final Prices price;

  const VegetableDetailsPage({super.key, required this.price});
  @override
  State<VegetableDetailsPage> createState() => _VegetableDetailsPageState();
}

class _VegetableDetailsPageState extends State<VegetableDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vegetable Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            SinglePriceBloc(sl<GetSinglePrice>())
              ..add(FetchSingleDataEvent(widget.price.product_name)),
        child: BlocBuilder<SinglePriceBloc, SinglePriceState>(
          builder: (context, state) {
            if (state is SinglePriceLoading) {
              return Container(
                height: 300,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              );
            }

            if (state is SinglePriceLoaded) {
              final singlePrice = state.prices;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Header with vegetable name
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:
                                  singlePrice.product_image != null &&
                                      singlePrice.product_image!.isNotEmpty
                                  ? Image.network(
                                      singlePrice.product_image!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Center(
                                              child: Text(
                                                singlePrice.product_name[0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[800],
                                                ),
                                              ),
                                            );
                                          },
                                    )
                                  : Center(
                                      child: Text(
                                        singlePrice.product_name[0]
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[800],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  singlePrice.product_name,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${singlePrice.avg_price} per ${singlePrice.unit}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green[100],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Price Information Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '📊 Price Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              _buildInfoRow(
                                'Average Price',
                                singlePrice.avg_price,
                              ),
                              const Divider(height: 20),
                              _buildInfoRow(
                                'Minimum Price',
                                singlePrice.min_price,
                              ),
                              const Divider(height: 20),
                              _buildInfoRow(
                                'Maximum Price',
                                singlePrice.max_price,
                              ),
                              const Divider(height: 20),
                              _buildInfoRow('Unit', singlePrice.unit),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Price Trend Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '📈 Price Trend',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Simple trend visualization
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        size: 50,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '+5% from yesterday',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTrendItem(
                                    'Minimum',
                                    singlePrice.min_price,
                                  ),
                                  _buildTrendItem(
                                    'Average',
                                    singlePrice.avg_price,
                                  ),
                                  _buildTrendItem(
                                    'Maximum',
                                    singlePrice.max_price,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Market Prices Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '🏪 Market Prices',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              _buildMarketPriceRow(
                                'Kalimati Market',
                                singlePrice.avg_price,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          //   Expanded(
                          //     child: ElevatedButton(
                          //       onPressed: () {
                          //         // Add to favorites
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //             content: Text(
                          //               'Added ${price.product_name} to favorites',
                          //             ),
                          //             backgroundColor: Colors.green,
                          //           ),
                          //         );
                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.green[50],
                          //         foregroundColor: Colors.green[800],
                          //         padding: const EdgeInsets.symmetric(vertical: 16),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(12),
                          //         ),
                          //         elevation: 0,
                          //       ),
                          //       child: const Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Icon(Icons.favorite_border),
                          //           SizedBox(width: 8),
                          //           Text('Add to Favorites'),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Share price info
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Share',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              );
            }

            if (state is SinglePriceError) {
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
                          context.read<SinglePriceBloc>().add(
                            FetchSingleDataEvent(widget.price.product_name),
                          );
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildTrendItem(String period, String price) {
    return Column(
      children: [
        Text(period, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 5),
        Text(
          price,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildMarketPriceRow(String market, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.storefront, color: Colors.green[800], size: 20),
            const SizedBox(width: 10),
            Text(
              market,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
        ),
      ],
    );
  }
}
