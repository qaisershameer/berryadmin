import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../common_widgets/custom_form_field.dart';
import '../../utils/q_colors.dart';

class UserForm extends StatelessWidget {
  final UserModel? user;
  final UserController userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();

  UserForm({super.key, this.user});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _photoController = TextEditingController();
  final _paymentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      _nameController.text = user!.name ?? '';
      _emailController.text = user!.email ?? '';
      _phoneController.text = user!.phone ?? '';
      _photoController.text = user!.photo ?? '';
      _paymentsController.text = (user!.totalPayments ?? 0.0).toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Add New User' : 'Edit User'),
        backgroundColor: QColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
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
                          user == null ? 'Create New User' : 'Update User Details',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          label: 'Full Name',
                          controller: _nameController,
                          hint: 'Enter user full name',
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
                        CustomFormField(
                          label: 'Total Payments',
                          controller: _paymentsController,
                          hint: 'Enter total payments',
                          keyboardType: TextInputType.number,
                          suffix: const Icon(Icons.payments),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              final number = double.tryParse(value);
                              if (number == null) {
                                return 'Please enter a valid number';
                              }
                              if (number < 0) {
                                return 'Amount cannot be negative';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        Obx(() => userController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: _handleSubmit,
                                  icon: const Icon(Icons.save),
                                  label: Text(
                                    user == null ? 'Create User' : 'Update User',
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
      final userData = UserModel(
        id: user?.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        photo: _photoController.text,
        blockStatus: 'no',
        totalPayments: double.tryParse(_paymentsController.text) ?? 0.0,
        createdAt: DateTime.now().toIso8601String(),
      );

      try {
        if (user == null) {
          await userController.addUser(userData);
          Get.snackbar(
            'Success',
            'User created successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          await userController.updateUser(userData);
          Get.snackbar(
            'Success',
            'User updated successfully',
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