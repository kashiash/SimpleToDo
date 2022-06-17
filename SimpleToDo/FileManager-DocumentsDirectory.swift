//
//  FileManager-DocumentsDirectory.swift
//  SimpleToDo
//
//  Created by Jacek on 17/06/2022.
//

import Foundation
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
