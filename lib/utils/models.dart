import 'dart:convert';

enum Prefs {
  login,
}

class Login {
  final String loginId;
  final String token;
  final bool isLeader;
  final String leaderId;

  const Login({
    required this.loginId,
    required this.token,
    required this.isLeader,
    required this.leaderId,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      loginId: json['loginId'],
      token: json['token'],
      isLeader: json['isLeader'],
      leaderId: json['isLeader'] ? json['leaderId'] : '',
    );
  }

  String toJsonString() => jsonEncode({
        'loginId': loginId,
        'token': token,
        'isLeader': isLeader,
        'leaderId': leaderId
      });
}

abstract class Person {}

class Challenger extends Person {
  late String loginId;
  late String displayName;
  late List<Queue> queuesEntered;
  late List<Leader> badgesEarned;

  Challenger({
    required this.loginId,
    required this.displayName,
    required this.queuesEntered,
    required this.badgesEarned,
  });

  factory Challenger.fromJson(Map<String, dynamic> json) {
    // Preprocessing
    List<Queue> queuesEntered = [];
    List<Leader> badgesEarned = [];
    json['queuesEntered'].map((queue) {
      return Queue.fromJson(queue);
    });

    return Challenger(
      loginId: json['id'],
      displayName: json['displayName'],
      queuesEntered: json['queuesEntered']
          .map((queue) => Queue.fromJson(queue))
          .toList()
          .cast<Queue>(),
      badgesEarned: json['badgesEarned']
          .map((leader) => Leader.fromJson(leader))
          .toList()
          .cast<Leader>(),
    );
  }
}

class Leader extends Person {
  late String? loginId;
  late String displayName;
  late String leaderId;
  late String badgeName;
  late List<Queue>? queue;
  late List<Hold>? onHold;
  late int? wins;
  late int? losses;
  late int? badgesAwarded;
  late String? bio;
  late String? tagline;

  Leader({
    required this.leaderId,
    required this.displayName,
    required this.badgeName,
    this.bio,
    this.tagline,
  });

  factory Leader.fromJson(Map<String, dynamic> json) {
    return Leader(
      leaderId: json['leaderId'],
      displayName:
          json.containsKey('displayName') ? json['displayName'] : json['name'],
      badgeName: json['badgeName'],
      bio: json['bio'],
      tagline: json['tagline'],
    );
  }
}

class Hold {
  late String leaderId;
  late String displayName;
  late String challengerId;
}

class Queue {
  late String leaderId;
  late String displayName;
  late String badgeName;
  late String? challengerId;
  late int position;

  Queue({
    required this.displayName,
    required this.position,
    required this.leaderId,
    required this.badgeName,
    this.challengerId,
  });

  factory Queue.fromJson(Map<String, dynamic> json) {
    return Queue(
      displayName: json['displayName'],
      position: json['position'],
      leaderId: json['leaderId'],
      badgeName: json['badgeName'],
      challengerId: json['challengerId'],
    );
  }
}
