import 'package:flutter/material.dart';

import '../main.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Directories'),
      ),
      body: Center(
        child: InkWell(
          child: const Text('Page One. Click to go to Page Two.'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MyApp())),
        ),
      ),
      // drawer: const Sidenav(),
    );
  }
}
