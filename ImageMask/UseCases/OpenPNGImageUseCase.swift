//
//  OpenPNGImageUseCase.swift
//  ImageMask
//
//  Created by Виталий Баник on 05.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import Combine
import SwiftUI

protocol GetImageUseCase {
    
    func execute(_ completionHandler: (_ success: Bool, _ image: NSImage?, _ path: URL?, _ error: String?) -> ())
}

class OpenPNGImageUseCase: GetImageUseCase {
    
    func execute(_ completionHandler: (_ success: Bool, _ image: NSImage?, _ path: URL?, _ error: String?) -> ()) {
        let openPanel = NSOpenPanel()
        let filesTypes = ["png"]
        openPanel.allowedFileTypes = filesTypes
        let result = openPanel.runModal()
        
        switch result {
        case .OK:
            if let urlPath = openPanel.url,
                let pngImage = NSImage(contentsOf: urlPath) {
            
                completionHandler(true, pngImage, urlPath, nil)
            }
                
        case .cancel:
            completionHandler(true, nil, nil, nil)
            
        default:
            completionHandler(false, nil, nil, "Could not open file")
        }
    }
}
