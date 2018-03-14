//
//  UIImage+SVG.swift
//  Drjoy
//
//  Created by Long Lee on 8/17/17.
//  Copyright © 2017 Dr.JOY No,054. All rights reserved.
//

import UIKit
import SVGKit

extension UIImage {
    class func SVG(_ svgName: String, size: CGSize = .zero) -> UIImage {
        var nameImage: String = svgName
        if !svgName.contains(".svg") {
            nameImage.append(".svg")
        }
        
        // Load SVG image
        let svgImage = SVGKImage(named: nameImage, in: Bundle.main)
       
        // Set size for image
        if size != .zero {
             svgImage?.scaleToFit(inside: size)
        }
        return svgImage?.uiImage ?? UIImage()
    }
}
