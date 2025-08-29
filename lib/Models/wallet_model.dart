class Wallet {
  final String username;
  final String balance;

  Wallet({required this.username, required this.balance});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      username: json['username'] ?? '',
      balance: json['balance'] ?? '0.00',
    );
  }
}
