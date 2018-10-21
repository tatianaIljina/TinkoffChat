//
//  OperationDataManager.swift
//  UI
//
//  Created by Татьяна Ильина on 21.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit

class OperationDataManager: DataManager {
    
    var profile: [String : String]?
    
//    func loadFromFile(profile: [String : String]?) {
//        let loadFromFileOperation = LoadFromFile()
//        loadFromFileOperation.queuePriority = .normal
//        loadFromFileOperation.completionBlock = {
//        }
//        OperationQueue().addOperation(loadFromFileOperation)
//    }

    
    
    func saveProfile(name: String, info: String) {
        profile = ["name": name, "info": info]
        let saveOperation = SaveOperation()
        saveOperation.queuePriority = .normal
        saveOperation.profile = self.profile
        OperationQueue().addOperation(saveOperation)
    }
    
}

class SaveOperation: Operation {
    
    let dataFile = "profile.txt"
    var profile: [String : String]?
    
    override func main() {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directory.appendingPathComponent(self.dataFile)            
            do {
                if let profile = profile {
                    let saveDataFile = try JSONSerialization.data(withJSONObject: profile, options: .init(rawValue: 0))
                    try saveDataFile.write(to: fileURL)
                }
            } catch {
                print (error)
            }
        }
    }
}

//class LoadFromFile: Operation {
//
//    let dataFile = "profile.txt"
//    var profile: [String : String]?
//
//    override func main() {
//        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = directory.appendingPathComponent(self.dataFile)
//
//            do {
//                let profile = try Data(contentsOf: fileURL)
//                let saveDataFile = try JSONSerialization.jsonObject(with: profile, options: .mutableLeaves)
//                if let json = saveDataFile as? Dictionary<String, String> {
//                    self.profile = json
//                }
//            } catch {
//                self.profile = nil
//            }
//
//        }
//    }
//
//}
