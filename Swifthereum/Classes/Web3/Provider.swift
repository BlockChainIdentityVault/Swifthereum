//
//  Provider.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

/**
 */
public enum Provider {
    
    ///
    case web3(server: Server)
    
    ///
    case ipc(fileURL: URL)
}
