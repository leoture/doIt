//
// Created by jordhan leoture on 25/05/2018.
// Copyright (c) 2018 jordhan leoture. All rights reserved.
//

import Foundation
import Intents
import LocalAuthentication

class SearchForNotebookItemsIntentHandler: NSObject, INSearchForNotebookItemsIntentHandling {

  func resolveItemType(for intent: INSearchForNotebookItemsIntent,
                       with completion: @escaping (INNotebookItemTypeResolutionResult) -> Void) {
    switch intent.itemType {
    case .taskList, .task: completion(.success(with: intent.itemType))
    case .note: completion(.unsupported())
    case .unknown: completion(.disambiguation(with: [.task, .taskList]))
    }
  }

  func resolveTitle(for intent: INSearchForNotebookItemsIntent,
                    with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
    guard intent.itemType == .task else {
      completion(.notRequired())
      return
    }

    let titles = TaskProvider.titles(matchingTitle: intent.title)
    switch titles.count {
    case 0: completion(.needsValue())
    case 1: completion(.success(with: titles.first!))
    default: completion(.disambiguation(with: titles))
    }
  }

  func confirm(intent: INSearchForNotebookItemsIntent,
               completion: @escaping (INSearchForNotebookItemsIntentResponse) -> Void) {
    let isWeekend = Calendar(identifier: .gregorian).isDateInWeekend(Date())
    let code: INSearchForNotebookItemsIntentResponseCode =  isWeekend ? .failure : .success
    completion(.init(code: code, userActivity: nil))
  }

  func handle(intent: INSearchForNotebookItemsIntent,
              completion: @escaping (INSearchForNotebookItemsIntentResponse) -> Void) {

    switch intent.itemType {
    case .task:
      LAContext().evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "reason description") { (accessGranted, error) in
        guard accessGranted else {
          completion(.init(code: .failureRequiringAppLaunch, userActivity: nil))
          return
        }

        let response = INSearchForNotebookItemsIntentResponse(code: .success, userActivity: nil)
        response.tasks = TaskProvider.fetchTasks(listName: intent.title!.spokenPhrase)
        completion(response)
      }

    case .taskList:
      let response = INSearchForNotebookItemsIntentResponse(code: .success, userActivity: nil)
      response.taskLists = TaskProvider.fetchTaskLists()
      completion(response)
    default: completion(.init(code: .failure, userActivity: nil))
    }
  }
}
