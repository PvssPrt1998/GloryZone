
import Foundation
import CoreData


extension ParticipantCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParticipantCoreData> {
        return NSFetchRequest<ParticipantCoreData>(entityName: "ParticipantCoreData")
    }

    @NSManaged public var isDotaType: Bool
    @NSManaged public var isLolType: Bool
    @NSManaged public var name: String
    @NSManaged public var nickname: String

}

extension ParticipantCoreData : Identifiable {

}
