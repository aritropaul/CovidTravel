//
//  AboutViewController.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import UIKit

class AboutViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if let url = URL(string: "https://aritro.work") {
                UIApplication.shared.open(url)
            }
        }
        
        if indexPath.row == 3 {
            if let url = URL(string: "https://github.com/aritropaul/CovidTravel") {
                UIApplication.shared.open(url)
            }
        }
        
        if indexPath.row == 4 {
            if let url = URL(string: "https://covid19travel.com") {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
