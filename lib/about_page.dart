import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('About'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/about');
            },
            child: const Text("About"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),
            Image.network(
              'https://raw.githubusercontent.com/infinum/flutter-plugins-japx/master/japx-logo-new.png',
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            const Text(
              'JSON:API Decoder/Encoder',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              'JSON API Parser online is tool for converting complex JSON:API structure into simple JSON based on Flutter Japx.',
            ),
            const SizedBox(height: 16),
            const Text('Credits : '),
            const Text('https://pub.dev/packages/japx'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
