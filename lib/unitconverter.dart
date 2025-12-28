import 'package:flutter/material.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({Key? key}) : super(key: key);

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  List<String> categories = ['Length', 'Temperature', 'Mass'];
  String? category;
  String? fromUnit;
  String? toUnit;
  double inputValue = 0;
  double? convertedValue;
  String? errorMessage;

  void convert() {
    if (category != null && fromUnit != null && toUnit != null && inputValue != 0) {
      setState(() {
        errorMessage = null;
        // Implement conversion logic based on selected category and units
        switch (category) {
          case 'Length':
            convertedValue = _convertLength();
            break;
          case 'Temperature':
            convertedValue = _convertTemperature();
            break;
          case 'Mass':
            convertedValue = _convertMass();
            break;
          default:
            break;
        }
      });
    } else {
      setState(() {
        errorMessage = 'Please select a category, units, and enter a value.';
        convertedValue = null;
      });
    }
  }

  double _convertLength() {
    // Conversion logic for length
    double result = inputValue;

    // Convert from selected unit to meters
    switch (fromUnit) {
      case 'Meter':
        break;
      case 'Centimeter':
        result /= 100;
        break;
      case 'Kilometer':
        result *= 1000;
        break;
      case 'Millimeter':
        result /= 1000;
        break;
      case 'Foot':
        result *= 0.3048;
        break;
      case 'Inch':
        result *= 0.0254;
        break;
      // Add conversion for other units as needed
    }

    // Convert from meters to selected unit
    switch (toUnit) {
      case 'Meter':
        break;
      case 'Centimeter':
        result *= 100;
        break;
      case 'Kilometer':
        result /= 1000;
        break;
      case 'Millimeter':
        result *= 1000;
        break;
      case 'Foot':
        result /= 0.3048;
        break;
      case 'Inch':
        result /= 0.0254;
        break;
      // Add conversion for other units as needed
    }

    return result;
  }

  double _convertTemperature() {
    // Conversion logic for temperature
    double result = inputValue;

    // Convert from selected unit to Celsius
    switch (fromUnit) {
      case 'Celsius':
        break;
      case 'Fahrenheit':
        result = (result - 32) * 5 / 9;
        break;
      case 'Kelvin':
        result -= 273.15;
        break;
      // Add conversion for other units as needed
    }

    // Convert from Celsius to selected unit
    switch (toUnit) {
      case 'Celsius':
        break;
      case 'Fahrenheit':
        result = result * 9 / 5 + 32;
        break;
      case 'Kelvin':
        result += 273.15;
        break;
      // Add conversion for other units as needed
    }

    return result;
  }

  double _convertMass() {
    // Conversion logic for mass
    double result = inputValue;

    // Convert from selected unit to kilograms
    switch (fromUnit) {
      case 'Kilogram':
        break;
      case 'Gram':
        result /= 1000;
        break;
      case 'Milligram':
        result /= 1000000;
        break;
      case 'Pound':
        result *= 0.453592;
        break;
      // Add conversion for other units as needed
    }

    // Convert from kilograms to selected unit
    switch (toUnit) {
      case 'Kilogram':
        break;
      case 'Gram':
        result *= 1000;
        break;
      case 'Milligram':
        result *= 1000000;
        break;
      case 'Pound':
        result /= 0.453592;
        break;
      // Add conversion for other units as needed
    }

    return result;
  }

  List<DropdownMenuItem<String>> _getUnitsForCategory(String category) {
    // Return a list of dropdown menu items for units based on selected category
    switch (category) {
      case 'Length':
        return [
          const DropdownMenuItem(value: 'Meter', child: Text('Meter')),
          const DropdownMenuItem(value: 'Centimeter', child: Text('Centimeter')),
          const DropdownMenuItem(value: 'Kilometer', child: Text('Kilometer')),
          const DropdownMenuItem(value: 'Millimeter', child: Text('Millimeter')),
          const DropdownMenuItem(value: 'Foot', child: Text('Foot')),
          const DropdownMenuItem(value: 'Inch', child: Text('Inch')),
          // Add more units for length category as needed
        ];
      case 'Temperature':
        return [
          const DropdownMenuItem(value: 'Celsius', child: Text('Celsius')),
          const DropdownMenuItem(value: 'Fahrenheit', child: Text('Fahrenheit')),
          const DropdownMenuItem(value: 'Kelvin', child: Text('Kelvin')),
          // Add more units for temperature category as needed
        ];
      case 'Mass':
        return [
          const DropdownMenuItem(value: 'Kilogram', child: Text('Kilogram')),
          const DropdownMenuItem(value: 'Gram', child: Text('Gram')),
          const DropdownMenuItem(value: 'Milligram', child: Text('Milligram')),
          const DropdownMenuItem(value: 'Pound', child: Text('Pound')),
          // Add more units for mass category as needed
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Unit Converter',
          style: TextStyle(color: Color.fromRGBO(88, 20, 143, 1)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: category,
                  hint: const Text('Select category'),
                  items: categories.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat,
                      child: Text(
                        cat,
                        style: const TextStyle(
                          color: Color.fromRGBO(88, 20, 143, 1),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue;
                      // Reset selected units when changing category
                      fromUnit = null;
                      toUnit = null;
                    });
                  },
                  style: const TextStyle(color: Color.fromRGBO(88, 20, 143, 1)), // Change text color
                  dropdownColor:
                      Colors.white, // Change dropdown background color
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter value',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white, // Change input field background color
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      inputValue = double.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: fromUnit,
                        hint: const Text('From unit'),
                        items: category != null
                            ? _getUnitsForCategory(category!)
                            : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            fromUnit = newValue;
                          });
                        },
                        style: const TextStyle(
                            color: Color.fromRGBO(88, 20, 143, 1)), // Change text color
                        dropdownColor:
                            Colors.white, // Change dropdown background color
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz, color: Color.fromRGBO(88, 20, 143, 1),),
                      onPressed: () {
                        setState(() {
                          final String? temp = fromUnit;
                          fromUnit = toUnit;
                          toUnit = temp;
                        });
                      },
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: toUnit,
                        hint: const Text('To unit'),
                        items: category != null
                            ? _getUnitsForCategory(category!)
                            : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            toUnit = newValue;
                          });
                        },
                        style: const TextStyle(
                            color: Color.fromRGBO(88, 20, 143, 1)), // Change text color
                        dropdownColor:
                            Colors.white, // Change dropdown background color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    
                    convert();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(88, 20, 143, 1),
                  ),
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 20),
                errorMessage != null
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                convertedValue != null
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Converted value: ${convertedValue?.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
