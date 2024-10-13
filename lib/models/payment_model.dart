class PaymentModel {
  final int total_balance;
  final int average_payments;
  final int average_refunds;
  final List<Donation> donations;

  PaymentModel({
    required this.total_balance,
    required this.average_payments,
    required this.donations,
    required this.average_refunds,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    var donationsList = json['payments'] as List;
    List<Donation> donations = donationsList.map((i) => Donation.fromJson(i)).toList();

    return PaymentModel(
      total_balance: json['total_balance']??0,
      average_payments: json['average_payments']??0,
      average_refunds: json['average_refunds']??0,
      donations: donations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_donations': total_balance,
      'average_donations': average_payments,
      'average_refunds': average_refunds,
      'donations': donations.map((donation) => donation.toJson()).toList(),
    };
  }
}

class Donation {
  final String name;
  final String operation;
  final int amount;
  final String date;

  Donation({
    required this.name,
    required this.operation,
    required this.amount,
    required this.date,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      name: json['name'].toString(),
      operation: json['operation'],
      amount: json['amount'],
      date: json['date'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'operation': operation,
      'amount': amount,
      'date': date,
    };
  }
}
