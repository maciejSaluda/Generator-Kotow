//
//  FilterModel.swift
//  testapp
//
//  Created by Maciej Sałuda on 23/06/2022.
//

import Foundation
import CoreImage
import UIKit

enum FilterModel : CaseIterable {
    case blur
    case mono
    case sepia
    case negative
    case paint
    case pixel
    
    func filterTitle() -> String {
        switch self {
        case .blur:
            return "blur"
        case .mono:
            return "mono"
        case .sepia:
            return "sepia"
        case .negative:
            return "negative"
        case .paint:
            return "paint"
        case .pixel:
            return "pixel"
        }
    }
}
