import 'package:graphql/client.dart';

import 'package:marketplace/models/category.dart';
import 'package:marketplace/graphql/client.dart';

Future<Iterable<CategoryModel>> readCategories() async {
  final GraphQLClient _client = getGraphQLClient();

  const int maxAppCount = 50;

  final QueryOptions options = QueryOptions(
    document: gql(r'''
        query ReadCategories($limit: Int!) {
          categories_aggregate(limit: $limit) {
            aggregate {
              count
            }
            nodes {
              id
              name
            }
          }
        }
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
      result.data!['categories_aggregate']['nodes'] as List<dynamic>;

  return nodes.map((node) => CategoryModel.fromJson(node));
}
