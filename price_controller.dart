import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceController extends GetxController {
  final areaController = TextEditingController();
  final selectedBHK = RxnString();
  final selectedBathroom = RxnString();
  final selectedType = RxnString();
  final predictedPrice = "".obs;
  final isLoading = false.obs;

  final bhkOptions = ['1', '2', '3', '4', '5'];
  final bathroomOptions = ['1', '2', '3', '4'];
  final typeOptions = [
    'Apartment',
    'Builder Floor',
    'Independent House',
    'Penthouse',
  ];

  void resetForm() {
    areaController.clear();
    selectedBHK.value = null;
    selectedBathroom.value = null;
    selectedType.value = null;
    predictedPrice.value = "";
  }

  Future<void> predictPrice() async {
    if (areaController.text.isEmpty ||
        selectedBHK.value == null ||
        selectedBathroom.value == null ||
        selectedType.value == null) {
      Get.snackbar("Incomplete", "Please fill all fields");
      return;
    }

    isLoading.value = true;

    final uri = Uri.parse('http://localhost:5000/predict');
    final body = json.encode({
      "Area": int.parse(areaController.text),
      "BHK": int.parse(selectedBHK.value!),
      "Bathroom": int.parse(selectedBathroom.value!),
      "Type": selectedType.value,
    });

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        predictedPrice.value = "₹${result["predicted_price"]}";
      } else {
        predictedPrice.value = "Error: API Failed";
      }
    } catch (e) {
      predictedPrice.value = "Error: ${e.toString()}";
    }

    isLoading.value = false;
  }
}
