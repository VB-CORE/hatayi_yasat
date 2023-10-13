enum FirebaseQueryOrders {
  createdAt(name: 'createdAt', descending: true),
  updatedAt(name: 'updatedAt', descending: true),
  ;

  const FirebaseQueryOrders({required this.name, required this.descending});
  final String name;
  final bool descending;
}
