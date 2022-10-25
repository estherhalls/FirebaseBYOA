//
//  FountainPen.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation

class FountainPen: Codable {
    
    // MARK: - Keys
    enum Key {
        static let collectionType = "pens"
        static let penName = "pen_name"
        static let brandName = "brand_name"
        static let nibMaterial = "nib_material"
        static let nibSize = "nib_size"
        static let uuid = "uuid"
    }
    
    // MARK: - Properties
    var penName: String
    var brandName: String
    var nibMaterial: String
    var nibSize: String
    let uuid: String
    
    // Dictionary Representation of Model Object
    /// Used as value for child dictionary in save fountain pen function on FirebaseService file
    var fountainPenData: [String:AnyHashable] {
        [Key.penName : self.penName,
         Key.brandName : self.brandName,
         Key.nibMaterial : self.nibMaterial,
         Key.nibSize : self.nibSize,
         Key.uuid : self.uuid
        ]
    }
    
    // MARK: - Designated Initializer
    init(penName: String, brandName: String, nibMaterial: String, nibSize: String, uuid: String = UUID().uuidString) {
        self.penName = penName
        self.brandName = brandName
        self.nibMaterial = nibMaterial
        self.nibSize = nibSize
        self.uuid = uuid
    }
    
} // End of Class

// MARK: - Optional (Failable) Initializer Extension
///Allows us to use .compactMap for-in loop on FirebaseService
extension FountainPen {
    convenience init?(fromDictionary dictionary: [String:Any]) {
        guard let penName = dictionary[Key.penName] as? String,
              let brandName = dictionary[Key.brandName] as? String,
              let nibMaterial = dictionary[Key.nibMaterial] as? String,
              let nibSize = dictionary[Key.nibSize] as? String,
              let uuid = dictionary[Key.uuid] as? String
        else {return nil}
        
        self.init(penName: penName, brandName: brandName, nibMaterial: nibMaterial, nibSize: nibSize, uuid: uuid)
    }
}
/// Allows us to individually identify cells to select and delete
extension FountainPen: Equatable {
    static func == (lhs: FountainPen, rhs: FountainPen) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
