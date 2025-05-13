import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/trip_controller.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/driver_controller.dart';
import '../../models/trip_model.dart';
import '../../common_widgets/custom_form_field.dart';
import '../../utils/q_colors.dart';

class TripForm extends StatelessWidget {
  final TripModel? trip;
  final TripController tripController = Get.find<TripController>();
  final UserController userController = Get.find<UserController>();
  final DriverController driverController = Get.find<DriverController>();
  final _formKey = GlobalKey<FormState>();

  TripForm({super.key, this.trip});

  final _pickupAddressController = TextEditingController();
  final _dropoffAddressController = TextEditingController();
  final _pickupLatController = TextEditingController();
  final _pickupLngController = TextEditingController();
  final _dropoffLatController = TextEditingController();
  final _dropoffLngController = TextEditingController();
  final _fareController = TextEditingController();
  final _distanceController = TextEditingController();
  final _durationController = TextEditingController();

  String? selectedUserId;
  String? selectedDriverId;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    if (trip != null) {
      _pickupAddressController.text = trip!.pickupAddress ?? '';
      _dropoffAddressController.text = trip!.dropoffAddress ?? '';
      _pickupLatController.text = trip!.pickupLat?.toString() ?? '';
      _pickupLngController.text = trip!.pickupLng?.toString() ?? '';
      _dropoffLatController.text = trip!.dropoffLat?.toString() ?? '';
      _dropoffLngController.text = trip!.dropoffLng?.toString() ?? '';
      _fareController.text = trip!.fare?.toString() ?? '';
      _distanceController.text = trip!.distance?.toString() ?? '';
      _durationController.text = trip!.duration?.toString() ?? '';
      selectedUserId = trip!.userId;
      selectedDriverId = trip!.driverId;
      selectedPaymentMethod = trip!.paymentMethod;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(trip == null ? 'Add New Trip' : 'Edit Trip'),
        backgroundColor: QColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip == null ? 'Create New Trip' : 'Update Trip Details',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Obx(() => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: DropdownButtonFormField<String>(
                                      value: selectedUserId,
                                      decoration: const InputDecoration(
                                        labelText: 'Select User',
                                        border: InputBorder.none,
                                        icon: Icon(Icons.person_outline),
                                      ),
                                      items: userController.users.map((user) {
                                        return DropdownMenuItem(
                                          value: user.id,
                                          child: Text(user.name ?? 'Unknown User'),
                                        );
                                      }).toList(),
                                      onChanged: (value) => selectedUserId = value,
                                      validator: (value) =>
                                          value == null ? 'Please select a user' : null,
                                    ),
                                  )),
                                  const SizedBox(height: 16),
                                  Obx(() => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: DropdownButtonFormField<String>(
                                      value: selectedDriverId,
                                      decoration: const InputDecoration(
                                        labelText: 'Select Driver',
                                        border: InputBorder.none,
                                        icon: Icon(Icons.drive_eta),
                                      ),
                                      items: driverController.drivers
                                          .where((driver) => driver.isApproved == true)
                                          .map((driver) {
                                        return DropdownMenuItem(
                                          value: driver.id,
                                          child: Text(driver.name ?? 'Unknown Driver'),
                                        );
                                      }).toList(),
                                      onChanged: (value) => selectedDriverId = value,
                                      validator: (value) =>
                                          value == null ? 'Please select a driver' : null,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomFormField(
                                    label: 'Pickup Address',
                                    controller: _pickupAddressController,
                                    hint: 'Enter pickup address',
                                    suffix: const Icon(Icons.location_on),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Pickup address is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomFormField(
                                          label: 'Pickup Latitude',
                                          controller: _pickupLatController,
                                          hint: 'Enter latitude',
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          validator: (value) => _validateCoordinate(value, 'latitude'),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: CustomFormField(
                                          label: 'Pickup Longitude',
                                          controller: _pickupLngController,
                                          hint: 'Enter longitude',
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          validator: (value) => _validateCoordinate(value, 'longitude'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomFormField(
                                    label: 'Dropoff Address',
                                    controller: _dropoffAddressController,
                                    hint: 'Enter dropoff address',
                                    suffix: const Icon(Icons.location_off),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Dropoff address is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomFormField(
                                          label: 'Dropoff Latitude',
                                          controller: _dropoffLatController,
                                          hint: 'Enter latitude',
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          validator: (value) => _validateCoordinate(value, 'latitude'),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: CustomFormField(
                                          label: 'Dropoff Longitude',
                                          controller: _dropoffLngController,
                                          hint: 'Enter longitude',
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          validator: (value) => _validateCoordinate(value, 'longitude'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomFormField(
                                label: 'Distance (km)',
                                controller: _distanceController,
                                hint: 'Enter distance in kilometers',
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                suffix: const Icon(Icons.straighten),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Distance is required';
                                  }
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (number < 0) {
                                    return 'Distance cannot be negative';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomFormField(
                                label: 'Duration (minutes)',
                                controller: _durationController,
                                hint: 'Enter estimated duration',
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                suffix: const Icon(Icons.timer),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Duration is required';
                                  }
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (number < 0) {
                                    return 'Duration cannot be negative';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomFormField(
                                label: 'Fare Amount',
                                controller: _fareController,
                                hint: 'Enter fare amount',
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                suffix: const Icon(Icons.attach_money),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Fare is required';
                                  }
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (number < 0) {
                                    return 'Fare cannot be negative';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: DropdownButtonFormField<String>(
                                  value: selectedPaymentMethod,
                                  decoration: const InputDecoration(
                                    labelText: 'Payment Method',
                                    border: InputBorder.none,
                                    icon: Icon(Icons.payment),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'cash',
                                      child: Text('Cash'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'card',
                                      child: Text('Card'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'wallet',
                                      child: Text('Wallet'),
                                    ),
                                  ],
                                  onChanged: (value) => selectedPaymentMethod = value,
                                  validator: (value) =>
                                      value == null ? 'Please select a payment method' : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Obx(() => tripController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: _handleSubmit,
                                  icon: const Icon(Icons.save),
                                  label: Text(
                                    trip == null ? 'Create Trip' : 'Update Trip',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: QColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateCoordinate(String? value, String type) {
    if (value == null || value.isEmpty) {
      return '$type is required';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (type == 'latitude' && (number < -90 || number > 90)) {
      return 'Latitude must be between -90 and 90';
    }
    if (type == 'longitude' && (number < -180 || number > 180)) {
      return 'Longitude must be between -180 and 180';
    }
    return null;
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final tripData = TripModel(
        id: trip?.id,
        userId: selectedUserId,
        driverId: selectedDriverId,
        pickupAddress: _pickupAddressController.text,
        dropoffAddress: _dropoffAddressController.text,
        pickupLat: double.tryParse(_pickupLatController.text),
        pickupLng: double.tryParse(_pickupLngController.text),
        dropoffLat: double.tryParse(_dropoffLatController.text),
        dropoffLng: double.tryParse(_dropoffLngController.text),
        status: trip?.status ?? 'pending',
        distance: double.tryParse(_distanceController.text),
        duration: double.tryParse(_durationController.text),
        fare: double.tryParse(_fareController.text),
        paymentMethod: selectedPaymentMethod,
        isPaid: false,
        createdAt: DateTime.now().toIso8601String(),
      );

      try {
        if (trip == null) {
          await tripController.addTrip(tripData);
          Get.snackbar(
            'Success',
            'Trip created successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          await tripController.updateTrip(tripData);
          Get.snackbar(
            'Success',
            'Trip updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
        Get.back();
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
} 