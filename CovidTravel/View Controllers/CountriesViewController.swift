//
//  CountriesViewController.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import UIKit

class CountriesViewController: UITableViewController {

    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var countries : [Country] = []
    var filteredCountries: [Country] = []
    var selectedCountry: Country!
    let searchController =  UISearchController(searchResultsController: nil)
    
    var isAscending: Bool = true
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a country"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    
        
        API.shared.getUpdateDay { (date) in
            DispatchQueue.main.async {
                self.navigationItem.prompt = "Last updated: \(date ?? "Unknown")"
            }
        }
        
        API.shared.getData { (result) in
            switch result {
            case .success(let countries) :
                self.countries = countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error): self.handleError(error: error)
            }
        }
        
    }

    @IBAction func sortTapped(_ sender: Any) {
        isAscending = !isAscending
        
        if isAscending {
            countries.sort { (c1, c2) -> Bool in
                return c1.stringency < c2.stringency
            }
            tableView.reloadData()
            sortButton.image = UIImage(systemName: "arrow.up.right")
            
        }
        else {
            countries.sort { (c1, c2) -> Bool in
                return c1.stringency > c2.stringency
            }
            tableView.reloadData()
            sortButton.image = UIImage(systemName: "arrow.down.right")
        }
        
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        }
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        if isFiltering {
            cell.nameLabel.text = filteredCountries[indexPath.row].name
            cell.stringencyLabel.text = String(describing: filteredCountries[indexPath.row].stringency)
        }
        else {
            cell.nameLabel.text = countries[indexPath.row].name
            cell.stringencyLabel.text = String(describing: countries[indexPath.row].stringency)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            self.selectedCountry = filteredCountries[indexPath.row]
        }
        else {
            self.selectedCountry = countries[indexPath.row]
        }
        self.performSegue(withIdentifier: "country", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let countryVC = segue.destination as? CountryViewController {
            countryVC.country = self.selectedCountry
        }
    }
    
}


extension CountriesViewController : UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCountries = countries.filter({ (country) -> Bool in
            return country.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    
}




extension UIViewController {
    
    func handleError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
