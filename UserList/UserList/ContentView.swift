//
//  ContentView.swift
//  UserList
//
//  Created by David Koenig on 21.04.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDataStack: CoreDataStack
    
    @State var userName = ""
    @State var users : [User] = []
    
    var body: some View {
        VStack {
            Text("Add a user")
                .font(.title)
                .padding()
            
            HStack {
                TextField("Type user name", text: $userName)
                
                Button("Save user") {
                    coreDataStack.saveUser(named: userName)
                    users = coreDataStack.getAllUsers()
                }
                
                Spacer()
                
            }.padding()
            
            List {
                ForEach(users) { (user: User) in
                    Text(user.name ?? "")
                }.onDelete { rows in
                    for row in rows {
                        let user = users[row]
                        coreDataStack.deleteUser(user)
                    }
                    
                    users.remove(atOffsets: rows)
                }
            }.onAppear {
                users = coreDataStack.getAllUsers()
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDataStack: CoreDataStack())
    }
}
