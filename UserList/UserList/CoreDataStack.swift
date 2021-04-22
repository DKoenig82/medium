//
//  CoreDataStack.swift
//  UserList
//
//  Created by David Koenig on 21.04.21.
//
import CoreData

public class PersistentContainer: NSPersistentContainer {}

public class CoreDataStack {

  public let persistentContainer: NSPersistentContainer

  public init() {
    persistentContainer = PersistentContainer(name: "UserList")

    persistentContainer.loadPersistentStores(completionHandler: { description, error in
      if let error = error {
        fatalError("Core Data store failed to load with error: \(error)")
      }
    })
  }
}

public extension CoreDataStack {
  func saveUser(named name: String) {
    let user = User(context: persistentContainer.viewContext)
    user.name = name

    do {
      try persistentContainer.viewContext.save()
      print("User saved succesfully")
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save movie: \(error)")
    }
  }
}

public extension CoreDataStack {
  func getAllUsers() -> [User] {
    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      print("Failed to fetch movies: \(error)")
      return []
    }
  }
}

public extension CoreDataStack {
  func deleteUser(_ user: User) {
    persistentContainer.viewContext.delete(user)

    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save context: \(error)")
    }
  }

  func updateUser(_ user: User) {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save context: \(error)")
    }
  }
}

