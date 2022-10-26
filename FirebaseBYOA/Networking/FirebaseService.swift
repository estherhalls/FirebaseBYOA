//
//  FirebaseService.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation
import FirebaseFirestore

/// May be it's own file if you want to abstract further. Must be outside of FirebaseService struct
enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}
/// Makes data SOLID rather than a concrete type - Dependency Inversion
protocol FirebaseSyncable {
    func save(_ fountainPen: FountainPen)
    func loadPens(completion: @escaping (Result<[FountainPen], FirebaseError>) -> Void)
    func delete(_ fountainPen: FountainPen)
}

struct FirebaseService: FirebaseSyncable {
    
    let ref = Firestore.firestore()
    
    /// Go back to model and create keys so we don't have to hard code
    func save(_ fountainPen: FountainPen) {
        /// UUID is what makes each entry unique, fountainPenData is what we named the unique dictionary representation of our model object on our model file
        ref.collection(FountainPen.Key.collectionType).document(fountainPen.uuid).setData(fountainPen.fountainPenData)
    }
    
    func loadPens(completion: @escaping (Result<[FountainPen], FirebaseError>) -> Void) {
        ref.collection(FountainPen.Key.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            guard let data = snapshot?.documents else {
                completion(.failure(.failedToUnwrapData))
                return
            }
            /// Go back to model and create failable initializer so we can use .compactMap
            let dataArray = data.compactMap ({ $0.data()})
            let pens = dataArray.compactMap({FountainPen(fromDictionary: $0)})
            let sortedPens = pens.sorted(by: {$0.entryDate > $1.entryDate})
            completion(.success(pens))
        }
    }
    
    func delete(_ fountainPen: FountainPen) {
        ref.collection(FountainPen.Key.collectionType).document(fountainPen.uuid).delete()
    }
    
} // End of Struct
