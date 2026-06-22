import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/presentation/views/widgets/appbar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            App_bar(Title: 'Notification', isback: true),
            const SizedBox(height: 250),
            Text(
              'No notifications yet',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
