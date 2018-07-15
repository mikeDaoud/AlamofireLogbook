//
//  AlamofireLogbook.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 3/21/18.
//  Copyright © 2018 TSSE. All rights reserved.
//

import Foundation
import Alamofire

public protocol AlamofireResponseListener: class{
    func recievedResponseFor(item : LogItem)
}

public class AlamofireLogbook{
    
    public static var shared = AlamofireLogbook()
    
    public weak var delegate: AlamofireResponseListener?
    
    private var responsesQueue:[DataResponse<Data>] = []
    
    // MARK: - Editing Cached Data
    
    func appendResponse(_ response: DataResponse<Data>){
        responsesQueue.insert(response, at: 0)
        delegate?.recievedResponseFor(item: LogItem(response: response))
    }
    
    func clearCache(){
        responsesQueue = []
    }
    
    // MARK: - Getting requests list data
    
    var requestsList: [LogItem]{
        return responsesQueue.map{return LogItem(response: $0)}
    }
    
    // MARK: - Showing Log
    
    public static func show(){
        AlamofireLogbookRequestsList.show()
    }
}

extension DataRequest{
    public func log() -> Self{
        responseData { (result) in
            AlamofireLogbook.shared.appendResponse(result)
        }
        return self
    }
}
