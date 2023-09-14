//
//  ExternalCoordinatorProvider.swift
//  CommonUtils
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit

public protocol ExternalCoordinatorProvider {
    
    func getCoordinator(_ navigationController: UINavigationController) -> Coordinator
}
