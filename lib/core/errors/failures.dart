import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

const String messageConnectionFailure = 'No Internet connection';
const String messageDataBaseFailure = 'Database Error Occurred';

class ServerFailure extends Failure {
  final String errorMessage;

  ServerFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $errorMessage}';
  }
}

class ConnectionFailure extends Failure {
  final String errorMessage = messageConnectionFailure;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $errorMessage}';
  }
}

class DatabaseFailure extends Failure {
  final String errorMessage = messageDataBaseFailure;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'DatabaseFailure{errorMessage: $errorMessage}';
  }
}
