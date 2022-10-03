import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ppl_companion/utils/api.dart';
import 'package:ppl_companion/utils/models.dart';

import '../utils/environment.dart';

class TrainerCard extends StatefulWidget {
  const TrainerCard({Key? key}) : super(key: key);

  @override
  State<TrainerCard> createState() => _TrainerCardState();
}

class _TrainerCardState extends State<TrainerCard> {
  late Future<List<Leader>> leaders;

  @override
  initState() {
    leaders = DataApi.getAllLeaders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // First get the login "cookie"
    return FutureBuilder<List<Leader>>(
      future: leaders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildTrainerCard(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildTrainerCard(BuildContext context, List<Leader> leaders) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Data.pplTitle),
        toolbarHeight: 64,
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: leaders.length,
          itemBuilder: (BuildContext context, int index) {
            return leaderItem(context, leaders[index]);
          },
        ),
      ),
    );
  }

  Widget leaderItem(BuildContext context, Leader leader) {
    return Center(
      child: Column(
        children: [
          Text(leader.displayName),
          Text(leader.badgeName),
          Html(
            data: leader.bio,
          ),
          Html(
            data: leader.tagline,
          ),
        ],
      ),
    );
  }
}
