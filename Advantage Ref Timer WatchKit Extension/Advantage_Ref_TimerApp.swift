//
//  Advantage_Ref_TimerApp.swift
//  Advantage Ref Timer WatchKit Extension
//
//  Created by Donald Dang on 2022-06-03.
//

import SwiftUI

@main
struct Advantage_Ref_TimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
