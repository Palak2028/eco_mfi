

class RepaymentFrequency {
  int repaymentFrequencyId;
  String repaymentFrequency;
  String repaymentFrequencyDescription;

  RepaymentFrequency(
      {this.repaymentFrequencyId,
      this.repaymentFrequency,
      this.repaymentFrequencyDescription});

  @override
  String toString() {
    return 'PurposeOfLoan{repaymentFrequencyId: $repaymentFrequencyId, repaymentFrequency: $repaymentFrequency, repaymentFrequencyDescription: $repaymentFrequencyDescription}';
  }

  factory RepaymentFrequency.fromMap(Map<String, dynamic> map) {
    return RepaymentFrequency(
        repaymentFrequencyId: map["repaymentFrequencyId"] as int,
        repaymentFrequency: map["repaymentFrequency"] as String,
        repaymentFrequencyDescription:
            map["repaymentFrequencyDescription"] as String);
  }
}
