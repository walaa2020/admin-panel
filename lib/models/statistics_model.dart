class StatisticsModelDoctor {
  final int visits;

  final int appointments;

  final int patients;
  StatisticsModelDoctor({
    required this.visits,
    required this.appointments,
    required this.patients,
  });

  // من أجل تحويل JSON إلى نموذج

  factory StatisticsModelDoctor.fromJson(Map<String, dynamic> json) {
    return StatisticsModelDoctor(
      visits: json['visits'],
      appointments: json['appointments'],
      patients: json['patients'],
    );
  }

  // من أجل تحويل النموذج إلى JSON

  Map<String, dynamic> toJson() {
    return {
      'visits': visits,
      'appointments': appointments,
      'patients': patients,
    };
  }
}
