class PaymentInstructionModel {
  final String? channel;
  final List<dynamic>? steps;

  const PaymentInstructionModel({this.channel, this.steps});

  factory PaymentInstructionModel.fromJson(Map<String, dynamic> json) =>
      PaymentInstructionModel(
        channel: json["channel"],
        steps: json["step"],
      );
}
