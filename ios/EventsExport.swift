//
//  EventsExportModule.swift
//  React-Native-Events-Export
//
//  Created by phelpsandrew on 12/22/25.
//

import Foundation
import React
import EventKit
import EventKitUI

@objc(EventsExportModule)
class EventsExportModule: NSObject, RCTBridgeModule, EKEventEditViewDelegate {
  
  static func moduleName() -> String! {
    return "EventsExportModule"
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  private let eventStore = EKEventStore()
  private var resolver: RCTPromiseResolveBlock?
  
  @objc
  func addEventWithEditor(
    _ title: String,
    startDate: Double,
    endDate: Double,
    location: String?,
    resolver resolve: @escaping RCTPromiseResolveBlock,
    rejecter reject: @escaping RCTPromiseRejectBlock
  ){
    DispatchQueue.main.async {
      self.resolver = resolve
      
      guard let rootVC = RCTPresentedViewController() else {
        reject("no_view_controller", "Unable to find the root view controller", nil)
        return
      }
      
      let event = EKEvent(eventStore: self.eventStore)
      event.title = title
      event.startDate = Date(timeIntervalSince1970: startDate / 1000)
      event.endDate = Date(timeIntervalSince1970: endDate / 1000)
      event.location = location
      
      let editor = EKEventEditViewController()
      editor.eventStore = self.eventStore
      editor.event = event
      editor.editViewDelegate = self
      
      rootVC.present(editor, animated: true)
    }
  }
  
  func eventEditViewController(
    _ controller: EKEventEditViewController,
    didCompleteWith action: EKEventEditViewAction
  ){
    controller.dismiss(animated: true)
    
    guard let resolve = resolver else { return }
    
    switch action {
      case .saved:
        resolve("saved")
      case .canceled:
        resolve("canceled")
      case .deleted:
        resolve("deleted")
      @unknown default:
        resolve("unknown")
    }
    
    resolver = nil
  }
}
