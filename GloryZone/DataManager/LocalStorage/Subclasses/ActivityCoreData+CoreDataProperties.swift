import Foundation
import CoreData


extension ActivityCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityCoreData> {
        return NSFetchRequest<ActivityCoreData>(entityName: "ActivityCoreData")
    }

    @NSManaged public var title: String
    @NSManaged public var date: String

}

extension ActivityCoreData : Identifiable {

}
