//
//  ProcessingStateText.swift
//  ImageMask
//
//  Created by Виталий Баник on 03.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - ProcessingStateText
struct ProcessingStateText: View {
    
// MARK: - Properties
    var state: ProcessingState
    
// MARK: - Body
    var body: some View {
        self.getTextForState(state)
    }
    
// MARK: - Methods
    private func getTextForState(_ state: ProcessingState) -> some View {
        switch state {
        case .done:
            return Text("Done!").foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
            
        case .ready:
            return Text("")
            
        case .processing:
            return Text("Processing...").foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
            
        case .error(let error):
            return Text("Error!\n\(error ?? "")").foregroundColor(Color(#colorLiteral(red: 0.6980392157, green: 0.06274509804, blue: 0.2549019608, alpha: 1)))
        }
    }
}
