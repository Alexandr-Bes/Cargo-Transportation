//
//  Endpoints.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

enum Endpoints: String {
    
    case login = "PostLogin"
    case news = "GetNews"
    case regionList = "GetRegionList"
    case findRepresentationUserLocation = "GetFindWarehouses"
    case dateArrival = "GetDateArrival"
    case representationDetails = "GetWarehousesInfo"
    case citiesList = "GetAreasList"
    case representationList = "GetWarehousesList"
    case deliveryScheme = "GetDeliveryScheme"
    case services = "GetDopUslugiClassification"
    case calculateDelivery = "PostReceiptCalculate"
    
    private var basePath : String {
        return "https://www.delivery-auto.com/api/v4/Public/"
    }
    
    private var suffix: String {
        return "?culture=ru-RU"
    }
    
    func toString() -> String {
        return basePath + self.rawValue
    }
    
    func toStringWithSuffix() -> String {
        return basePath + self.rawValue + suffix
    }
    
    //    func toURL() -> URL? {
    //        return URL(string: toString())
    //    }
        
    //    func toURLWithSuffix() -> URL? {
    //        return URL(string: toStringWithSuffix())
    //    }
}
