//
//  PenListViewModel.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import Foundation
protocol PenListViewModelDelegate: AnyObject {
    func pensLoadedSuccessfully()
}

class PenListViewModel {
    /// Access Pen Objects
    var pens: [FountainPen] = []
    
    /// Delegate declaration
    private weak var delegate: PenListViewModelDelegate?
    
    /// Access FirebaseService file to control the model object state
    /// Accessing via proto ol rather than struct to make the data SOLID and not concrete. Dependence Inversion - rely on abstractions rather than concretions
    private var service: FirebaseSyncable
    /// Initialize firebase service
    init(delegate: PenListViewModelDelegate, service: FirebaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func loadData() {
        service.loadPens { [weak self] result in
            switch result {
            case .success(let pens):
                self?.pens = pens
                self?.delegate?.pensLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(index:Int) {
        let pen = pens[index]
        service.delete(pen)
        self.pens.remove(at: index)
    }
    
} // End of Class
