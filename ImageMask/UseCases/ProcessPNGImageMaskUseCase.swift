//
//  ProcessPNGImageMaskUseCase.swift
//  ImageMask
//
//  Created by Виталий Баник on 05.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import Combine
import Foundation

protocol ProcessImageUseCase {
    
    func execute(imageUrlPath: URL?,
                 _ completionHandler: @escaping (_ success: Bool, _ data: String?, _ error: String?) -> ())
}

class ProcessPNGImageMaskUseCase: ProcessImageUseCase {
    
    func execute(imageUrlPath: URL?,
                 _ completionHandler: @escaping (_ success: Bool, _ data: String?, _ error: String?) -> ()) {
        
        DispatchQueue.global(qos: .utility).async {
            guard let file = imageUrlPath?.withUnsafeFileSystemRepresentation( { fopen($0, "r") }) else {
                completionHandler(false, nil, "Processing error")
                return
            }
            
            read_png_file(file)
            fclose(file)

            let count = 300_000
            let pointer = UnsafeMutablePointer<CChar>.allocate(capacity: count)
            pointer.initialize(repeating: 0, count: count)
            
            let result = process_png_file(pointer)
            
            DispatchQueue.main.async {
                if result > .zero {
                    completionHandler(true, String(cString: pointer), nil)
                } else {
                    completionHandler(false, nil, "Processing error")
                }
                
                pointer.deinitialize(count: count)
                pointer.deallocate()
                freeMemory()
            }
        }
    }
}
