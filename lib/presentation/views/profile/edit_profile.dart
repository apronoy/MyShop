import 'dart:ffi' hide Size;

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/presentation/controllers/profile_controler.dart';
import 'package:my_product/presentation/views/widgets/appbar.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            App_bar(Title: 'Edit Profile', isback: true),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // PROFILE IMAGE
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 42,
                            backgroundImage: AssetImage(
                              "assets/images/profile.jpg",
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Pronoy Sarkar",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "@pronoy_17",
                        style: GoogleFonts.montserrat(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 25),

                      _buildField(
                        label: "Full name",
                        controller: controller.fullNameController,
                        readOnly: false,
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              label: "Gender",
                              controller: controller.genderController,
                              readOnly: false,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _buildField(
                              readOnly: true,
                              ontap: () {
                                pickData(context);
                              },
                              label: "Birthday",

                              controller: controller.birthdayController,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      _buildField(
                        readOnly: false,
                        label: "Phone",
                        controller: controller.phoneController,
                      ),

                      const SizedBox(height: 15),

                      _buildField(
                        readOnly: true,
                        label: "Email",
                        controller: controller.emailController,
                      ),

                      const SizedBox(height: 15),

                      _buildField(
                        readOnly: true,
                        label: "UserName",
                        controller: controller.userNameController,
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Get.snackbar(
                              ' Profile Updated !!',
                              'Successfully updated the profile',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            Future.delayed(Duration(milliseconds: 5000), () {
                              Get.back();
                            });
                          },
                          child: Text(
                            "Save Changes",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    VoidCallback? ontap,
    required bool readOnly,
  }) {
    return TextFormField(
      onTap: ontap,
      readOnly: readOnly,
      controller: controller,
      style: GoogleFonts.montserrat(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(),
        hintStyle: GoogleFonts.montserrat(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

 List<DateTime?> _selectedDate = [];
  Future<void> pickData(BuildContext context) async {
    final result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
      ),
      dialogSize:const Size(300, 400),
      value: _selectedDate,
      borderRadius: BorderRadius.circular(12),
    );
    if (result != null && result.isNotEmpty) {
      final date = result.first;
      controller.birthdayController.text =
          '${date!.day}/${date.month}/${date.year}';
    }
  }
}
