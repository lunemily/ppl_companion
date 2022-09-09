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
      leaderId: json['leaderId'] == null ? json['leaderId'] : '',
    );
  }
}
