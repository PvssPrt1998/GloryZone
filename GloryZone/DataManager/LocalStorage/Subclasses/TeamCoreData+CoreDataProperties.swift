import Foundation
import CoreData


extension TeamCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamCoreData> {
        return NSFetchRequest<TeamCoreData>(entityName: "TeamCoreData")
    }

    @NSManaged public var image: Data
    @NSManaged public var title: String

}

extension TeamCoreData : Identifiable {

}
