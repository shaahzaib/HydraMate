//
//  HomeView.swift
//  HydrateMate
//
//  Created by Macbook Pro on 26/05/2025.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    
    //MARK: - State Properties
    
    // in liters
    @State private var dailyWaterGoal:Double=2.0
    // in liters
    @State private var waterConsumed: Double = 0.0
    //in hours
    @State private var reminderInterval:Double=1.0
    //wake up time
    @State private var wakeUpTime:Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
   //sleep time
    @State private var sleepTime:Date = Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date()
    
    @State private var notificationsEnabled: Bool = false
    // inncrement for quick add button
    let waterIncrement:[Double] = [0.1,0.2,0.3,0.4,0.5]
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan,Color.purple]), startPoint:.topLeading , endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                ScrollView{
                    
                    VStack{
                       
                        waterProgressView
                        
                        ConsumptionControl
                        
                        reminderSettingSection
                        
                        notificationSettingsSection
                        
                    }
                    .padding()
                    
                }
                .navigationTitle("Keep Yourself Hydrated")
                
            }
            .accentColor(.cyan)
        }
    }
    
    
    
    //MARK: -WaterProgress View
    
    private var waterProgressView:some View{
        VStack(spacing:20){
            ZStack{
                // base circle
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.5)
                    .foregroundStyle(.gray)
                
                // percentage of goal reach
                
                Circle()
                    .trim(from: 0.0,to: CGFloat(min(self.waterConsumed/self.dailyWaterGoal,1)))
                    .stroke(style: StrokeStyle(lineWidth: 15,lineCap: .round))
                    .foregroundStyle(.blue)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.spring(), value: waterConsumed)
                
                
                // text inside circle
                
                VStack{
                    Text("\(Int(waterConsumed / dailyWaterGoal) * 100)%")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("\(String(format:"%.1f" , waterConsumed)) / \(String(format:"%.1f" , dailyWaterGoal))L")
                        .font(.headline)
                        
                        .foregroundStyle(.white)
                }
                
            }
            .frame(width: 200, height: 200)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange,Color.cyan]), startPoint: .top, endPoint: .bottom
                )
                .clipShape(Circle())
                .shadow(radius: 10)
                
            )
            
            // daily goal
            Text("Daily Goal: \(String(format: "%.1f",dailyWaterGoal))L")
                .font(.title3)
                .foregroundStyle(.white)
            
            // adjust daily goal
            
            Slider(value: $dailyWaterGoal,in: 1...4,step: 0.5)
                .padding(.horizontal)
            
            // current goal
            
            Text("Set your target: \(String(format: "%.1f",dailyWaterGoal))liters")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding()
        .background(.white.opacity(0.2))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
    // MARK: - Water ConsumptionControl
    
    private var ConsumptionControl:some View{
        
        VStack{
            Text("Add Water")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
            
            HStack{
                Group{
                    // add 100ml
                    ZStack{
                        Button {
                            addwater(0.1)
                        } label: {
                            VStack{
                                Image(systemName: "drop.fill")
                                Text("100ml").tint(.white)
                                    .font(.callout)
                            }
                        }
                    } .padding()
                        .frame(width: 80, height: 80)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple,Color.cyan]), startPoint: .top, endPoint: .bottom
                            ))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    // 200ml
                    ZStack{
                        Button {
                            addwater(0.2)
                        } label: {
                            VStack{
                                Image(systemName: "drop.fill")
                                Text("200ml").tint(.white)
                                    .font(.callout)
                            }
                        }
                    } .padding()
                        .frame(width: 80, height: 80)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple,Color.cyan]), startPoint: .top, endPoint: .bottom
                            ))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    // 300ml
                    ZStack{
                        Button {
                            addwater(0.3)
                        } label: {
                            VStack{
                                Image(systemName: "drop.fill")
                                Text("300ml").tint(.white)
                                    .font(.callout)
                            }
                        }
                    } .padding()
                        .frame(width: 80, height: 80)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple,Color.cyan]), startPoint: .top, endPoint: .bottom
                            ))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    // 500ml
                    ZStack{
                        Button {
                            addwater(0.5)
                        } label: {
                            VStack{
                                Image(systemName: "drop.fill")
                                Text("500ml").tint(.white)
                                    .font(.callout)
                            }
                        }
                    } .padding()
                        .frame(width: 80, height: 80)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple,Color.cyan]), startPoint: .top, endPoint: .bottom
                            ))
                        .cornerRadius(20)
                        .shadow(radius: 1)
                    
                }
                
            }
           
            Button {
                resetWaterConsumed()
            } label: {
                Text("Reset")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.purple)
                    .cornerRadius(20)
                    .padding(.vertical,10)
            }

            
        }.padding()
            .background(.white.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 5)
    
    }
    
    
    //MARK: - Reminder Section
    
    
    //reminder interval and active hours
    
    private var reminderSettingSection:some View{
        VStack(alignment: .leading,spacing: 10){
            
            Text("Reminder Setting")
                .font(.headline)
                .foregroundStyle(.white)
            
            HStack{
                Text("Interval")
                    .foregroundStyle(.white)
                Spacer()
                Text("\(Int(reminderInterval))hrs")
                    .foregroundStyle(.white)
            }
            
            // re minder interval slider
            Slider(value: $reminderInterval, in: 0.5...4,step: 0.5)
            
            
            //wakeUp
            HStack{
                Text("WakeUp time: ").foregroundStyle(.white)
                Spacer()
                DatePicker("", selection: $wakeUpTime,displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            
            //sleepTime
            HStack{
                Text("Sleep time: ").foregroundStyle(.white)
                Spacer()
                DatePicker("", selection: $sleepTime,displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    
            }
        }.padding()
            .background(.white.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 5)
    }
    
    
    
    //MARK: - Notification  Section
    
    private var notificationSettingsSection:some View{
        VStack(alignment: .leading,spacing: 20){
            HStack{
                Text("Notification")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Toggle("",isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) {  newValue in
                        if newValue{
                            // user permission
                            requestNotificationPermission()
                            // schedule notifications
                            scheduleNotifications()
                            
                        }
                        else{
                            // remove pending notifications
                            cancelAllNotifications()
                        }
                    }
               
                }
            if notificationsEnabled{
                Text("Notifications will fire every \(wakeUpTime) hrs between \(formatTime(wakeUpTime)) and \(formatTime(sleepTime)).")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }.padding()
            .background(.white.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 5)
        
        
    }
    
    
    //MARK: - ActionMethods
    
    func addwater(_ amount:Double){
        if (waterConsumed + amount <= dailyWaterGoal * 1.5){
            waterConsumed += amount
        }
    }
    
    func resetWaterConsumed(){
        waterConsumed = 0.0
    }
    
    
    private  func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){granted , error in
            if !granted{
                print("Notification permission denied!")
            }
            
        }
    }
    
    
    private  func scheduleNotifications(){
        cancelAllNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "Time to hydrate"
        content.body = "stay healthy, take a sip of water!"
        content.sound = UNNotificationSound.default
        
        
        
        // minute and hour from wakeUp and sleep time
        
        let wakeUpHour = Calendar.current.component(.hour, from: wakeUpTime)
        let wakeUpMin = Calendar.current.component(.minute, from: wakeUpTime)
        let sleepHour = Calendar.current.component(.hour, from: sleepTime)
        let sleepMin = Calendar.current.component(.minute, from: sleepTime)
        
        
        // wakeUp time scheduling
        var nextDate = Calendar.current.date(bySettingHour: wakeUpHour, minute: wakeUpMin, second: 0, of: Date())!
        
        //loop until reaching sleep time
        
        while Calendar.current.component(.hour, from: nextDate) <= sleepHour &&
                Calendar.current.component(.minute, from: nextDate) <= sleepMin{
            let components = Calendar.current.dateComponents([.hour,.minute], from: nextDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "WaterReminder-\(components.hour!)-\(components.minute!)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            
            
            // next reminder interval
            nextDate = Calendar.current.date(byAdding: .hour,value: Int(reminderInterval), to: nextDate)!
        }
    }
    
    // clear all pending notifications
    private func  cancelAllNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func formatTime(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    
}

#Preview {
    HomeView()
}
