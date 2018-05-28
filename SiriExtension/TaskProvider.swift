//
// Created by jordhan leoture on 25/05/2018.
// Copyright (c) 2018 jordhan leoture. All rights reserved.
//

import Foundation
import Intents

class TaskProvider {
  static let titles = ["importante", "standard"]

  static func fetchTaskLists() -> [INTaskList]? {
    return titles.map(createTaskList)
  }

  static func fetchTasks(listName: String) -> [INTask] {
    return [createTask(1, listName), createTask(2, listName)]
  }

  private static func createTaskList(_ name: String) -> INTaskList {
    return INTaskList(title: INSpeakableString(spokenPhrase: name),
                      tasks: fetchTasks(listName: name),
                      groupName: nil,
                      createdDateComponents: .none,
                      modifiedDateComponents: .none,
                      identifier: name)
  }

  static func titles(matchingTitle: INSpeakableString?) -> [INSpeakableString] {
    guard let matchingTitle = matchingTitle?.spokenPhrase else {
      return [INSpeakableString]()
    }

    return titles.filter { $0.contains(matchingTitle.lowercased()) }
        .map { INSpeakableString(spokenPhrase: $0) }
  }

  private static func createTask(_ id: Int, _ name: String) -> INTask {
    return INTask(title: INSpeakableString(spokenPhrase: "tâche \(name) \(id)"),
                  status: .notCompleted,
                  taskType: .completable,
                  spatialEventTrigger: .none,
                  temporalEventTrigger: .none,
                  createdDateComponents: .none,
                  modifiedDateComponents: .none,
                  identifier: "\(name)+ \(id)")
  }
}
