//
//  Coordinator.swift
//  CommonUtils
//
//  Created by Mohammad reza on 10.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit

/// A base class for coordinating navigation flows
///
/// This class provides the foundation for managing navigation and child coordinators.
/// Subclasses should inherit from this class to implement specific navigation logic.
///
open class Coordinator: NSObject {
    
    /// Unique identifier.
    ///
    public let identifier = UUID()
    
    /// Returns navigationController which handles flow of application
    ///
    public private (set) var navigationController: UINavigationController
    
    /// A dictionary of child coordinators associated with this coordinator.
    ///
    /// Child coordinators should be added to this dictionary to retain them in memory.
    ///
    public private (set) var childCoordinators = [UUID: Coordinator]()
    
    /// A callback closure that notifies the parent coordinator when it can be released from memory.
    ///
    private var onFinish: (() -> Void)? = nil
    
    /// Initializes a coordinator with a navigation controller and an optional finish callback.
    ///
    /// - Parameter navigationController: The navigation controller to be used for navigation.
    ///
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Starts the coordination process.
    ///
    /// Subclasses should override this method to implement their navigation logic.
    ///
    open func start() {
        fatalError("start() not implemented by subclass \(self)")
    }
    
    /// Finish method intended for internal use within subclasses.
    ///
    /// Subclasses should call this method when they have completed their navigation flow.
    /// It notifies the parent coordinator that the child coordinator has finished its task.
    ///
    public func finish() {
        onFinish?()
    }
    
    /// Stores coordinator to the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Child coordinator to store.
    ///
    public func store(coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.onFinish = { [weak self] in
            self?.release(coordinator: coordinator)
        }
    }
    
    /// Release coordinator from the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Coordinator to release.
    ///
    private func release(coordinator: Coordinator) {
        guard let containingCoordinator = subCoordinatorWhichContains(coordinator) else { return }
        containingCoordinator.childCoordinators[coordinator.identifier] = nil
    }
    
    /// Recursively searches for a coordinator within child coordinators.
    ///
    /// - Parameter coordinator: The coordinator to search for.
    /// - Returns: The coordinator that contains the specified coordinator, or `nil` if not found.
    ///
    private func subCoordinatorWhichContains(_ coordinator: Coordinator) -> Coordinator? {
        let hasCoordinator = childCoordinators.keys.contains(coordinator.identifier)
        guard hasCoordinator else {
            return childCoordinators.first(where: { (dictionary) -> Bool in
                return dictionary.value.subCoordinatorWhichContains(coordinator) != nil
            })?.value
        }
        return self
    }
}
