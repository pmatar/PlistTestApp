//
//  TableViewCell.swift
//  PlistTestApp
//
//  Created by Paul Matar on 29/04/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    
    @IBOutlet weak var nameValueLbl: UILabel!
    @IBOutlet weak var lastNameValueLbl: UILabel!
    @IBOutlet weak var birthDateValueLbl: UILabel!
    @IBOutlet weak var childrenCountValueLbl: UILabel!
    
    var didDelete: () -> ()  = { }
    
    func configure(with items: [Item]) {
        for item in items {
            if !nameLabel.isEnabled {
                nameLabel.isEnabled = true
                nameLabel.text = item.title
            } else if !lastNameLabel.isEnabled {
                lastNameLabel.isEnabled = true
                lastNameLabel.text = item.title
            } else if !birthDateLabel.isEnabled {
                birthDateLabel.isEnabled = true
                birthDateLabel.text = item.title
            } else if !childrenCountLabel.isEnabled {
                childrenCountLabel.isEnabled = true
                childrenCountLabel.text = item.title
            }
        }
    }
    
    func configure(with person: Person) {
        
        nameValueLbl.text = person.name
        lastNameValueLbl.text = person.lastName
        birthDateValueLbl.text = person.birthdate
        childrenCountValueLbl.text = person.childrenCount
    }
    
    @IBAction func deleteButtonPressed() {
        didDelete()
    }

}
