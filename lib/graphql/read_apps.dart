import 'package:graphql/client.dart';

import 'package:marketplace/graphql/client.dart';
import 'package:marketplace/models/app.dart';

const appFieldsFragment = '''
  fragment AppFieldsFragment on apps {
    id
    name
    description
    created_at
    updated_at
  }
''';

const appCategoriesFragment = '''
  fragment AppCategoriesFragment on apps {
    app_categories {
      category {
        id
        name
      }
    }
  }
''';

Future<Iterable<AppModel>> readApps() async {
  final GraphQLClient _client = getGraphQLClient();

  const int maxAppCount = 50;

  final QueryOptions options = QueryOptions(
    document: gql('''
        query ReadApps(\$limit: Int!) {
          apps_aggregate(limit: \$limit) {
            aggregate {
              count
            }
            nodes {
              ... AppFieldsFragment
              ... AppCategoriesFragment
            }
          }
        }
        $appFieldsFragment
        $appCategoriesFragment
      '''),
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
