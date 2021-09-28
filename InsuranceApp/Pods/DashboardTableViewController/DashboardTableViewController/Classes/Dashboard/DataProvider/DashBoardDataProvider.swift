import Foundation
import Generics

protocol DashBoardDataProviderConfigurable {
    var dashBoardDataModel : DashboardModel? {get}
    func loadDashboardData() -> DashboardModel?
}

class DashBoardDataProvider : DashBoardDataProviderConfigurable {
    var dashBoardDataModel: DashboardModel?
    public static let sharedInstance = DashBoardDataProvider()

    func loadDashboardData() -> DashboardModel? {
        var upcomingsBillsModel = UpcomingBillsModel(billsImageString: ImageString.noBillsImage.rawValue)
        var idsModelArray = [IDsModel]()
        idsModelArray.append(IDsModel(idsImageString: "bill1Image"))
        idsModelArray.append(IDsModel(idsImageString: "bill2Image"))
        idsModelArray.append(IDsModel(idsImageString: "bill3Image"))
        idsModelArray.append(IDsModel(idsImageString: "bill4Image"))
        var reportAndRequestModelArray = [ReportAndRequestModel]()
        reportAndRequestModelArray.append(ReportAndRequestModel(title: "RoadSide assistance Request"))
        reportAndRequestModelArray.append(ReportAndRequestModel(title: "Report Accident"))
        dashBoardDataModel = DashboardModel(upcomingBillsModel: upcomingsBillsModel, idsModel:idsModelArray, reportAndRentalModelsArray: reportAndRequestModelArray, profileInformation: nil)
        return dashBoardDataModel
    }
}
