import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';
import 'package:flutter/material.dart';

class VegetableDetailsPage extends StatelessWidget {
  final Prices price;

  const VegetableDetailsPage({super.key, required this.price});

  /// Converts Nepali Devanagari numerals to regular numerals and parses to double
  double _parsePrice(String priceString) {
    // Map of Devanagari numerals to regular numerals
    const devanagariToLatin = {
      '०': '0',
      '१': '1',
      '२': '2',
      '३': '3',
      '४': '4',
      '५': '5',
      '६': '6',
      '७': '7',
      '८': '8',
      '९': '9',
    };

    // Convert Devanagari numerals to Latin
    String converted = priceString;
    devanagariToLatin.forEach((devanagari, latin) {
      converted = converted.replaceAll(devanagari, latin);
    });

    // Remove all non-numeric characters except decimal point and minus sign
    String numericString = converted.replaceAll(RegExp(r'[^\d.-]'), '');

    // Remove multiple decimal points, keeping only the first one
    final firstDecimalIndex = numericString.indexOf('.');
    if (firstDecimalIndex != -1) {
      final beforeDecimal = numericString.substring(0, firstDecimalIndex);
      final afterDecimal = numericString
          .substring(firstDecimalIndex + 1)
          .replaceAll('.', ''); // Remove any additional decimal points
      numericString = '$beforeDecimal.$afterDecimal';
    }

    // Parse to double, return 0.0 if parsing fails
    try {
      return double.parse(numericString);
    } catch (e) {
      return 0.0;
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with vegetable name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    child: Center(
                      child: Text(
                        price.product_name[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
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
                          price.product_name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rs. ${price.avg_price} per ${price.unit}',
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
                      _buildInfoRow('Average Price', 'Rs. ${price.avg_price}'),
                      const Divider(height: 20),
                      _buildInfoRow('Unit', price.unit),
                      const Divider(height: 20),
                      _buildInfoRow('Category', 'Vegetable'),
                      const Divider(height: 20),
                      _buildInfoRow('Last Updated', 'Today, 10:30 AM'),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTrendItem(
                            'Yesterday',
                            'Rs. ${(_parsePrice(price.avg_price) * 0.95).toStringAsFixed(2)}',
                          ),
                          _buildTrendItem(
                            'This Week',
                            'Rs. ${(_parsePrice(price.avg_price) * 1.02).toStringAsFixed(2)}',
                          ),
                          _buildTrendItem(
                            'This Month',
                            'Rs. ${(_parsePrice(price.avg_price) * 0.98).toStringAsFixed(2)}',
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
                        'Rs. ${(_parsePrice(price.avg_price) - 5).toStringAsFixed(2)}',
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Share', style: TextStyle(color: Colors.white)),
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
