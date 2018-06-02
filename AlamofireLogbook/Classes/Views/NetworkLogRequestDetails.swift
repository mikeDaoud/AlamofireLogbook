//
//  NetworkLogRequestDetails.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 3/23/18.
//  Copyright © 2018 TSSE. All rights reserved.
//

import UIKit

class NetworkLogRequestDetails: UITableViewController {
    
    // MARK: - Sections Number
    private let requestBasicData = 0
    private let responseBasicData = 1
    private let requestTiming = 2
    
    //MARK: - Cells Indices
    private let responseStatus = 0
    private let responseHeaders = 1
    private let responseBody = 2
    
    private let requestStarTime = 0
    private let requestDuration = 1
    
    // MARK: - Cells reuse identifiers
    private let keyValueCellId = "keyValueCell"
    private let detailsCellId = "basicCell"
    
    private let jsonViewerSegueId = "showJSON"
    
    private enum CellDataType{
        case requestHeaders
        case requestBody
    }
    
    private enum CellData{
        case keyValue(key: String, value: String)
        case base(label:String, type: CellDataType)
    }

    var requestItem: LogItem!{
        didSet{
            requestData.append(CellData.keyValue(key: "METHOD", value: requestItem.requestMethod.uppercased()))
            requestData.append(CellData.keyValue(key: "DOMAIN", value: requestItem.requestDomain))
            requestData.append(CellData.keyValue(key: "PATH", value: requestItem.requestURL))
            if requestItem.requestQueryParams.count > 0 {
                requestData.append(CellData.keyValue(key: "PARAMS", value: requestItem.requestQueryParams.joined(separator: "\n")))
            }
            if requestItem.requestHeaders.count > 0{
                requestData.append(CellData.base(label: "REQUEST HEADERS", type: .requestHeaders))
            }
            if requestItem.requestBody != nil{
                requestData.append(CellData.base(label: "REQUEST BODY", type: .requestBody))
            }
        }
    }
    private var requestData: [CellData] = []
    
    // MARK: - Section Details
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case requestBasicData:
            return "REQUEST DETAILS"
        case responseBasicData:
            return "RESPONSE DETAILS"
        case requestTiming:
            return "REQUEST TIMING"
        default: return nil
        }
    }
    
    @IBAction func shareRequest(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: [requestItem.description], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - Cell Details
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case requestBasicData:
            return requestData.count
        case responseBasicData:
            return 3
        case requestTiming:
            return 2
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case requestBasicData:
            return getRequestCell(index: indexPath.row)
        case responseBasicData:
            return getResponseCell(index: indexPath.row)
        case requestTiming:
            return getRequestTimingCell(index: indexPath.row)
        default: return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case requestBasicData:
            let item = requestData[indexPath.row]
            switch item{
            case .base(_, let type):
                if type == .requestHeaders{
                    let data = try? JSONSerialization.data(withJSONObject: requestItem.requestHeaders, options: .prettyPrinted)
                    performSegue(withIdentifier: jsonViewerSegueId, sender: data)
                }else if type == .requestBody{
                    performSegue(withIdentifier: jsonViewerSegueId, sender: requestItem.requestBody)
                }
            default: return
            }
        case responseBasicData:
            if indexPath.row == responseHeaders{
                let data = try? JSONSerialization.data(withJSONObject: requestItem.responseHeaders, options: .prettyPrinted)
                performSegue(withIdentifier: jsonViewerSegueId, sender: data)
            }else if indexPath.row == responseBody{
                performSegue(withIdentifier: jsonViewerSegueId, sender: requestItem.responseBody)
            }
        default: return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == jsonViewerSegueId,
            let data = sender as? Data?,
            let jsonViewer = segue.destination as? NetworkLogJSONViewer else {return}
        jsonViewer.data = data
    }
    
    private func getRequestCell(index: Int) -> UITableViewCell{
        let item = requestData[index]
        switch item {
        case .keyValue(let key, let value):
            return getKeyValueCell(key: key, value: value)
        case .base(let label,_):
            return getBaseCell(title: label)
        }
    }
    
    private func getResponseCell(index: Int)-> UITableViewCell{
        switch index{
        case responseStatus:
            let cell = getKeyValueCell(key: "STATUS", value: requestItem.responseStatusCode)
            switch requestItem.responseStatus{
            case .success:
                cell.valueLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            default:
                cell.valueLabel.textColor = #colorLiteral(red: 0.9316337705, green: 0.1339298785, blue: 0, alpha: 1)
            }
            return cell
        case responseHeaders:
            return getBaseCell(title: "RESPONSE HEADERS")
        case responseBody:
            return getBaseCell(title: "RESPONSE BODY")
        default: return UITableViewCell()
        }
    }
    
    private func getRequestTimingCell(index: Int) -> UITableViewCell{
        switch index{
        case requestStarTime:
            return getKeyValueCell(key: "START TIME", value: requestItem.requestTime)
        case requestDuration:
            return getKeyValueCell(key: "DURATION", value: requestItem.requestDuration)
        default: return UITableViewCell()
        }
    }
    
    private func getKeyValueCell(key: String, value: String) -> KeyValueCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: keyValueCellId) as! KeyValueCell
        cell.keyLabel.text = key
        cell.valueLabel.text = value
        cell.selectionStyle = .none
        return cell
    }
    
    private func getBaseCell(title: String) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: detailsCellId)!
        cell.textLabel?.text = title
        cell.selectionStyle = .none
        return cell
    }
}

class KeyValueCell: UITableViewCell{
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func prepareForReuse() {
        valueLabel.textColor = UIColor.black
    }
}
