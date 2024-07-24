enum Transactiontype { payment, deposit, received, withdrawal, transfer }

Transactiontype transactionTypeFromString(String type) {
  switch (type.toLowerCase()) {
    case 'payment':
      return Transactiontype.payment;
    case 'deposit':
      return Transactiontype.deposit;
    case 'received':
      return Transactiontype.received;
    case 'withdrawal':
      return Transactiontype.withdrawal;
    case 'transfer':
      return Transactiontype.transfer;
    default:
      throw ArgumentError('Invalid transaction type: $type');
  }
}
