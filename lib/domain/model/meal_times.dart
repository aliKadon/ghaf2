class MealTimes {
  String? id;
  String? mealName;
  String? startTime;
  String? endTime;

  MealTimes({
    this.id,
    this.endTime,
    this.mealName,
    this.startTime,
});

  factory MealTimes.fromJson(Map<String,dynamic> json) => MealTimes(
    id: json['id'],
    endTime: json['endTime'],
    mealName: json['mealName'],
    startTime: json['startTime'],
  );

  Map<String,dynamic> toJson() => {
    'startTime' : startTime,
    'endTime' : endTime,
    'id' : id,
    'mealName' : mealName,
  };
}