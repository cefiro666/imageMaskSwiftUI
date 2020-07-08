//
//  ImageView.swift
//  ImageMask
//
//  Created by Виталий Баник on 03.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - Constants
fileprivate struct Constants {
    
    static let kMinWidthImage: CGFloat = 400
    static let kMinHeightImage: CGFloat = 301
}

// MARK: - ImageView
struct ImageView: View {
    
// MARK: - Properrties
    var image: NSImage?
    var processingState: ProcessingState
    
// MARK: - Body
    var body: some View {
        ZStack {
            Image(nsImage: self.image ?? NSImage(imageLiteralResourceName: "default"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.kMinWidthImage, height: Constants.kMinHeightImage)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                .activityView(state: self.processingState == .processing)
        }
        .frame(width: Constants.kMinWidthImage, height: Constants.kMinHeightImage)
        .cornerRadius(5)
    }
}

// MARK: - Preview
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: NSImage(imageLiteralResourceName: "default"), processingState: .ready)
    }
}
