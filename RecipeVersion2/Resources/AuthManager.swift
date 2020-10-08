//
//  AuthManager.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    public func registerNewUser(userName: String, email: String, password: String, complition: @escaping (Bool) -> Void) {
        
        // Check if user name is available
        DatabaseManager.shared.canCreateNewUser(with: email, userName: userName) { canCreate in
            
            if canCreate {
                // Create Account
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    
                    guard error == nil, result != nil else {
                        // Firebase auth couldn't create an account
                        complition(false)
                        return
                    }
                    // Insert Account to database
                    DatabaseManager.shared.insertNewUser(with: email, userName: userName) { inserted in
                        
                        if inserted {
                            complition(true)
                            return
                        } else {
                            // Failed to insert database
                            complition(false)
                            return
                        }
                    }
                }
            } else {
                // either user name or email doesn't exist
                complition(false)
            }
        }
        // Check if email is available
    }
    
    public func loginUser(userName: String?, email: String?, password: String, complition: @escaping (Bool) -> Void) {
        
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    complition(false)
                    return
                }
                complition(true)
            }
        } else if let userName = userName {
            // userName log in
            print(userName)
        }
    }
    // Attempt to Log Out Firebase User
    public func logOut(complition: (Bool) -> Void) {
        
        do {
            
            try Auth.auth().signOut()
            complition(true)
            return
            
        } catch {
            
            debugPrint(error.localizedDescription)
            complition(false)
            return
        }
    }
}
