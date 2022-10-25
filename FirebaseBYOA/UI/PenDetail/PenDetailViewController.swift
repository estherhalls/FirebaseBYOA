//
//  PenDetailViewController.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import UIKit

class PenDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var penBrandNameTextField: UITextField!
    @IBOutlet weak var penNameTextField: UITextField!
    @IBOutlet weak var penNibSizeTextField: UITextField!
    @IBOutlet weak var penNibMaterialTextField: UITextField!
    
    // MARK: - Properties
    /// Dependency injection MUST be initialized
    var viewModel: PenDetailViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    // MARK: - Actions
    @IBAction func clearButtonTapped(_ sender: Any) {
        resetView()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        viewModel.deletePen()
        /// Send us back to the table view controller when the user clicks button as they are finished with this screen
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        /// Verify there is text to save
        guard let brandName = penBrandNameTextField.text,
              let penName = penNameTextField.text,
              let nibSize = penNibSizeTextField.text,
              let nibMaterial = penNibMaterialTextField.text
        else {return}

        /// Save the model object with data provided from the outlets
        viewModel.savePen(brandName: brandName, penName: penName, nibMaterial: nibMaterial, nibSize: nibSize)
        /// Send us back to the table view controller when the user clicks button as they are finished with this screen
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Helper Functions
    /// Populate the user data that was previously entered by user.
    private func updateView() {
        guard let pen = viewModel.pen else {return}
        penBrandNameTextField.text = pen.brandName
        penNameTextField.text = pen.penName
        penNibSizeTextField.text = pen.nibSize
        penNibMaterialTextField.text = pen.nibMaterial
    }
    
    private func resetView() {
        penBrandNameTextField.text = ""
        penNameTextField.text = ""
        penNibSizeTextField.text = ""
        penNibMaterialTextField.text = ""
    }
    
}
