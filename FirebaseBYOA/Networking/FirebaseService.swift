//
//  FirebaseService.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation
import Firebase

struct FirebaseService {
    let ref = Database.database().reference()
    
    func save(fountainPen: FountainPen) {
        ref.child("pens").updateChildValues([fountainPen.uuid : fountainPen.fountainPenData])
        
    }
}
