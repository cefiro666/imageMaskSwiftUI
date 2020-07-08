//
//  ControlPanelView.swift
//  ImageMask
//
//  Created by Виталий Баник on 03.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - ControlPanelView
struct ControlPanelView: View {
    
// MARK: - ViewModel
    @ObservedObject var viewModel: ProcessImageViewModel
    
// MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Spacer()
            
            Button(action: {
                self.viewModel.openImage()
            }) {
                Text("Open png image")
            }.disabled(self.viewModel.processingState == .processing)
            
            ProcessingStateText(state: self.viewModel.processingState)
                .frame(minWidth: 150, minHeight: 35)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            Button(action: {
                self.viewModel.createMask()
            }) {
                Text("Create mask file")
            }.disabled(self.viewModel.processingState == .processing || self.viewModel.image == nil)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview
struct ControlPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanelView(viewModel: ProcessImageViewModel(configType: .processMaskFileLocalPNG))
    }
}
