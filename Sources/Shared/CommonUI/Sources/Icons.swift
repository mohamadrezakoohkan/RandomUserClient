//
//  Icons.swift
//  CommonUI
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit

public extension CommonUIAsset {
    enum Icons {
        
        case person(filled: Bool)
        case bookmark(filled: Bool)
        case gearshape(filled: Bool)
        
        public var systemName: String {
            switch self {
            case let .person(filled):
                return "person" + getModification(filled: filled)
            case let .bookmark(filled):
                return "bookmark" + getModification(filled: filled)
            case let .gearshape(filled):
                return "gearshape" + getModification(filled: filled)
            }
        }
        
        public var image: UIImage {
            return UIImage(systemName: systemName)!
        }
        
        private func getModification(filled: Bool) -> String {
            return (filled ? ".fill" : "")
        }
    }
}
