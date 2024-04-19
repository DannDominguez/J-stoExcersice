//
//  APIClient.swift
//  JustoApp
//
//  Created by Daniela Ciciliano on 17/04/24.
//

import Foundation

class APIClient {
    
    func getUsers(completion: @escaping (Result<UsersModel, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            do {
                let result = try JSONDecoder().decode(UsersModel.self, from: data)
                completion(.success(result))
            } catch {
                print("Error decoding JSON:\(error)")
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    
}
