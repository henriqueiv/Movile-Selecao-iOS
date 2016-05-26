//
//  ShowsListInteractor.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 5/24/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol DataManager:class {
    associatedtype T
    
    func listAllWithBlock(block: ( ([T]?, ErrorType?) -> () ) )
}

class ShowsListInteractor: DataManager {
    
    typealias T = Show
    
    func listAllWithBlock(block: ([T]?, ErrorType?) -> ()) {
        APIManager.sharedInstance.getTrendingShowsWithBlock { (shows: [Show]?, error: ErrorType?) in
            block(shows, error)
        }
    }
    
}