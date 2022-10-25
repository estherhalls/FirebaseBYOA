//
//  FirebaseService.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation
import Firebase

/// May be it's own file if you want to abstract further. Must be outside of FirebaseService struct
enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

struct FirebaseService {
    
    let ref = Database.database().reference()
    
    /// Go back to model and create keys so we don't have to hard code
    func save(fountainPen: FountainPen) {
        /// UUID is what makes each entry unique, fountainPenData is what we named the unique dictionary representation of our model object on our model file
        ref.child(FountainPen.Key.collectionType).updateChildValues([fountainPen.uuid : fountainPen.fountainPenData])
    }
    
    func loadPens(completion: @escaping (Result<[FountainPen], FirebaseError>) -> Void) {
        ref.child(FountainPen.Key.collectionType).getData { error, snapshot in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            guard let data = snapshot?.value as? [String: [String:Any]] else {
                completion(.failure(.failedToUnwrapData))
                return
            }
            /// Go back to model and create failable initializer so we can use .compactMap
            let dataArray = Array(data.values)
            let pens = dataArray.compactMap({FountainPen(fromDictionary: $0)})
            completion(.success(pens))
        }
    }
}// End of Struct
