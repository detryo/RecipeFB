//
//  DatabaseManager.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    // MARK: - Public
    
        // Check if user name is available
      /// - Parameters
      /// - email String representing email
      /// - userName String representing user name
    public func canCreateNewUser(with email: String, userName: String, complition: (Bool) -> Void) {
        // provisional
        complition(true)
    }
    
    // Insert new user data to Database
   /// - Parameters
   /// - email String representing email
   /// - userName String representing user name
   /// - completion Async callback  for result if database entry succeded
    public func inserNewUser(with email: String, userName: String, complition: @escaping (Bool) -> Void) {
        
        database.child(email.safeDatabaseKey()).setValue(["userName": userName]) { error, _ in
            
            if error == nil {
                // succeded
                complition(true)
                return
            } else {
                // failed
                complition(false)
                return
            }
        }
    }
}
