//
//  SavePNGMaskFileUseCase.swift
//  ImageMask
//
//  Created by Виталий Баник on 05.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import Combine
import SwiftUI

protocol SaveImageMaskUseCase {
    
    func execute(data: String?,
                 _ completionHandler: @escaping (_ success: Bool, _ response: String?, _ error: String?) -> ())
}

class SavePNGMaskFileUseCase: SaveImageMaskUseCase {
    
    func execute(data: String?,
                 _ completionHandler: @escaping (_ success: Bool, _ response: String?, _ error: String?) -> ()) {
        
        let savePanel = NSSavePanel()
        let result = savePanel.runModal()
        
        switch result {
        case .OK:
            if let urlPath = savePanel.url,
                let urlPathString = savePanel.url?.absoluteString {
                
                FileManager.default.createFile(atPath: urlPathString, contents: Data(), attributes: nil)

                do {
                    try data?.write(to: urlPath, atomically: false, encoding: .nonLossyASCII)
                    completionHandler(true, nil, nil)
                } catch {
                    completionHandler(false, nil, "Failed to save file")
                }
            }
            
        case .cancel:
            completionHandler(true, nil, nil)
            
        default:
            completionHandler(false, nil, "Failed to save file")
        }
    }
}
