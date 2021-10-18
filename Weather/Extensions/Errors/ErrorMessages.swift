//
//  ErrorMessages.swift
//  Weather
//
//  Created by Dima Milosh on 17.10.21.
//

import Foundation

enum ErrorMessage {
    case network
    case location
    
    var title: String {
        return "Opps!.."
    }
    
    var body: String {
        switch self {
        case .network:
            return "Something wrong with your internet connection. Please, try again later."
        case .location:
            return "Failed to get your location. Please try again later."
        }
    }
}
