//
//  NetworkManager.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

class NetworkManager {
    
    private let networkAdapter = AlamofireNetworkAdapter()
    
    // TODO: -
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
    
    func getRegionList(url: URL, completion: @escaping GeneralCompletion<RegionListModel>) {
        
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? RegionListModel.decode(data: data) else {
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
    
    func getCitiesList(url: URL, completion: @escaping GeneralCompletion<CitiesListModel>) {
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? CitiesListModel.decode(data: data) else {
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
    
    func getRepresentationList(url: URL, completion: @escaping GeneralCompletion<RepresentationListModel>) {
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? RepresentationListModel.decode(data: data) else {
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
    
    
    func test<T: Codable>(url: URL, completion: @escaping GeneralCompletion<T>) {
//        guard let responseObject = try? T.decode(data: data) 
    }
    
    func getRepresentationInfo(url: URL, completion: @escaping GeneralCompletion<RepresentationInfoModel>) {
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? RepresentationInfoModel.decode(data: data) else {
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
    
    func getDeliveryScheme(url: URL, completion: @escaping GeneralCompletion<DeliverySchemeModel>) {
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? DeliverySchemeModel.decode(data: data) else {
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
    
    func getAdditionalServices(url: URL, completion: @escaping GeneralCompletion<AdditionalServicesModel>) {
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in

            response.analysis(success: { (data) in
                guard let responseObject = try? AdditionalServicesModel.decode(data: data) else {
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
    
    
    func calculateDelivery(url: URL, model: CalculatorModel, completion: @escaping GeneralCompletion<CalculationReceiveModel>) {
        guard let params = getNetworkCalculateParams(model: model) else {
            completion(.failure(NetworkError.general(Constants.ParseCalculateModelError)))
            return
        }
        
        networkAdapter.request(url: url, httpMethod: .post, encoding: .JSON, requestParameters: params, requestHeaders: nil) { (response: NetworkResponse) in

            response.analysis(success: { (data) in
                guard let responseObject = try? CalculationReceiveModel.decode(data: data) else {
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
    
    private func getNetworkCalculateParams(model: CalculatorModel) -> NetworkParameters? {
        
        guard let dataObject = try? JSONEncoder().encode(model) else {
            return nil
        }
        guard let mapObject = try? JSONSerialization.jsonObject(with: dataObject) as? NetworkParameters else {
            return nil
        }
        return mapObject
    }
    
    // TODO: -
    func downloadNews(completion: @escaping GeneralCompletion<NewsModel>) {
        guard let url = URL(string: "https://www.delivery-auto.com/api/v4/Public/GetNews?culture=ru-RU&count=20&page=1") else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? NewsModel.decode(data: data) else {
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

    func searchRepresentations(url: URL, completion: @escaping GeneralCompletion<SearchByCoordinatesModel>) {
        
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? SearchByCoordinatesModel.decode(data: data) else {
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
    
    // TODO: -
    // TODO: - change params
    func getDateArrival(areaID: String, arrivalID: String, completion: @escaping GeneralCompletion<DateArrivalModel>) {
        let id = "4fc948a7-3729-e311-8b0d-00155d037960"
        let arrival = "e3ac6f68-3529-e311-8b0d-00155d037960"
        let first = "1c828aa6-70c8-e211-9902-00155d037919"
        let second = "d908c5e1-b36b-e211-81e9-00155d012a15"
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy" //"yyyy-MM-dd'T'HH:mm:SS'Z'"
        let dateString = formatter.string(from: date)
        let currencyCode = 980
        
        guard let url = URL(string: "https://www.delivery-auto.com/api/v4/Public/GetDateArrival?areasSendId=\(id)&areasResiveId=\(arrival)&dateSend=\(dateString)&currency=\(currencyCode)&warehouseSendId=\(first)&warehouseResiveId=\(second)") else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        
        networkAdapter.request(url: url, httpMethod: .get, encoding: .JSON, requestParameters: nil, requestHeaders: nil) { (response: NetworkResponse) in
            
            response.analysis(success: { (data) in
                guard let responseObject = try? DateArrivalModel.decode(data: data) else {
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
