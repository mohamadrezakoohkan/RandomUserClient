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
    
    public let randomUserClient = Module(type: .launcher, name: Constants.shared.APP_NAME_VALUE)
    
    /*
     
     Shared Modules such as CommonUI, Core, Networking and etc...
    
     */
    public let entities = Module(type: .shared, name: "Entities")
    public let networking = Module(type: .shared, name: "Networking")
    public let storage = Module(type: .shared, name: "Storage")
    public let services = Module(type: .shared, name: "Services")
    public let commonUI = Module(type: .shared, name: "CommonUI")
    public let commonUtils = Module(type: .shared, name: "CommonUtils")
    
    /*
     
     Feature Modules such as Intro, Home and etc...
    
     */
    
    public let intro = Module(type: .feature, name: "Intro")
    public let tabBar = Module(type: .feature, name: "TabBar")
    public let userCatalog = Module(type: .feature, name: "UserCatalog")
    public let bookmarks = Module(type: .feature, name: "Bookmarks")
    
    public var allModules: [Module] {
        [
            randomUserClient,
            entities,
            networking,
            storage,
            services,
            commonUI,
            commonUtils,
            intro,
            tabBar,
            userCatalog,
            bookmarks
        ]
    }
}

