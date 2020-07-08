//
//  ProcessImageViewModel.swift
//  ImageMask
//
//  Created by Виталий Баник on 02.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - ProcessingState
enum ProcessingState: Equatable, Error {
    
    case ready
    case processing
    case done
    case error(String?)
}

// MARK: - ProcessImageViewModel
final class ProcessImageViewModel: ObservableObject {
    
// MARK: - Published propeties
    @Published var image: NSImage?
    @Published var processingState: ProcessingState = .ready
    
// MARK: - Private propeties
    private var imageUrlPath: URL?
    
// MARK: - Use cases
    private var getImageUseCase: GetImageUseCase?
    private var processImageUseCase: ProcessImageUseCase?
    private var saveImageMaskUseCase: SaveImageMaskUseCase?
    
// MARK: - Init
    init(configType: ProcessImageViewModelConfigType) {
        self.getImageUseCase = configType.getImageUseCase
        self.processImageUseCase = configType.processImageUseCase
        self.saveImageMaskUseCase = configType.saveImageMaskUseCase
    }
    
// MARK: - Methods
    func openImage() {
        self.getImageUseCase?.execute { [weak self] (success, image, path, error) in
            guard success else {
                self?.processingState = .error(error)
                return
            }
            
            self?.image = image
            self?.imageUrlPath = path
        }
    }
    
    func createMask() {
        self.processingState = .processing
        
        self.processImageUseCase?.execute(imageUrlPath: self.imageUrlPath,
                                          { [weak self] (success, data, error) in
            guard success else {
                self?.processingState = .error(error)
                return
            }
            
            self?.processingState = .done
            self?.saveMaskFileWithData(data)
        })
    }
    
    private func saveMaskFileWithData(_ data: String?) {
        self.saveImageMaskUseCase?.execute(data: data,
                                           { [weak self] (success, response, error) in
            guard success else {
                self?.processingState = .error(error)
                return
            }
            
            self?.image = nil
            self?.processingState = .ready
        })
    }
    
}
