//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Isaac Loez on 10/09/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    }
extension DatabaseManager{
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard  snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
            
        })
        
        
    }
    
}
// MARK: - Manejo de cuenta
extension DatabaseManager {
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAdress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}
    
//Almacenamos en un JSON los datos
struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAdress: String
    
}


