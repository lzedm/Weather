//
//  Presenter.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import Foundation

protocol ViewProtocol: AnyObject{

}

protocol ViewPresenterProtocol: AnyObject{
    init(view: ViewProtocol)
}

class Presenter: ViewPresenterProtocol{
    let view: ViewProtocol
    
        
    required init(view: ViewProtocol) {
        self.view = view
    }
    
}
