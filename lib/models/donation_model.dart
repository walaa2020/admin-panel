class DonationResponse {
  final int totalDonations;
  final int averageDonations;
  final List<Donation> donations;

  DonationResponse({
    required this.totalDonations,
    required this.averageDonations,
    required this.donations,
  });

  factory DonationResponse.fromJson(Map<String, dynamic> json) {
    var donationsList = json['donations'] as List;
    List<Donation> donations = donationsList.map((i) => Donation.fromJson(i)).toList();

    return DonationResponse(
      totalDonations: json['total_donations'].toInt(),
      averageDonations: json['average_donations'].toInt(),
      donations: donations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_donations': totalDonations,
      'average_donations': averageDonations,
      'donations': donations.map((donation) => donation.toJson()).toList(),
    };
  }
}

class Donation {
  final String name;
  final String receipt;
  final int amount;
  final String date;

  Donation({
    required this.name,
    required this.receipt,
    required this.amount,
    required this.date,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      name: json['name'].toString(),
      receipt: json['receipt'],
      amount: json['amount'],
      date: json['date'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'receipt': receipt,
      'amount': amount,
      'date': date,
    };
  }
}
