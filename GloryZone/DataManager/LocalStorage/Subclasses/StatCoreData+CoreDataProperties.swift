import Foundation
import CoreData


extension StatCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatCoreData> {
        return NSFetchRequest<StatCoreData>(entityName: "StatCoreData")
    }

    @NSManaged public var isDotaType: Bool
    @NSManaged public var numberOfFirstPlacesTaken: Int32
    @NSManaged public var quantityOfWins: Int32
    @NSManaged public var numberOfPlayersInTeam: Int32
    @NSManaged public var quantityOfLosses: Int32

}

extension StatCoreData : Identifiable {

}
