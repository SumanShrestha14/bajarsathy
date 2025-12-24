import 'package:bajarsathy_frontend/core/constants/api_constants.dart';
import 'package:bajarsathy_frontend/features/feature1/data/models/single_price_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class SinglePriceDataSource {
  Future<SinglePriceModel> getSinglePrice(String productName);
}

class SinglePriceDataSourceImplemention implements SinglePriceDataSource {
  final http.Client client;

  SinglePriceDataSourceImplemention(this.client);

  @override
  Future<SinglePriceModel> getSinglePrice(String productName) async {
    final baseUrl = ApiConstants.baseUrl;
    final apiKey = ApiConstants.apiKey;

    if (baseUrl.isEmpty || apiKey.isEmpty) {
      throw Exception('API configuration is missing.');
    }

    if (productName.isEmpty) {
      throw Exception('Product name is required.');
    }

    try {
      final encodedProductName = Uri.encodeComponent(productName);
      final response = await client
          .get(
            Uri.parse(
              '$baseUrl/api/price-trend?product_name=$encodedProductName',
            ),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "X-API-KEY": apiKey,
            },
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        try {
          final jsonMap = json.decode(response.body) as Map<String, dynamic>;

          // Debug: Log the response structure
          debugPrint('Single Price API Response: $jsonMap');

          // The API returns: {product_name: "...", data: [{...}]}
          // Extract the first item from the data array
          Map<String, dynamic> dataToParse;
          if (jsonMap.containsKey('data')) {
            final dataList = jsonMap['data'] as List;
            if (dataList.isEmpty) {
              throw Exception('No price data found for this product.');
            }
            // Get the first (most recent) price entry
            dataToParse = dataList[0] as Map<String, dynamic>;
            debugPrint('Extracted price data: $dataToParse');
          } else {
            // If no 'data' field, use the root object directly
            dataToParse = jsonMap;
          }

          return SinglePriceModel.fromJson(dataToParse);
        } catch (e) {
          debugPrint('JSON Parsing Error: $e');
          debugPrint('Response body: ${response.body}');
          throw Exception('Failed to parse single price data: $e');
        }
      } else {
        debugPrint('HTTP Error: Status Code ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception('Failed to load prices: HTTP ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection.');
    } on FormatException {
      throw Exception('Invalid JSON format.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
