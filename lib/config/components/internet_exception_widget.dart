import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatelessWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        const Icon(Icons.wifi_off, size: 100, color: Colors.red),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Text(
              "We're unable to show results.\n Please check your data\nconnection.",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontSize: 20),
            ),
          ),
        ),
       // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPress,
            child: Text("RETRY", style: Theme.of(context).textTheme.bodySmall),
          ),
        ),
      ],
    );
  }
}
