import Foundation
import SwiftyJSON

public struct StateModel {
    public var stateId : String?
    public var stateName : String?
    
    public init(json : JSON) {
        self.stateId = json["ID State"].stringValue
        self.stateName = json["State"].stringValue
    }
}

public struct StateModelResponse {
    public var statesArray  : [StateModel]?
    var isSucess :Bool?

    public init(statesArray: [StateModel]? = nil, isSucess: Bool? = nil) {
        self.statesArray = statesArray
        self.isSucess = isSucess
    }
}
