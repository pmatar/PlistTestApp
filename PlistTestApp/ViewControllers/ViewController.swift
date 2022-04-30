//
//  ViewController.swift
//  PlistTestApp
//
//  Created by Paul Matar on 29/04/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var birthDateLbl: UILabel!
    @IBOutlet weak var childrenCountLbl: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var childrenCountTF: UITextField!
    
    var person: Person?
    var index: Int?
    var scheme: [Item] = []
    
    private var nameItemVC: Item?
    private var lastNameItemVC: Item?
    private var birthDateItemVC: Item?
    private var childrenCountItemVC: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: scheme)
        nameTF.text = person?.name
        lastNameTF.text = person?.lastName
        birthDateTF.text = person?.birthdate
        childrenCountTF.text = person?.childrenCount
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private Methods

    private func configure(with items: [Item]) {
        for item in items {
            if nameItemVC == nil {
                nameItemVC = item
                nameLbl.text = nameItemVC?.title
            } else if lastNameItemVC == nil {
                lastNameItemVC = item
                lastNameLbl.text = lastNameItemVC?.title
            } else if birthDateItemVC == nil {
                birthDateItemVC = item
                birthDateLbl.text = birthDateItemVC?.title
            } else if childrenCountItemVC == nil {
                childrenCountItemVC = item
                childrenCountLbl.text = childrenCountItemVC?.title
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        guard let nameText = nameTF.text,
              let lastNameText = lastNameTF.text,
              let birthDateText = birthDateTF.text,
              let childrenCountText = childrenCountTF.text else { return }
        
        guard nameText.isValid(nameItemVC?.required ?? true,
                               with: nameItemVC?.id ?? "") else {
            print("name is not valid")
            nameLbl.textColor = .red
            nameTF.textColor = .red
            return }
        guard lastNameText.isValid(lastNameItemVC?.required ?? true,
                                   with: lastNameItemVC?.id ?? "") else {
            print("lastName is not valid")
            lastNameLbl.textColor = .red
            lastNameTF.textColor = .red
            return }
        guard birthDateText.isValid(birthDateItemVC?.required ?? true,
                                    with: birthDateItemVC?.id ?? "") else {
            print("birthDate is not valid")
            birthDateLbl.textColor = .red
            birthDateTF.textColor = .red
            return }
        guard childrenCountText.isValid(childrenCountItemVC?.required ?? true,
                                        with: childrenCountItemVC?.id ?? "") else {
            print("childrenCount is not valid")
            childrenCountLbl.textColor = .red
            childrenCountTF.textColor = .red
            return }
        
        person?.name = nameText
        person?.lastName = lastNameText
        person?.birthdate = birthDateText
        person?.childrenCount = childrenCountText
        
        StorageManager.shared.save(person: person, at: index)
        navigationController?.popViewController(animated: true)
    }
}
