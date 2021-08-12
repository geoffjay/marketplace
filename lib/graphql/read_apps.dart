import 'dart:io' show stdout, stderr, exit;

import 'package:graphql/client.dart';

import 'client.dart';

void readRepositories() async {
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
    stderr.writeln(result.exception.toString());
    exit(2);
  }

  final List<dynamic> apps =
  result.data!['apps_aggregate']['nodes'] as List<dynamic>;

  apps.forEach(
    (dynamic f) => {stdout.writeln('Id: ${f['id']} Name: ${f['name']}')},
  );

  exit(0);
}