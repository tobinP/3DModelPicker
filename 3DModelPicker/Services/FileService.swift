//
//  FileService.swift
//  3DModelPicker
//
//  Created by Tobin Pomeroy on 1/31/24.
//

import Foundation

class FileService {
    static func getAllUsdzFileNames() -> [String] {
        let filemanager =  FileManager.default

        guard let path = Bundle.main.resourcePath, 
                let files = try? filemanager.contentsOfDirectory(atPath: path)
        else {
            return []
        }

        var usdzFileNames: [String] = []
        for filename in files where filename.hasSuffix("usdz") {
            let nameWithoutFileExtension = filename.replacingOccurrences(of: ".usdz", with: "")
            usdzFileNames.append(nameWithoutFileExtension)
        }
        return usdzFileNames
    }
}
