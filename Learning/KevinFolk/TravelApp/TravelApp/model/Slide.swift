//
//  Slide.swift
//  TravelApp
//
//  Created by David Vasquez on 3/4/24.
//

import Foundation

struct Slide {
    let imageName: String
    let title: String
    let description: String
    
    
    static let collection: [Slide] = [
        Slide(imageName: "imSlide1", title: "Moonlight", description: "Moonlight drowns out all but the brightest stars."),
        Slide(imageName: "imSlide2", title: "Roads", description: "Roads go ever ever on, Over rock and under tree,"),
        Slide(imageName: "imSlide3", title: "title", description: "Roads")
    ]
}
