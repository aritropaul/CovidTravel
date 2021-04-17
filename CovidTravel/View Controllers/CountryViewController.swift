//
//  CountryViewController.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import UIKit

class CountryViewController: UITableViewController {

    var country: Country!
    var detail: CountryDetail!
    @IBOutlet weak var maskLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var gatheringsLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var travelLabel: UILabel!
    @IBOutlet weak var intTravelLabel: UILabel!
    @IBOutlet weak var covidTestLabel: UILabel!
    @IBOutlet weak var quarantineLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        API.shared.getCSV(code: country.code) { (result) in
            switch result {
            case .success(let countryDetail):
                self.detail = countryDetail
                DispatchQueue.main.async {
                    self.covidTestLabel.text = self.detail.covidTesting.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    self.quarantineLabel.text = self.detail.quarantineRules.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        self.navigationItem.title = country.name
        self.maskLabel.text = country.status?.facialCovering?.rawValue
        self.educationLabel.text = country.status?.education?.rawValue
        self.workplaceLabel.text = country.status?.workplace?.rawValue
        self.eventsLabel.text = country.status?.publicEvents?.rawValue
        self.gatheringsLabel.text = country.status?.gatherings?.rawValue
        self.transportLabel.text = country.status?.transport?.rawValue
        self.homeLabel.text = country.status?.homeConfinement?.rawValue
        self.travelLabel.text = country.status?.internalTravel?.rawValue
        self.intTravelLabel.text = country.status?.internationalTravel?.rawValue
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moreVC = segue.destination as? MoreViewController {
            moreVC.detail = self.detail
        }
    }
}
