import 'package:graphql/client.dart';

/// TODO: get token and url from a file, eg. lib/local.dart with:
/// ```dart
/// const String YOUR_PERSONAL_ACCESS_TOKEN =
///    '<YOUR_PERSONAL_ACCESS_TOKEN>';
/// ```
///
/// import '../local.dart';

GraphQLClient getGraphQLClient() {
  final Link _link = HttpLink(
    'http://localhost:8080/v1/graphql',
    defaultHeaders: {
      'Authorization': 'Bearer token',
    },
  );

  return GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );
}