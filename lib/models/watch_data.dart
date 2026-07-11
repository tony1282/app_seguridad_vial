class WatchData {
  final double heartRate;
  final double speed;
  final int battery;
  final bool isConnected;
  final double steps;
  final double calories;
  final double distance;
  final double oxygenSaturation;
  final bool isGpsActive;

  const WatchData({
    this.heartRate = 0,
    this.speed = 0,
    this.battery = 0,
    this.isConnected = false,
    this.steps = 0,
    this.calories = 0,
    this.distance = 0,
    this.oxygenSaturation = 0,
    this.isGpsActive = false,
  });

  WatchData copyWith({
    double? heartRate,
    double? speed,
    int? battery,
    bool? isConnected,
    double? steps,
    double? calories,
    double? distance,
    double? oxygenSaturation,
    bool? isGpsActive,
  }) {
    return WatchData(
      heartRate: heartRate ?? this.heartRate,
      speed: speed ?? this.speed,
      battery: battery ?? this.battery,
      isConnected: isConnected ?? this.isConnected,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      distance: distance ?? this.distance,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      isGpsActive: isGpsActive ?? this.isGpsActive,
    );
  }
}
