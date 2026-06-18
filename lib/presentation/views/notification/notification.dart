import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: GoogleFonts.montserrat(fontSize: 16),
        ),
      ),
      body: Center(
        child: Text(
          'No notifications yet.',
          style: GoogleFonts.montserrat(fontSize: 16),
        ),
      ),
    );
  }
}
