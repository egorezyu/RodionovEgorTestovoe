//
//  NetworkManager.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import Foundation
enum GetDataException : String ,Error{
    case invalidUrl = "something went wrong with url(maybe it was changed in NetworkManagerClas)"
    case badResponse = "bad response or failed cod"
    case badData = "couldnt return data"
    
}
import Foundation
import UIKit
class NetworkManager{
    static var netWork = NetworkManager()
    private let url = "https://vkus-sovet.ru/api/getMenu.php"
    private let url2 = "https://vkus-sovet.ru/api/getSubMenu.php"
    
    private init(){
        
    }
    //working with network with escaping completion and result
    func getData(url : String ,method : String = "POST", params : [String:Int] = [:], comletion : @escaping ((Result<Data,Error>) -> Void)){
        guard let url = URL(string: url) else{
            comletion(.failure(GetDataException.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if method == "POST"{
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                comletion(.failure(GetDataException.invalidUrl))
                return
                
            }
            request.httpBody = httpBody
        }
        
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                comletion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                comletion(.failure(GetDataException.badResponse))
                return
            }
            guard let data = data else {
                comletion(.failure(GetDataException.badData))
                return
            }
            comletion(.success(data))
            print(data)



        }
        task.resume()
        
        
    }
}
