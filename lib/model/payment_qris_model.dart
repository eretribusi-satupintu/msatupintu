class PaymentQrisModel {
  final String? requestId;
  final int? amount;
  final String? invoiceNumber;
  final int? paymentDueDate;
  final String? paymentMethodTypes;

  const PaymentQrisModel(
      {this.requestId,
      this.amount,
      this.invoiceNumber,
      this.paymentDueDate,
      this.paymentMethodTypes});

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'amount': amount,
      'invoice_number': invoiceNumber,
      'payment_due_date': paymentDueDate,
      'payment_method_types': paymentMethodTypes
    };
  }
}
