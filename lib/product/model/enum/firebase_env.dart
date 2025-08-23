enum FirebaseEnv {
  auth(3000),
  functions(3001),
  firestore(3002),
  storage(3003);

  final int port;
  // ignore: sort_constructors_first
  // This constructor order is intentional for better readability
  const FirebaseEnv(this.port);

  static String localPath = 'localhost';
}
