import 'package:flutter_test/flutter_test.dart';
import 'package:aspen_app/core/errors/failures.dart';

void main() {
  const tErrorMessage = 'testErrorMessage';

  group("ServerFailure", () {
    test("make sure toString return true results", () {
      expect(ServerFailure(tErrorMessage).toString(),
          "ServerFailure{errorMessage: $tErrorMessage}");
    });

    test("make sure ServerFailure props return [tErrorMessage]", () {
      expect(ServerFailure(tErrorMessage).props, [tErrorMessage]);
    });
  });

  group("ConnectionFailure", () {
    test("make sure ConnectionFailure toString return true results", () {
      expect(ConnectionFailure().toString(),
          "ConnectionFailure{errorMessage: $messageConnectionFailure}");
    });

    test("make sure ConnectionFailure props return [messageConnectionFailure]", () {
      expect(ConnectionFailure().props, [messageConnectionFailure]);
    });
  });

  group("DatabaseFailure", () {
    test("make sure DatabaseFailure toString return true results", () {
      expect(DatabaseFailure().toString(),
          "DatabaseFailure{errorMessage: $messageDataBaseFailure}");
    });

    test("make sure ConnectionFailure props return [messageDataBaseFailure]", () {
      expect(DatabaseFailure().props, [messageDataBaseFailure]);
    });
  });
}
