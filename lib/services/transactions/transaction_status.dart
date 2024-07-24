enum TransactionStatus {
  pending, // En cours
  completed, // Effectué
  failed, // Échoué
  canceled, // Annulé
  onHold, // En attente
  inProgress, // En cours de traitement
}

TransactionStatus transactionStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return TransactionStatus.pending;
    case 'completed':
      return TransactionStatus.completed;
    case 'failed':
      return TransactionStatus.failed;
    case 'canceled':
      return TransactionStatus.canceled;
    case 'onhold':
      return TransactionStatus.onHold;
    case 'inprogress':
      return TransactionStatus.inProgress;
    default:
      throw ArgumentError('Invalid transaction status: $status');
  }
}
