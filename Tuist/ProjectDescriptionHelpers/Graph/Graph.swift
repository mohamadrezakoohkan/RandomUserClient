//
//  RandomUserClient.swift
//  RandomUserClientManifests
//
//  Created by Mohammad reza on 9.09.2023.
//

import Foundation


public class Graph {
    
    private init() { }
    public static let shared = Graph()
    
    /*
     
     Launcher Modules such as iOS app launcher, watchOS launcher, service extensions and etc...
    
     */
    
    public let randomUserClient = Module(type: .launcher, name: Constants.shared.APP_NAME)
    
    /*
     
     Shared Modules such as CommonUI, Core, Networking and etc...
    
     */
    
    public let commonUI = Module(type: .shared, name: "CommonUI")
    
    /*
     
     Feature Modules such as Intro, Home and etc...
    
     */
    
    public let intro = Module(type: .feature, name: "Intro")

    
    public var allModules: [Module] {
        [
            randomUserClient,
            commonUI,
            intro
        ]
    }
}

