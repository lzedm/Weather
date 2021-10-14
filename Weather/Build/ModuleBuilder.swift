//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import UIKit

protocol Builder{
   static func createMain() -> UIViewController
}

class ModuleBuilder: Builder {

    static func createMain() -> UIViewController {
        let view = ViewController()
        let presenter = Presenter(view: view)
        view.presenter = presenter
        return view
    }
}
