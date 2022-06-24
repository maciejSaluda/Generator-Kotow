//
//  ColorModel.swift
//  testapp
//
//  Created by Maciej Sałuda on 23/06/2022.
//

import Foundation
import UIKit

enum ColorModel: CaseIterable {
    case black
    case red
    case green
    
    func title() -> String {
        switch self {
        case .black:
            return "czarny"
        case .red:
            return "czerwony"
        case .green:
            return "zielony"
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .black:
            return .black
        case .red:
            return .red
        case .green:
            return .green
        }
    }
}
