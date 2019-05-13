# Install

```ruby
pod 'GraphQL-Swift'
```

# Concept

This library is supposed to be simple. It was inspired by a really simple NPM module called [`graphql-client`](https://www.npmjs.com/package/graphql-client)

This library does not use any other dependencies and focuses on a protocol-oriented architecture. Right now, you can only make Queries and Mutations. Hopefully add subscriptions soon.

# Connecting

To connect to your GraphQL endpoint you need to initalize a `GQLNetworkController`. The initalizer takes an object that conforms to the `GQLAPIDefinition` protocol. By default the `GQLNetworkController` uses a `URLSession` configured to be ephemeral.

When constructing your `GQLAPIDefinition` object you can optionally add an object that conforms to `GQLAuthorization`. From there you can configure your "Authorization" header. So something like this...

```swift
struct MockGQLAuthorization: GQLAuthorization {
    //MARK: Properties
    var clientID: String?
    
    var apiKey: String?
    
    var jwt: String?
    
    var authorizationHeader: [String : String] {
        return ["Authorization": "Bearer \(self.jwt ?? self.apiKey ?? self.clientID ?? "")"]
    }
    
    //MARK: init
    init() {
        
    }
}

struct MockAPIDefinition: GQLAPIDefinition {
    //MARK: Properties
    var authorization: GQLAuthorization?
    
    var rootRESTURLString: String = "https://mockgraphqlapi.com"
    
    var rootWebsocketURLString: String = "wss://mockgraphqlapi.com"
    
    //MARK: init
    init(authorization: GQLAuthorization? = nil) {
        self.authorization = authorization
    }
}

let mockAuth = MockGQLAuthorization()

let mockAPI =  MockAPIDefinition(authorization: mockAuth)

let networkController = GQLNetworkController(apiDefinition: mockAPI)

```

# Query

To make a query or mutation you have to create an object that conforms to `GQLRequest`. Both the `GQLQuery` and `GQLMutation` protocols inherit from `GQLRequest`. Here is a basic query object.

```swift
struct UserQuery: GQLRequest {

    var graphQLLiteral: String = """
    query {
        user {
            id
            email
            name
        }
    }
    """
    
    var fragments: [GQLFragment]?
    
    var variables: [String : Any]?
    
    init() {
        
    }
    
}
```

And you would make the request like this.

```swift

let userQuery = UserQuery()

do {
    let dataTask = try networkController.makeGraphQLRequest(userQuery, completion: { (p_results, p_error) in
            if let error = p_error {
                //Any networking error
            }else if let results = p_results {
                do {
                    let users = try results.parseArrayResults(queryKey: "user")
                    print(users)
                }catch{
                    //Any parsing errors
                }
            }
        })
}catch{
    //Any errors that were thrown before the request was made.
}

```

# Fragments