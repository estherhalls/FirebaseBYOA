//
//  PenListTableViewController.swift
//  FirebaseBYOA
//
//  Created by Esther on 10/24/22.
//

import UIKit

class PenListTableViewController: UITableViewController {
    
    var viewModel: PenListViewModel!
    
    // MARK: - Table View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Tableview to scale cell height to its content
        tableView.rowHeight = UITableView.automaticDimension
        /// estimated height to start calculating from
        tableView.estimatedRowHeight = 60
        /// Initialize the viewModel
        viewModel = PenListViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// When the view appears from the detailVC we need to reload the tableview to see the changes.
        viewModel.loadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "penCell", for: indexPath) as? PenListTableViewCell else { return UITableViewCell() }
        /// Using the *IndexPath* from the row to find what **Log** should be displayed
        let pen = viewModel.pens[indexPath.row]
        /// Calling the configureCell method on our LogListTableViewCell
        cell.configureCell(with: pen)
        /// Passing the fully configured cell to be displayed
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Destination - Verifying the segues destination leads to the *ViewController* we want. This also allows us to access the properties on that *ViewController*
        guard let destination = segue.destination as? PenDetailViewController else {return}
        /// Identifier - We are checking to see if the identifier of our segue matches "toDetailVC". If it does then we will run the code inside, if not then we will just pass over it.
        if segue.identifier == "toDetailVC" {
            // They are accessing via the cell
            /// Index - Discovering what row the user has seleceted
            guard let index = tableView.indexPathForSelectedRow else {return}
            /// Object to send - Using the index we discovered earlier we retrieve the *Log* that matches in our *logs* array.
            let pen = viewModel.pens[index.row]
            /// Object to receive - Sets the value of the optional *log* on the *destination* to the *Log* we just retrived.
            destination.viewModel = PenDetailViewModel(pen: pen)
        } else {
            // They are NOT accessing the detailVC via the cell
            destination.viewModel = PenDetailViewModel()
        }
    }
    
} // End of Class

extension PenListTableViewController: PenListViewModelDelegate {
    func pensLoadedSuccessfully() {
        self.tableView.reloadData()
    }
}
