//
//  ARManager.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
