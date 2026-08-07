enum FirebaseEnv {
  auth(3000),
  functions(3001),
  firestore(3002),
  storage(3003)
  ;

  const FirebaseEnv(this.port);

  final int port;

  static String localPath = 'localhost';
}
