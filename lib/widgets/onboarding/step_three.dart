import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';

class StepThree extends StatelessWidget {
  const StepThree({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: TextField(
          controller: nameController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Center(
              child: Text(
                "Username",
                style: TextStyle(color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            // labelText: 'Username', // Label text for the TextField
            // labelStyle: const TextStyle(color: AppColors.grey),
            alignLabelWithHint: true,
            hintText:
                'Enter your username', // Hint text to provide a hint to the user
            hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.7)),
            filled: true,
            fillColor:
                AppColors.lightBlack, // Background color for the TextField
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.yellow),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.darkGrey),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.grey), // Text color for the input text
          cursorColor: AppColors.white, // Color of the text cursor
          keyboardType: TextInputType.text, // Keyboard type for the input
          textInputAction: TextInputAction
              .done, // Action button on the keyboard (in this case, the "Done" button)
          onChanged: (value) {
            // Callback when the user types in the TextField
            // You can do something with the value, like updating the state
            // e.g., setState(() { username = value });
          },
          onSubmitted: (value) {
            // Callback when the user submits the TextField (e.g., presses the "Done" button)
            // You can handle form submission or other actions here
          },
        ),
      ),
    );
  }
}
