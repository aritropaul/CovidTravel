//
//  Country.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import Foundation


struct Country : Codable {
    var code: String
    var name: String
    var stringency: Double
    var status: Status?
}

struct Status: Codable {
    var updated: String?
    var education: Education?
    var workplace: Workplaces?
    var publicEvents: PublicEvents?
    var gatherings: Gatherings?
    var transport: PublicTransport?
    var homeConfinement: HomeConfinement?
    var internalTravel: InternalTravel?
    var internationalTravel: InternationalTravel?
    var facialCovering: FacialCovering?
}

struct CountryDetail {
    var covidTesting: String
    var quarantineRules: String
    var sources: String
    var otherInfo: String
}

func parseData(data: [Int]) -> Status {
    var status = Status()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: String(data[0]))
    dateFormatter.dateFormat = "dd MMM, yyyy"
    status.updated = dateFormatter.string(from: date!)
    status.education = education(index: data[1])
    status.workplace = workplaces(index: data[2])
    status.publicEvents = events(index: data[3])
    status.gatherings = gatherings(index: data[4])
    status.transport = transport(index: data[5])
    status.homeConfinement = confinement(index: data[6])
    status.internalTravel = travel(index: data[7])
    status.internationalTravel = intTravel(index: data[8])
    status.facialCovering = masks(index: data[9])
    return status
}

func education(index: Int) -> Education {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .alterations
    case 2:
        return .partialClosing
    case 3:
        return .fullyClosed
    default:
        return .noData
    }
}

func workplaces(index: Int) -> Workplaces {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .closeOrWfh
    case 2:
        return .closeSomeSectors
    case 3:
        return .essential
    default:
        return .noData
    }
}

func events(index: Int) -> PublicEvents {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .cancelRecommend
    case 2:
        return .cancelRequired
    default:
        return .noData
    }
}

func gatherings(index: Int) -> Gatherings {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .veryLarge
    case 2:
        return .large
    case 3:
        return .medium
    case 4:
        return .small
    default:
        return .noData
    }
}

func transport(index: Int) -> PublicTransport {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .closingRecommend
    case 2:
        return .closingRequired
    default:
        return .noData
    }
}

func confinement(index: Int) -> HomeConfinement {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .confined
    case 2:
        return .partiallyConfined
    case 3:
        return .minimallyConfined
    default:
        return .noData
    }
}

func travel(index: Int) -> InternalTravel {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .notRecommended
    case 2:
        return .restricted
    default:
        return .noData
    }
}

func intTravel(index: Int) -> InternationalTravel {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .screening
    case 2:
        return .quarantine
    case 3:
        return .restricted
    case 4:
        return .banned
    default:
        return .noData
    }
}

func masks(index: Int) -> FacialCovering {
    switch index {
    case 0:
        return .noMeasures
    case 1:
        return .recommended
    case 2:
        return .requiredL1
    case 3:
        return .requiredL2
    case 4:
        return .requiredL3
    default:
        return .noData
    }
}
