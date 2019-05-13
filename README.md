# Install

```ruby
pod 'GraphQL-Swift'
```

# Concept

This library is supposed to be simple. It was inspired by a really simple NPM module called [`graphql-client`](https://www.npmjs.com/package/graphql-client)

This library does not use any other dependencies and focuses on a protocol-oriented architecture. Right now, you can only make Queries and Mutations. Hopefully add subscriptions soon.

# Connecting

To connect to your GraphQL endpoint you need to initalize a `GQLNetworkController`. The initalizer takes an object that conforms to the `GQLAPIDefinition` protocol. By default the `GQLNetworkController` uses a `URLSession` configured to be ephemeral.

When constructing your `GQLAPIDefinition` object you can optionally add an object that conforms to `GQLAuthorization`. From there you can configure your "Authorization" header.

# Query

