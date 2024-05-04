//
//  ARManager.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import Combine

/// A singleton class responsible for managing AR session actions and
/// facilitating communication between different components of the AR application.
class ARManager {
    /// The shared instance of `ARManager`, providing a single point of access
    /// throughout the application.
    static let shared = ARManager()
    
    /// A `PassthroughSubject` used for publishing AR session actions to subscribers.
    let actionStream = PassthroughSubject<ARAction, Never>()
}
