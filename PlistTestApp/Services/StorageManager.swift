//
//  StorageManager.swift
//  PlistTestApp
//
//  Created by Paul Matar on 29/04/2022.
//
import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private var plistURL: URL
    
    func fetchPlist() -> Plist {
        guard let data = try? Data(contentsOf: plistURL) else {
            return Plist(scheme: [], data: [])
        }
        
        do {
            let plistData = try PropertyListDecoder().decode(Plist.self, from: data)
            return plistData
            
        } catch {
            print(error)
            return Plist(scheme: [], data: [])
        }
    }
    
    func save(person: Person?, at index: Int?) {
        guard let person = person else { return }
        guard let index = index else { return }

        var plist = fetchPlist()
        plist.data[index] = person
        
        do {
            let data = try PropertyListEncoder().encode(plist)
            try data.write(to: plistURL, options: .noFileProtection)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(at index: Int) {
        var plist = fetchPlist()
        plist.data.remove(at: index)
        
        do {
            let data = try PropertyListEncoder().encode(plist)
            try data.write(to: plistURL, options: .noFileProtection)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        if let path = path {
            plistURL = path.appendingPathComponent("input").appendingPathExtension("plist")
        } else {
            plistURL = URL(fileURLWithPath: "")
        }
        print(plistURL)
    }
    

}
