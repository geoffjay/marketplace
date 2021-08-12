import 'package:graphql/client.dart';

import '../app.dart';
import 'client.dart';

Future<Iterable<AppModel>> readApps() async {
  final GraphQLClient _client = getGraphQLClient();

  const int maxAppCount = 50;

  final QueryOptions options = QueryOptions(
    document: gql(
      r'''
        query ReadApps($limit: Int!) {
          apps_aggregate(limit: $limit) {
            aggregate {
              count
            }
            nodes {
              id
              name
              description
              created_at
              updated_at
            }
          }
        }
      ''',
    ),
    variables: {
      'limit': maxAppCount,
    },
  );

  final QueryResult result = await _client.query(options);

  if (result.hasException) {
    throw (result.exception.toString());
  }

  final List<dynamic> nodes =
      result.data!['apps_aggregate']['nodes'] as List<dynamic>;

  return nodes.map((node) => AppModel.fromJson(node));
}
