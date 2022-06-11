//
//  ContentView.swift
//  Advantage Ref Timer WatchKit Extension
//
//  Created by Donald Dang on 2022-06-03.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var secondScreenShown = false
        @State var timerVal = 60

        var body: some View {
            
            NavigationView {
             
                VStack{
                    Picker(selection: $timerVal, label: Text("Set Half Time")) {
                        Text("1").tag(60)
                        Text("2").tag(120)
                        Text("20").tag(1200)
                        Text("25").tag(1500)
                        Text("30").tag(1800)
                        Text("35").tag(2100)
                        Text("40").tag(2400)
                        Text("45").tag(2700)
                        
                    }.onChange(of: timerVal) { val in
                        self.secondScreenShown = true
                    }
                    
                    
                    NavigationLink(destination: SecondView(secondScreenShown: $secondScreenShown, timerVal: timerVal), isActive: $secondScreenShown) {
                        Text("Set Half!")
                    }.simultaneousGesture(TapGesture().onEnded {
                        
                        //Trying to enable notifications when the user presses "Set Half"

                        let center = UNUserNotificationCenter.current()

                        let content = UNMutableNotificationContent()
                        content.title = "Half Time Over!"
                        content.subtitle = "Add Stoppage Time?"

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timerVal), repeats: false)

                        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)

                        UNUserNotificationCenter.current().add(request)
                    })
                }
            }
        }
}
struct SecondView: View {
    @Binding var secondScreenShown: Bool
    @State var timerVal: Int
    @State var stoppage: Int = 60
    @State var overtime: Bool = false
    
    var body: some View {
            VStack{
                if timerVal > 0 || overtime {
                    Text("Time Remaining in Half")
                        .font(.system(size: 14))
                    HStack(spacing: 33){
                        Text("\(timerVal / 60)")
                            .font(.system(size: 40))
                        Text("\(timerVal % 60)")
                            .font(.system(size: 40))
                            .onAppear(){
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { inv in
                                    if self.timerVal > 0 {
                                        self.timerVal -= 1
                                        if self.timerVal == 0 {
                                            inv.invalidate()
                                        }
                                    }
                                }
                            }
                        
                    }
                    HStack{
                        Text("Minutes")
                            .font(.system(size: 14))
                        Text("seconds")
                            .font(.system(size: 14))
                    }
                    Button(action: {
                        self.secondScreenShown = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
    
                } else {
                    
                    VStack{
                        Picker(selection: $stoppage, label: Text("Add Stoppage Time?")) {
                            Text("1").tag(60)
                            Text("2").tag(120)
                            Text("3").tag(180)
                            Text("4").tag(240)
                            Text("5").tag(300)
                            Text("6").tag(360)
                            Text("7").tag(420)
                            Text("8").tag(480)
                            Text("9").tag(540)
                        }
                        Button(action: {
                            self.timerVal = self.stoppage
                            self.overtime = true
                        }) {
                            Text("Add Stoppage")
                                .foregroundColor(.green)
                        }
                        Button(action: {
                            self.secondScreenShown = false
                        }) {
                            Text("Done")
                                .foregroundColor(.red)
                        }
                        
                    }
                    
            }

            }
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

