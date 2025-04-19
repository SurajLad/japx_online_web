import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:japx/japx.dart';
import 'dart:html' as html;

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController inputEditingController = TextEditingController();
  final TextEditingController outputEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('About'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Image.network(
                          'https://raw.githubusercontent.com/infinum/flutter-plugins-japx/master/japx-logo-new.png',
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'JSON:API Decoder/Encoder',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'JSON API Parser online is tool for converting complex\nJSON:API structure into simple JSON based on Flutter Japx.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text('Credits : '),
                        const Text('https://pub.dev/packages/japx'),
                        const SizedBox(height: 24),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
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
            Container(
              margin: const EdgeInsets.only(left: 24, right: 24),
              child: const Text(
                'Paste your JSON in the textarea below, click convert and get your parsed JSON.',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'JSON',
                      ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(left: 24, right: 24),
                        child: TextFormField(
                          maxLines: 24,
                          controller: inputEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton.extended(
                        onPressed: () {
                          try {
                            final enteredJson =
                                jsonDecode(inputEditingController.text);
                            final data = Japx.decode(enteredJson);
                            outputEditingController.text =
                                getPrettyJSONString(data);
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Oops! Unable to parse the entered JSON!',
                                ),
                              ),
                            );
                          }
                        },
                        label: const Row(
                          children: [
                            Icon(Icons.sync),
                            SizedBox(width: 6),
                            Text('Parse JSON'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'PARSED JSON',
                      ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(left: 24, right: 24),
                        child: TextFormField(
                          maxLines: 24,
                          readOnly: true,
                          controller: outputEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton.extended(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(
                              text: outputEditingController.text));
                        },
                        label: const Row(
                          children: [
                            Icon(Icons.copy),
                            SizedBox(width: 6),
                            Text('Copy to clipboard'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            label: SizedBox(
              width: 16,
              height: 16,
              child: Image.asset(
                'assets/github.png',
              ),
            ),
            icon: const Text('Handcrafted by Suraj Lad'),
            onPressed: () => html.window.open(
              'https://github.com/SurajLad/',
              'Suraj Lad',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    const encoder = JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }
}
