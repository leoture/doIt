//
//  IntentHandler.swift
//  SiriExtension
//
//  Created by jordhan leoture on 24/05/2018.
//  Copyright © 2018 jordhan leoture. All rights reserved.
//

import Intents

class IntentHandler: INExtension {

  override func handler(for intent: INIntent) -> Any? {
    switch intent {
    case is INSearchForNotebookItemsIntent: return SearchForNotebookItemsIntentHandler()
    default: return .none
    }
  }
  
}

