//
//  View+Modificators.swift
//  ImageMask
//
//  Created by Виталий Баник on 03.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

extension View {
    
    public func activityView(state: Bool) -> some View {
        return ZStack {
            self
            if state { SpinnerView() }
        }
    }
}
