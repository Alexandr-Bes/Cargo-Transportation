//
//  MainAppRepository+Representations.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 09.12.2020.
//

import Foundation

extension MainAppRepository {
    
    func getRegionList(completion: @escaping GeneralCompletion<RegionListModel>) {
        let urlString = pathProvider.getRegionList + "&country=1"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        
        networkManager.getRegionList(url: url) { (result) in
            switch result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCitiesList(id: Int, completion: @escaping GeneralCompletion<CitiesListModel>) {
        let urlString = pathProvider.getCitiesList + "&regionId=\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        networkManager.getCitiesList(url: url) { (result) in
            switch result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRepresentationList(cityID: String, regionID: String, completion: @escaping GeneralCompletion<RepresentationListModel>) {
        let urlString = pathProvider.getRepresentationList + "&CityId=\(cityID)" + "&regionId=\(regionID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        networkManager.getRepresentationList(url: url) { (result) in
            switch result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func searchRepresentationsWithUserLocation(longitude: Double, latitude: Double, completion: @escaping GeneralCompletion<SearchByCoordinatesModel>) {
        let urlString = pathProvider.searchRepresentationsUserLocation + "&Longitude=\(longitude)" + "&Latitude=\(latitude)" + "&count=20"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        
        networkManager.searchRepresentations(url: url) { (result) in
            switch result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRepresentationInfo(id: String, completion: @escaping GeneralCompletion<RepresentationInfoModel>) {
        let urlString = pathProvider.getRepresentationDetails + "&WarehousesId=\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.general(Constants.NoURLErrorMessage)))
            return
        }
        networkManager.getRepresentationInfo(url: url) { (result) in
            switch result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDateArrival(areaID: String, arrivalID: String, completion: @escaping GeneralCompletion<DateArrivalModel>) {
        
    }
    
    func authorize(email: String, password: String, completion: @escaping GeneralCompletion<SuccessLogin>) {
        
    }
    
    func downloadNews(completion: @escaping GeneralCompletion<NewsModel>) {
        
    }
}
