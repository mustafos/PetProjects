//
//  PathProvider.swift
//  Facade
//
//  Created by Mustafa Bekirov on 19.02.2023.
//

import Foundation

class PathProvider {
    func createDestinationPath(fileName: String) throws -> URL {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.couldNotCreateDestinationPath
        }
        let destinationPath = path.appendingPathComponent("\(fileName)")
        print(destinationPath)
        return destinationPath
    }
}
