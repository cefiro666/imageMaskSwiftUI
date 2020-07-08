//
//  SpinnerView.swift
//  ImageMask
//
//  Created by Виталий Баник on 03.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - SpinnerView
struct SpinnerView: NSViewRepresentable {
    
// MARK: - Methods
    func makeNSView(context: NSViewRepresentableContext<SpinnerView>) -> NSView {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6968910531).cgColor
        
        let spinner = NSProgressIndicator()
        spinner.style = .spinning
        spinner.startAnimation(nil)
        
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<SpinnerView>) {
    }
}
