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
struct UserQuery: GQLQuery {

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
                    let users = try results.parseArrayResults(fieldKey: "user")
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

You can define a fragment by conforming to the `GQLFragment` protocol.

Here we can refactor our original `UserQuery` to contain a fragment.

```swift
struct UserDetails: GQLFragment {
     let fragmentLiteral = """
     fragment UserDetails on user {
        id
        name
        email
     }
     """
}

struct UserQuery: GQLQuery {

    var graphQLLiteral: String = """
    query {
        user {
            ...UserDetails
        }
    }
    """
    
    var fragments: [GQLFragment]? = [UserDetails()]
    
    var variables: [String : Any]?
    
    init() {
        
    }
    
}
```

# Variables

Finally we can pass variables into the query like this.

```swift
struct UserQuery: GQLQuery {

    var graphQLLiteral: String = """
    query UserByEmail($email: String!){
        user(where: {email: {_eq: $email}}, limit: 1) {
            ...UserDetails
        }
    }
    """
    
    var fragments: [GQLFragment]? = [UserDetails()]
    
    var variables: [String : Any]?
    
    init(email: String) {
        self.variables = ["email": email]
    }
    
}
```

# GraphQL JSON Parsing

The general format of JSON that comes back from a GraphQL request can be [read about here](https://medium.com/@joninsky/parsing-json-from-a-graphql-response-854e8a29afef).

The responses from the `.makeGraphQLRequest` function will be the unfilterd or parsed JSON from the request. Since JSON from a GraphQL request does follow some rhyme and reason this library contains some extensions on swift dictionaries to get you started.

1) Pase the data key.

All requests return a dictionary with a data key. Parse that like this:

```swift
do {
    let dataTask = try networkController.makeGraphQLRequest(userQuery, completion: { (p_results, p_error) in
            if let error = p_error {
                //Any networking error
            }else if let results = p_results {
                do {
                    let dataResults = try results.parseDataKey()
                    print(dataResults)
                }catch{
                    //Any parsing errors
                }
            }
        })
}catch{
    //Any errors that were thrown before the request was made.
}
```
2) Parse selection set from high level fields.

If you know the form of the object that comes back from any of your top level fields in your query you can get them like this.

```swift
do {
    let dataTask = try networkController.makeGraphQLRequest(userQuery, completion: { (p_results, p_error) in
            if let error = p_error {
                //Any networking error
            }else if let results = p_results {
                do {
                    //If your selection set is a dictionary
                    let users = try results.parseDictionaryResults(fieldKey: "user")
                    print(users)
                    //If your selection set is an array
                    let users = try results.parseArrayResults(fieldKey: "user")
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