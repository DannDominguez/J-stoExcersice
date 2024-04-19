//
//  UsersListViewModel.swift
//  JustoApp
//
//  Created by Daniela Ciciliano on 17/04/24.
//

import Foundation
import SwiftUI

class UsersListViewModel: ObservableObject {
    
    @Published var userDetail: UsersModel?
    @Published var error: Error?
    
    let ApiClient = APIClient()
    
    func getUserData() {
        ApiClient.getUsers() { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let data):
                    self.userDetail = data
                    print("Result \(String(describing: self.userDetail))")
                case .failure(let error):
                    self.error = error
                    print("Error fetching Data \(error)")
                    
                }
                
            }
            
        }
    }
    func refreshUserData() {
           // Lógica para cargar nuevamente los datos del usuario
           getUserData()
       }
}


