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

abstract class Person {
  late String loginId;
  late String displayName;
}

class Challenger {
  late String loginId;
  late String displayName;
  late List<Queue> queuedEntered;
  late List<Leader> badgesEarned;

  Challenger({
    required this.loginId,
    required this.displayName,
    required this.queuedEntered,
    required this.badgesEarned,
  });
}

class Leader {
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

  Leader(
    this.loginId,
    this.displayName,
    this.leaderId,
    this.badgeName,
    this.queue,
    this.onHold,
    this.wins,
    this.losses,
    this.badgesAwarded,
    this.bio,
    this.tagline,
  );
}

class Hold {
  late String leaderId;
  late String leaderName;
  late String displayName;
  late String challengerId;
}

class Queue {
  late String leaderId;
  late String leaderName;
  late String displayName;
  late String badgeName;
  late String challengerId;
  late int position;
}
