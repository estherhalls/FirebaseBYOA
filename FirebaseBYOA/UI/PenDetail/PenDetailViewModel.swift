//
//  PenDetailViewModel.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation

class PenDetailViewModel {
    /// Access Model Data
    var pen: FountainPen?
    private let firebaseService: FirebaseService
    
    // Dependency Injection
    /// We need to have save function from firebase service in order for data to exist on our database via the view model
    /// Model object is optional because they may be creating a new pen from scratch of updating an existing pen object
    init(pen: FountainPen? = nil, firebaseService: FirebaseService = FirebaseService()) {
        self.pen = pen
        self.firebaseService = firebaseService
    }
    
    /// Properties in function are only the ones from the model of which we want user to be able to interact
    func savePen(brandName: String, penName: String, nibMaterial: String, nibSize: String) {
        if pen != nil {
            updatePen(brandName: brandName, penName: penName, nibMaterial: nibMaterial, nibSize: nibSize)
        } else {
          let newPen = FountainPen(penName: penName, brandName: brandName, nibMaterial: nibMaterial, nibSize: nibSize)
            firebaseService.save(newPen)
        }
    }
    
    func updatePen(brandName: String, penName: String, nibMaterial: String, nibSize:String){
        guard let pen = pen else {return}
        pen.brandName = brandName
        pen.penName = penName
        pen.nibMaterial = nibMaterial
        pen.nibSize = nibSize
        firebaseService.save(pen)
    }
    
    
} // End of Class
