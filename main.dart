import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'price_controller.dart';

void main() {
  runApp(HousePriceApp());
}

class HousePriceApp extends StatelessWidget {
  const HousePriceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Price Predictor',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 58, 81, 183),
        ),
        useMaterial3: true,
      ),
      home: PricePredictorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PricePredictorPage extends StatelessWidget {
  final PriceController controller = Get.put(PriceController());

  PricePredictorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("House Price Predictor"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFB39DDB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white.withOpacity(0.95),
              margin: EdgeInsets.all(20),
              elevation: 12,
              shadowColor: Colors.deepPurple.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      "Enter Property Details",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: controller.areaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        labelText: "Area (sq.ft)",
                        prefixIcon: Icon(Icons.square_foot),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),

                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedBHK.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          labelText: "BHK",
                          prefixIcon: Icon(Icons.bed),
                          border: OutlineInputBorder(),
                        ),
                        items:
                            controller.bhkOptions.map((val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
                        onChanged: (val) => controller.selectedBHK.value = val,
                      ),
                    ),
                    SizedBox(height: 15),

                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedBathroom.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          labelText: "Bathrooms",
                          prefixIcon: Icon(Icons.bathtub),
                          border: OutlineInputBorder(),
                        ),
                        items:
                            controller.bathroomOptions.map((val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
                        onChanged:
                            (val) => controller.selectedBathroom.value = val,
                      ),
                    ),
                    SizedBox(height: 15),

                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedType.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ).withOpacity(0.9),
                          labelText: "Property Type",
                          prefixIcon: Icon(Icons.home_work),
                          border: OutlineInputBorder(),
                        ),
                        items:
                            controller.typeOptions.map((val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
                        onChanged: (val) => controller.selectedType.value = val,
                      ),
                    ),
                    SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              123,
                              189,
                              219,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onPressed: controller.predictPrice,
                          icon: Icon(Icons.calculate),
                          label: Text("Predict"),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 221, 228, 225),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onPressed: controller.resetForm,
                          icon: Icon(Icons.refresh),
                          label: Text("Reset"),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    Obx(
                      () =>
                          controller.isLoading.value
                              ? CircularProgressIndicator()
                              : controller.predictedPrice.isNotEmpty
                              ? Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                color: const Color.fromARGB(255, 192, 132, 241),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        size: 40,
                                        color: Colors.indigo,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Predicted Price:\n${controller.predictedPrice.value}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromARGB(
                                            255,
                                            228,
                                            198,
                                            68,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
