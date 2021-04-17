//
//  DataController.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import Foundation
import CSV

class API {
    static let shared = API()
    
    func getUpdateDay(completion: @escaping(String?)-> Void) {
        let url = URL(string: "https://covid19travel.com/js/data.js")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            let stringData = String(data: data, encoding: .utf8)?.components(separatedBy: "dataUpdate=\"")[1].components(separatedBy: "\";")[0]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let date = dateFormatter.date(from: stringData!)
            dateFormatter.dateFormat = "dd MMM, yyyy"
            completion(dateFormatter.string(from: date!))
        }
        task.resume()
    }
    
    
    func getData(completion: @escaping(Result<[Country], Error>)-> Void) {
        
        var countries: [Country] = []
        
        let url = URL(string: "https://covid19travel.com/js/data.js")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            let stringData = String(data: data, encoding: .utf8)?.components(separatedBy: "data=")[1].components(separatedBy: ";")[0]
            do {
                let countryList = try JSONSerialization.jsonObject(with: (stringData ?? "").data(using: .utf8)!, options: .fragmentsAllowed) as! [[Any]]
                for rawCountry in countryList {
                    let country = Country(code: rawCountry[0] as! String,
                                          name: rawCountry[1] as! String,
                                          stringency: rawCountry[2] as! Double,
                                          status: parseData(data: rawCountry[3] as! [Int]))
                    countries.append(country)
                }
                completion(.success(countries))
            }
            catch(let error) {
                print(error)
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    
    
    func getCSV(code: String, completion: @escaping(Result<CountryDetail, Error>) -> Void) {
        let url = URL(string: "https://covid19travel.com/csv/\(code).csv")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            let string = String(data: data, encoding: .utf8)
            do {
                let csv = try CSVReader(string: string!, hasHeaderRow: true)
                let countryDetail = CountryDetail(covidTesting: (csv.headerRow?[1])!,
                                                  quarantineRules: (csv.headerRow?[2].trimmingCharacters(in: .whitespaces))!,
                                                  sources: (csv.headerRow?[3])!,
                                                  otherInfo: (csv.headerRow?[4])!)
                completion(.success(countryDetail))
                
            }
            catch(let error) {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
