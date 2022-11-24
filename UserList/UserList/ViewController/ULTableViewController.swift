//
//  ULTableViewController.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import UIKit

class ULTableViewController: UITableViewController {

    let viewModel = ULViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configureData {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ULTableViewCell.classString, for: indexPath) as! ULTableViewCell
        cell.configureData(with: viewModel.getUser(at: indexPath))

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
