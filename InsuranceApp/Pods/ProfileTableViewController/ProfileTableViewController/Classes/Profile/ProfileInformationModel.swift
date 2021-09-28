import Foundation
import SwiftyJSON
import Generics

public struct ProfileInformationModelResponse {
    public var profileInformation : ProfileInformationModel?
    var isSuccess : Bool?
    
    public init(profileInformation : ProfileInformationModel? = nil, isSuccess : Bool? = false) {
        self.profileInformation = profileInformation
        self.isSuccess = isSuccess
    }
}

public struct ProfileInformationModel  {
    public var name : NameInformation?
    public var id : IdInformation?
    public var phone : String?
    public var email : String?
    var location : AddressInformation?
    public var picture : PictureURL?
    
    public init(json : JSON?) {
        guard let json = json else { return }
        self.name = NameInformation(json: json["name"])
        self.id = IdInformation(json: json["id"])
        self.phone = json["phone"].stringValue
        self.email = json["email"].stringValue
        self.location = AddressInformation(json: json["location"])
        self.picture = PictureURL(json: json["picture"])
    }
}

public struct NameInformation {
    var title : String?
    var first: String?
    var last : String?
    
    public init(json : JSON) {
        self.title = json["title"].stringValue
        self.first = json["first"].stringValue
        self.last = json["last"].stringValue
    }
    
    public func getFullName() -> String {
        var fullname = ""
        if title != nil {
            fullname += title! + " "
        }
        if first != nil {
            fullname += first! + " "
        }
        if last != nil {
            fullname += last!
        }
        return fullname
    }
}

public struct IdInformation  {
    public var name : String?
    public var value : String?
    
    public init(json : JSON) {
        self.name = json["name"].stringValue
        self.value = json["value"].stringValue
    }
}

public struct PictureURL {
    public var medium : String?
    
    public init(json : JSON) {
        self.medium = json["medium"].stringValue
    }
}

struct AddressInformation {
    var street : StreetInformation?
    var city : String?
    var state : String?
    var country : String?
    var postcode : String?
    
    init(json : JSON) {
        self.street = StreetInformation(json: json["street"])
        self.city = json["city"].stringValue
        self.state = json["state"].stringValue
        self.postcode = json["postcode"].rawString() ?? EmptyTextConstant.emptyTextValue.rawValue
        self.country = json["country"].stringValue
    }
}

struct StreetInformation {
    var number : String
    var name : String
    
    init(json : JSON) {
        self.number = json["number"].rawString() ?? EmptyTextConstant.emptyTextValue.rawValue
        self.name = json["name"].stringValue
    }
}
