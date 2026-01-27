import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String buttonText;
  final VoidCallback? onAction;

  const NoDataWidget({
    super.key,
    this.icon = Icons.inbox,
    this.message = 'No data available',
    this.buttonText = 'Retry',
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            if (onAction != null)
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(buttonText, style: const TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}
