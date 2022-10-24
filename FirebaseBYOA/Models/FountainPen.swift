//
//  FountainPen.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation

class FountainPen: Codable {
    // MARK: - Properties
    var penName: String
    var brandName: String
    var nibMaterial: String
    var nibSize: String
    let uuid: String
    let isFavorite: Bool
    
    // Dictionary Representation of Model Object
    var fountainPenData: [String:AnyHashable] {
        ["penName":self.penName,
         "brandName":self.brandName,
         "nibMaterial":self.nibMaterial,
         "nibSize":self.nibSize,
         "uuid":self.uuid,
         "isFavorite":self.isFavorite
         ]
    }
    
    // MARK: - Initializer
    init(penName: String, brandName: String, nibMaterial: String, nibSize: String, uuid: String = UUID().uuidString, isFavorite: Bool = false) {
        self.penName = penName
        self.brandName = brandName
        self.nibMaterial = nibMaterial
        self.nibSize = nibSize
        self.uuid = uuid
        self.isFavorite = isFavorite
    }
    
} // End of Class

extension FountainPen: Equatable {
    static func == (lhs: FountainPen, rhs: FountainPen) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
