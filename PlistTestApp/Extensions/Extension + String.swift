//
//  Extension + String.swift
//  PlistTestApp
//
//  Created by Paul Matar on 30/04/2022.
//
import Foundation

extension String {
    func isValid(_ required: Bool, with type: String) -> Bool {
        let orEmpty = required ? "" : "|"
        let format = "SELF MATCHES %@"
        var regex = "[^!]\(orEmpty)"
        
        switch type {
        case "name": regex = "[А-Я][а-я]{1,18}\(orEmpty)"
        case "lastName": regex = "[А-Я][а-я]{1,18}\(orEmpty)"
        case "birthdate": regex = "[0-9]{1,2}[.][0-9]{1,2}[.][0-9]{4}\(orEmpty)"
        case "childrenCount": regex = "[0-9]{0,2}\(orEmpty)"
        default: break
        }
        
        return NSPredicate(format: format, regex)
            .evaluate(with: self.trimmingCharacters(in: .whitespaces))
    }
}
