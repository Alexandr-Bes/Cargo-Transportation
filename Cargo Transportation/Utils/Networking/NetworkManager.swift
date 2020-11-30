//
//  NetworkManager.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

class NetworkManager {
    
    private let networkAdapter = AlamofireNetworkAdapter()
    
    func authorize(email: String, password: String, completion: @escaping GeneralCompletion<SuccessLogin>) {
        
        guard let url = URL(string: "https://www.delivery-auto.com/api/v4/Public/PostLogin") else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        
        let params = LoginModel(userName: email, password: password, rememberMe: true)
        let requestParams = getNetworkParams(model: params)
//        let header = headerProvider.unauthorizedHeader()
//        let requestKey = pathProvider.keyFor(url)
        
        networkAdapter.request(url: url, httpMethod: .post, encoding: .JSON, requestParameters: requestParams, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? SuccessLogin.decode(data: data) else {
                    let errorString = Constants.AuthNetwork.parsingAuthSessionErrorMessage
                    completion(.failure(NetworkError.general(errorString)))
                    return
                }
                completion(.success(responseObject))
        
            }, errors: { (error) in
                completion(.failure(NetworkError.general("Error block")))
                
            }, failure: { (errorString) in
                completion(.failure(NetworkError.general(errorString)))
            })
        }
    }
    
    private func getNetworkParams(model: LoginModel) -> NetworkParameters? {
        
        guard let dataObject = try? JSONEncoder().encode(model) else {
            return nil
        }
        guard let mapObject = try? JSONSerialization.jsonObject(with: dataObject) as? NetworkParameters else {
            return nil
        }
        return mapObject
    }
    
    func get(completion: @escaping GeneralCompletion<RegionList>) { // MODEL
        guard let url = URL(string: "https://www.delivery-auto.com/api/v4/Public/GetRegionList?culture=ru-RU&country=1") else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? RegionList.decode(data: data) else {
                    let errorString = Constants.AuthNetwork.parsingAuthSessionErrorMessage
                    completion(.failure(NetworkError.general(errorString)))
                    return
                }
                completion(.success(responseObject))
        
            }, errors: { (error) in
                completion(.failure(NetworkError.general("Error block")))
                
            }, failure: { (errorString) in
                completion(.failure(NetworkError.general(errorString)))
            })
        }
        
    }
}
