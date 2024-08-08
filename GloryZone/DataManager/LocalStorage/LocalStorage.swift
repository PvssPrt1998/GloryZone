import Foundation
import CoreData

final class LocalStorage {
    
    private let modelName = "GloryZone"
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func save(_ team: Team) {
        let teamCoreData = TeamCoreData(context: coreDataStack.managedContext)
        teamCoreData.image = team.image
        teamCoreData.title = team.title
        coreDataStack.saveContext()
    }
    
    func save(_ participant: Participant) {
        let participantCoreData = ParticipantCoreData(context: coreDataStack.managedContext)
        participantCoreData.isDotaType = participant.isDotaType
        participantCoreData.isLolType = participant.isLolType
        participantCoreData.name = participant.name
        participantCoreData.nickname = participant.nickname
        coreDataStack.saveContext()
    }
    
    func remove(_ participant: Participant) throws {
        let participants = try coreDataStack.managedContext.fetch(ParticipantCoreData.fetchRequest())
        let participantCoreData = participants.first(where: {
            $0.name == participant.name &&
            $0.nickname == participant.nickname &&
            $0.isDotaType == participant.isDotaType &&
            $0.isLolType == participant.isLolType
        })
        guard let participantCoreData = participantCoreData else { return }
        coreDataStack.managedContext.delete(participantCoreData)
        coreDataStack.saveContext()
    }
    
    func removeAll() throws {
        let participantsCoreData = try coreDataStack.managedContext.fetch(ParticipantCoreData.fetchRequest())
        participantsCoreData.forEach { participantCoreData in
            coreDataStack.managedContext.delete(participantCoreData)
        }
        let teamCoreData = try coreDataStack.managedContext.fetch(TeamCoreData.fetchRequest())
        teamCoreData.forEach { teamCoreData in
            coreDataStack.managedContext.delete(teamCoreData)
        }
        let activitiewsCoreData = try coreDataStack.managedContext.fetch(ActivityCoreData.fetchRequest())
        activitiewsCoreData.forEach { activityCoreData in
            coreDataStack.managedContext.delete(activityCoreData)
        }
        let statsCoreData = try coreDataStack.managedContext.fetch(StatCoreData.fetchRequest())
        statsCoreData.forEach { statCoreData in
            coreDataStack.managedContext.delete(statCoreData)
        }
        coreDataStack.saveContext()
    }
    
    func save(_ activity: Activity) {
        let activityCoreData = ActivityCoreData(context: coreDataStack.managedContext)
        activityCoreData.date = activity.date
        activityCoreData.title = activity.title
        coreDataStack.saveContext()
    }
    
    func save(_ stat: Stat) {
        let statCoreData = StatCoreData(context: coreDataStack.managedContext)
        statCoreData.isDotaType = stat.isDotaType
        statCoreData.numberOfFirstPlacesTaken = Int32(stat.numberOfFirstPlacesTaken)
        statCoreData.numberOfPlayersInTeam = Int32(stat.numberOfPlayersInTeam)
        statCoreData.quantityOfLosses = Int32(stat.quantityOfLosses)
        statCoreData.quantityOfWins = Int32(stat.quantityOfWins)
        coreDataStack.saveContext()
    }
    
    func fetchTeam() throws -> Team? {
        guard let teamCoreData = try coreDataStack.managedContext.fetch(TeamCoreData.fetchRequest()).first else { return nil }
        return Team(image: teamCoreData.image, title: teamCoreData.title)
    }
    
    func fetchParticipants() throws -> [Participant] {
        var participants: Array<Participant> = []
        let participantsCoreData = try coreDataStack.managedContext.fetch(ParticipantCoreData.fetchRequest())
        participantsCoreData.forEach { participantCoreData in
            participants.append(Participant(isDotaType: participantCoreData.isDotaType, isLolType: participantCoreData.isLolType, name: participantCoreData.name, nickname: participantCoreData.nickname))
        }
        return participants
    }
    
    func fetchActivities() throws -> [Activity] {
        var activities: Array<Activity> = []
        let activitiewsCoreData = try coreDataStack.managedContext.fetch(ActivityCoreData.fetchRequest())
        activitiewsCoreData.forEach { activityCoreData in
            activities.append(Activity(title: activityCoreData.title, date: activityCoreData.date))
        }
        return activities
    }
    
    func fetchStat() throws -> (Stat, Stat) {
        var stats: (Stat, Stat) = (Stat(isDotaType: true, quantityOfWins:   0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0),
                                   Stat(isDotaType: false, quantityOfWins:   0, quantityOfLosses: 0, numberOfFirstPlacesTaken: 0, numberOfPlayersInTeam: 0))
        let statsCoreData = try coreDataStack.managedContext.fetch(StatCoreData.fetchRequest())
        statsCoreData.forEach { statCoreData in
            if statCoreData.isDotaType {
                stats.0 = Stat(isDotaType: statCoreData.isDotaType,
                               quantityOfWins: Int(statCoreData.quantityOfWins),
                               quantityOfLosses: Int(statCoreData.quantityOfLosses),
                               numberOfFirstPlacesTaken: Int(statCoreData.numberOfFirstPlacesTaken),
                               numberOfPlayersInTeam: Int(statCoreData.numberOfPlayersInTeam))
            } else {
                stats.1 = Stat(isDotaType: statCoreData.isDotaType,
                               quantityOfWins: Int(statCoreData.quantityOfWins),
                               quantityOfLosses: Int(statCoreData.quantityOfLosses),
                               numberOfFirstPlacesTaken: Int(statCoreData.numberOfFirstPlacesTaken),
                               numberOfPlayersInTeam: Int(statCoreData.numberOfPlayersInTeam))
            }
        }
        
        return stats
    }
}
