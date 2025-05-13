import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/driver_controller.dart';
import '../../models/driver_model.dart';
import '../../models/vehicle_details.dart';
import '../../common_widgets/custom_form_field.dart';
import '../../utils/q_colors.dart';

class DriverForm extends StatelessWidget {
  final DriverModel? driver;
  final DriverController driverController = Get.find<DriverController>();
  final _formKey = GlobalKey<FormState>();

  DriverForm({super.key, this.driver});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _photoController = TextEditingController();
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carColorController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _registrationNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (driver != null) {
      _nameController.text = driver!.name ?? '';
      _emailController.text = driver!.email ?? '';
      _phoneController.text = driver!.phone ?? '';
      _photoController.text = driver!.photo ?? '';
      _carMakeController.text = driver!.vehicleDetails?.make ?? '';
      _carModelController.text = driver!.vehicleDetails?.model ?? '';
      _carYearController.text = driver!.vehicleDetails?.year ?? '';
      _carColorController.text = driver!.vehicleDetails?.color ?? '';
      _plateNumberController.text = driver!.vehicleDetails?.plateNumber ?? '';
      _registrationNumberController.text = driver!.vehicleDetails?.registrationNumber ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(driver == null ? 'Add New Driver' : 'Edit Driver'),
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
                          driver == null ? 'Create New Driver' : 'Update Driver Details',
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
                                  CustomFormField(
                                    label: 'Full Name',
                                    controller: _nameController,
                                    hint: 'Enter driver full name',
                                    suffix: const Icon(Icons.person),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Email',
                                    controller: _emailController,
                                    hint: 'Enter email address',
                                    keyboardType: TextInputType.emailAddress,
                                    suffix: const Icon(Icons.email),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!GetUtils.isEmail(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Phone Number',
                                    controller: _phoneController,
                                    hint: 'Enter phone number',
                                    keyboardType: TextInputType.phone,
                                    suffix: const Icon(Icons.phone),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone number is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Profile Photo URL',
                                    controller: _photoController,
                                    hint: 'Enter profile photo URL',
                                    suffix: const Icon(Icons.image),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomFormField(
                                    label: 'Car Make',
                                    controller: _carMakeController,
                                    hint: 'Enter car make (e.g., Toyota)',
                                    suffix: const Icon(Icons.directions_car),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Car make is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Car Model',
                                    controller: _carModelController,
                                    hint: 'Enter car model (e.g., Camry)',
                                    suffix: const Icon(Icons.directions_car),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Car model is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Car Year',
                                    controller: _carYearController,
                                    hint: 'Enter car year',
                                    keyboardType: TextInputType.number,
                                    suffix: const Icon(Icons.calendar_today),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Car year is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Car Color',
                                    controller: _carColorController,
                                    hint: 'Enter car color',
                                    suffix: const Icon(Icons.color_lens),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Car color is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'License Plate Number',
                                    controller: _plateNumberController,
                                    hint: 'Enter license plate number',
                                    suffix: const Icon(Icons.pin),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'License plate number is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomFormField(
                                    label: 'Registration Number',
                                    controller: _registrationNumberController,
                                    hint: 'Enter vehicle registration number',
                                    suffix: const Icon(Icons.assignment),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Registration number is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Obx(() => driverController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: _handleSubmit,
                                  icon: const Icon(Icons.save),
                                  label: Text(
                                    driver == null ? 'Create Driver' : 'Update Driver',
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

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final vehicleDetails = VehicleDetails(
        make: _carMakeController.text,
        model: _carModelController.text,
        year: _carYearController.text,
        color: _carColorController.text,
        plateNumber: _plateNumberController.text,
        registrationNumber: _registrationNumberController.text,
      );

      final driverData = DriverModel(
        id: driver?.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        photo: _photoController.text,
        blockStatus: 'no',
        isAvailable: true,
        isApproved: false,
        rating: 0.0,
        totalTrips: 0,
        totalEarnings: 0.0,
        vehicleDetails: vehicleDetails,
        createdAt: DateTime.now().toIso8601String(),
      );

      try {
        if (driver == null) {
          await driverController.addDriver(driverData);
          Get.snackbar(
            'Success',
            'Driver created successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          await driverController.updateDriver(driverData);
          Get.snackbar(
            'Success',
            'Driver updated successfully',
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