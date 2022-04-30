//
//  TableViewController.swift
//  PlistTestApp
//
//  Created by Paul Matar on 29/04/2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var scheme: [Item] = []
    private var data: [Person] = []
    private var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ViewController else { return }
        vc.person = sender as? Person
        vc.scheme = scheme
        vc.index = index
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let person = data[indexPath.row]
        
        cell.configure(with: scheme)
        cell.configure(with: person)
        cell.didDelete = { [unowned self] in
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            StorageManager.shared.delete(at: indexPath.row)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = data[indexPath.row]
        index = indexPath.row
        performSegue(withIdentifier: "toVC", sender: person)
    }

}

// MARK: - Private Methods

extension TableViewController {
    
    private func fetchData() {
        let plist = StorageManager.shared.fetchPlist()
        scheme = plist.scheme
        data = plist.data
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftItemsSupplementBackButton = false
        navigationItem.backButtonTitle = "Назад"
    }
}
