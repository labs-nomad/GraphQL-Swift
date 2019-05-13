//
//  GQLFragment.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// GraphQL lets you do fragments. This protocol defines what is required of a fragment. Basically just a string literal
public protocol GQLFragment {
    /**
     The literal GraphQL Fragment. It's recommended to use a swift string literal like this:
     
     let fragmentLiteral = """
     fragment Details on user {
        id
        name
        email
     }
     """
    **/
    var fragmentLiteral: String { get }
}
