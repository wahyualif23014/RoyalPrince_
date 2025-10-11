import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.contact_mail_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Halaman Kontak',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('Sediakan informasi kontak Anda di sini.'),
        ],
      ),
    );
  }
}