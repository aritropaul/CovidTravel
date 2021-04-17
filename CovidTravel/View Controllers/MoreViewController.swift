//
//  MoreViewController.swift
//  CovidTravel
//
//  Created by Aritro Paul on 16/04/21.
//

import UIKit

class MoreViewController: UITableViewController {

    var detail: CountryDetail!
    var sources: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sources = sourceParser()
    }
    
    func sourceParser() -> [String]{
        var urls: [String] = []
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: detail.sources, options: [], range: NSRange(location: 0, length: detail.sources.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: detail.sources) else { continue }
            let url = detail.sources[range]
            urls.append(String(url))
        }
        
        return urls
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return sources.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") ?? UITableViewCell()
            cell.textLabel?.text = detail.otherInfo.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell") ?? UITableViewCell()
            cell.textLabel?.text = sources[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.imageView?.image = UIImage(systemName: "link.circle")
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "News"
        }
        else {
            return "Sources"
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let url = URL(string: sources[indexPath.row]) {
                UIApplication.shared.open(url)
            }

        }
    }
    
}
