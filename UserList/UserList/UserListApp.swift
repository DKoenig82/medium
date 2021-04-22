//
//  UserListApp.swift
//  UserList
//
//  Created by David Koenig on 21.04.21.
//

import SwiftUI

@main
struct UserListApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDataStack: CoreDataStack())
        }
    }
}
