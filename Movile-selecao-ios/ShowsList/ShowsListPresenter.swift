//
//  ShowsListPresenter.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 5/24/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol ShowsListEventHandler {
    func reloadView()
}

protocol ShowsListInterface {
    func didFinishRequestData()
    func displayError(error: ErrorType)
    func reloadData()
    func setDisplayObjects(objects: [ShowDisplayObject])
    func setViewEmpty(empty: Bool)
}

struct ShowDisplayObject {
    let title: String
    let watchers: Int
    let imageURL: NSURL
}

class ShowsListPresenter: ShowsListEventHandler {
    
    private var interactor = ShowsListInteractor()
    
    var view: ShowsListInterface?
    
    func reloadView() {
        interactor.listAllWithBlock { (shows: [Show]?, error: ErrorType?) in
            self.view?.didFinishRequestData()
            
            guard error == nil else {
                self.view?.displayError(error!)
                return
            }
            
            guard shows != nil else {
                self.view?.setViewEmpty(true)
                return
            }
            
            let displayObjects = shows!.sort { $0.watchers > $1.watchers }.map { ShowDisplayObject(title: $0.title, watchers: $0.watchers, imageURL: $0.imageURL) }
            self.view?.setDisplayObjects(displayObjects)
            self.view?.reloadData()
        }
    }
    
}