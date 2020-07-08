//
//  ProcessImageViewModelConfigType.swift
//  ImageMask
//
//  Created by Виталий Баник on 05.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import Foundation

// MARK: - ProcessImageViewModelConfigType
enum ProcessImageViewModelConfigType {
    
    case processMaskFileLocalPNG
    
// MARK: - getImageUseCase
    var getImageUseCase: GetImageUseCase {
        switch self {
        case .processMaskFileLocalPNG:
            return OpenPNGImageUseCase()
        }
    }
    
// MARK: - processImageUseCase
    var processImageUseCase: ProcessImageUseCase {
        switch self {
        case .processMaskFileLocalPNG:
            return ProcessPNGImageMaskUseCase()
        }
    }
    
// MARK: - saveImageMaskUseCase
    var saveImageMaskUseCase: SaveImageMaskUseCase {
        switch self {
        case .processMaskFileLocalPNG:
            return SavePNGMaskFileUseCase()
        }
    }
    
}
