//
//  PathProvider.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 09.12.2020.
//

import Foundation

final class PathProvider: PathProviderProtocol {
    
}

protocol PathProviderProtocol {
    var login: String { get }
    var getNews: String { get }
    var getRegionList: String { get }
    var searchRepresentationsUserLocation: String { get }
    var getDateArrival: String { get }
}

extension PathProviderProtocol {
    var login: String {
        return Endpoints.login.toString()
    }
    
    var getNews: String {
        return Endpoints.news.toStringWithSuffix()
    }
    
    var getRegionList: String {
        return Endpoints.regionList.toStringWithSuffix()
    }
    
    var searchRepresentationsUserLocation: String {
        return Endpoints.findRepresentationUserLocation.toStringWithSuffix()
    }
    
    var getDateArrival: String {
        return Endpoints.dateArrival.toString()
    }
    
    
}
