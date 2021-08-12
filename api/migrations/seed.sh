#!/bin/bash

API="http://localhost:8080/v1/graphql"

__gql() {
  args=('{"query": "' "$1" '"}')
  query=$(printf '%s' "${args[@]}")
  #echo "$query"
  curl -s $API -X POST -d "$query" | jq
}

__add_category() {
  __gql 'mutation { insert_categories_one(object: {name: \"'"$1"'\"}) { id } }'
}

__add_categories() {
  __add_category "featured"
  __add_category "productivity"
  __add_category "entertainment"
}

__add_app() {
  __gql 'mutation { insert_apps_one(object: {name: \"'"$1"'\", description: \"'"$2"'\"}) { id } }'
}

__add_app_to_category() {
  read -r -d '' query <<-EOM
    mutation {
      insert_app_categories_one(object: {app_id: $1, category_id: $2}) {
        id
        app_id
        category_id
      }
    }
EOM
  __gql "$query"
}

__add_apps() {
  __add_app "good" "This is a good thing"
  __add_app "better" "This thing is better"
  __add_app "best" "This one is the best"
  # FIXME: these don't work
  __add_app_to_category 1 1
  __add_app_to_category 1 2
  __add_app_to_category 2 1
  __add_app_to_category 2 3
  __add_app_to_category 3 1
  __add_app_to_category 3 3
}

#__add_categories
#__add_apps