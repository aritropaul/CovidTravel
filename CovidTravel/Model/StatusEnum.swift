//
//  StatusEnum.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import Foundation

enum Education: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case alterations = "Recommend closing or all schools open with alterations"
    case partialClosing = "Require closing (only some levels or categories)"
    case fullyClosed = "Require closing all levels"
}

enum Workplaces: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case closeOrWfh = "Recommend closing (or recommend work from home)"
    case closeSomeSectors = "Require closing (or work from home) for some sectors or categories of workers"
    case essential = "Require closing (or work from home) for all-but-essential workplaces (eg grocery stores, doctors)"
}


enum PublicEvents: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case cancelRecommend = "Recommend cancelling"
    case cancelRequired = "Require cancelling"
}

enum Gatherings: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case veryLarge = "Restrictions on very large gatherings (the limit is above 1000 people)"
    case large = "Restrictions on gatherings between 101-1000 people"
    case medium = "Restrictions on gatherings between 11-100 people"
    case small = "Restrictions on gatherings of 10 people or less"
}

enum PublicTransport: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case closingRecommend = "Recommend closing (or significantly reduce transport available)"
    case closingRequired = "Require closing (or prohibit most citizens from using it)"
}

enum HomeConfinement: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case confined = "Recommend not leaving house"
    case partiallyConfined = "Require not leaving house with exceptions for grocery shopping, and 'essential' trips"
    case minimallyConfined = "Require not leaving house with minimal exceptions (eg allowed to leave once a week)"
}

enum InternalTravel: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case notRecommended = "Recommend not to travel between regions/cities"
    case restricted = "Internal movement restrictions in place"
}
    
enum InternationalTravel: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No measures"
    case screening = "Screening arrivals"
    case quarantine = "Quarantine arrivals from some or all regions"
    case restricted = "Ban arrivals from some regions"
    case banned = "Ban on all regions or total border closure"
}

enum FacialCovering: String, CaseIterable, Codable {
    case noData = "No Data"
    case noMeasures = "No policy"
    case recommended = "Recommended"
    case requiredL1 = "Required in some specified shared/public spaces outside the home with other people present"
    case requiredL2 = "Required in all shared/public spaces outside the home with other people present"
    case requiredL3 = "Required outside the home at all times regardless of location or presence of other people"
}
