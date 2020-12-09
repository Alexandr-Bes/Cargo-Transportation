//
//  MainAppRepositoryProtocols.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

protocol MainAppRepositoryProtocol: LocationModuleProtocol, RepresentationProtocol {
    
}

protocol LocationModuleProtocol: class {
    func getUserLocation(completion: @escaping GeneralNetworkCompletion<UserLocationProtocol, LocationFailureReason>)
    func autorizationStatus() -> AuthorizationStatus
}

protocol RepresentationProtocol {
    func getRegionList(completion: @escaping GeneralCompletion<RegionListModel>)
    func searchRepresentationsWithUserLocation(longitude: Double, latitude: Double, completion: @escaping GeneralCompletion<SearchByCoordinatesModel>)
    func getDateArrival(areaID: String, arrivalID: String, completion: @escaping GeneralCompletion<DateArrivalModel>)
    
    
    func authorize(email: String, password: String, completion: @escaping GeneralCompletion<SuccessLogin>)
    func downloadNews(completion: @escaping GeneralCompletion<NewsModel>)
}