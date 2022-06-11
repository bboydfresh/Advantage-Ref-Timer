//
//  Advantage_Ref_TimerApp.swift
//  Advantage Ref Timer WatchKit Extension
//
//  Created by Donald Dang on 2022-06-03.
//

import SwiftUI
import UserNotifications
@main
struct Advantage_Ref_TimerApp: App {
    
    init(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
