//
//  ProcessImageView.swift
//  ImageMask
//
//  Created by Виталий Баник on 02.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - ProcessImageView
struct ProcessImageView: View {
    
// MARK: - View model
    @ObservedObject var viewModel: ProcessImageViewModel
    
// MARK: - Body
    var body: some View {
        VStack(spacing: .zero) {
            Text("Select the desired PNG image for processing")
                .padding(10)
            
            Spacer()
            
            ImageView(image: self.viewModel.image,
                      processingState: self.viewModel.processingState)
            
            ControlPanelView(viewModel: self.viewModel)
        }
    }
}

// MARK: - Prewiew
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessImageView(viewModel: ProcessImageViewModel(configType: .processMaskFileLocalPNG))
    }
}
