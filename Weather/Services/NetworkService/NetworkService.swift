//
//  NetworkService.swift
//  Weather
//
//  Created by Dima Milosh on 16.10.21.
//

import Foundation

protocol NetworkServiceProtocol{
    func getWeatherData<Res>(router: Router, completion: @escaping (Result<Res, Error>) -> Void) where Res : Decodable
}

class NetworkService: NetworkServiceProtocol {
    
    func getWeatherData<Res>(router: Router, completion: @escaping (Result<Res, Error>) -> Void) where Res : Decodable {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = router.path
        components.queryItems = router.parameters
               
        guard let url = components.url else { return }
        let urlRequest = URLRequest(url: url)
        URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard response != nil, let data = data else { return }
            let responseObject = try? JSONDecoder().decode(Res.self, from: data)
            if let responseObject = responseObject {
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            }
        }.resume()
    }
}
