import 'package:eco_mfi/db/TablesColumnFile.dart';

class TransactionMode {
  int transactionModeId;
  String transactionMode;
  String transactionModeDescription;

  TransactionMode(
      {this.transactionModeId,
      this.transactionMode,
      this.transactionModeDescription});

  @override
  String toString() {
    return 'TransactionMode{transactionModeId: $transactionModeId, transactionMode: $transactionMode, transactionModeDescription: $transactionModeDescription}';
  }

  factory TransactionMode.fromMap(Map<String, dynamic> map) {
    return TransactionMode(
        transactionModeId: map["transactionModeId"] as int,
        transactionMode: map["transactionMode"] as String,
        transactionModeDescription:
            map["transactionModeDescription"] as String);
  }
}
