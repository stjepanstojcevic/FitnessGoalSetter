//
//  ContentView.swift
//  FitnessGoalSetter
//
//  Created by Stjepan Stojčević on 28.05.2023..
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    @State private var timeRemainingPlank : Double = 120
    @State private var timeRemainingGB : Double = 120
    @State private var goalPlank : Double = 100
    @State private var goalGB : Double = 100
    @State private var isTimerRunningPlank = false
    @State private var isTimerRunningGB = false
    @State private var prikaz1 = false
    @State private var prikaz2 = false

    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter
    }()

    var body: some View {
        VStack(spacing:10){
            //unos tablice treninga
            Text("PLANK Goal(in seconds) : ")
                .font(.title2)
                .padding()
            TextField("    ", value: $goalPlank, formatter: numberFormatter)
                    .fixedSize()
                    .keyboardType(.decimalPad)
            Text("GLUTE BRIDGE Goal(in seconds) : ")
                .font(.title2)
                .padding()
            TextField("    ", value: $goalGB, formatter: numberFormatter)
                    .fixedSize()
                    .keyboardType(.decimalPad)
            Button("Go hard and good luck"){
                prikaz1.toggle()
            }.sheet(isPresented: $prikaz1)
            {
                Form{
                    Section("Plank")
                    {
                        Button("Glute Bridge"){
                            prikaz2.toggle()
                        }
            
                        
                            
                            Text("Total time: \(String(format: "%.0f", goalPlank)) sec")
                                .font(.title2)
                                .padding().bold()
                        
                            Text("Time until the end of the current serie: \(String(format: "%.0f", timeRemainingPlank)) sec")
                                .font(.title2)
                                .padding()
                            
                        
                            Slider(value: $timeRemainingPlank, in: 0...120, step: 1)
                                .padding()
                                .accentColor(.red)
                            Button(action: self.setPlank(num: 30.0),label: {Text("30  sec")
                                        .foregroundColor(Color.yellow)}).frame(width: 350, height: 40).background(Color.black)
                                        .cornerRadius(10)
                            Button(action: self.setPlank(num: 60.0),label: {Text("60  sec")
                                        .foregroundColor(Color(hue: 0.111, saturation: 0.999, brightness: 0.917))}).frame(width: 350, height: 40).background(Color.black)
                                        .cornerRadius(10)
                            Button(action: self.setPlank(num: 90.0),label: {Text("90  sec")
                                .foregroundColor(Color.red)}).frame(width: 350, height: 40).background(Color.black)
                                    .cornerRadius(10)
                            Button(action: {isTimerRunningPlank.toggle()})
                            {
                                Text(isTimerRunningPlank ? "Pause" : "Start")
                                    .font(.title)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }}
                        .onReceive(timer1) { _ in
                            if isTimerRunningPlank && timeRemainingPlank > 0 {
                                timeRemainingPlank = timeRemainingPlank - 1
                                goalPlank = goalPlank - 1
                            }
                            if goalPlank==0{
                                self.timer1.upstream.connect().cancel()
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)){}
                            }
                            
                        
                        Button("Done"){
                            prikaz1.toggle()
                        }
                    }
                    
                }.sheet(isPresented: $prikaz2){
                    Form{
                        Section("Glute Bridge")
                        {
                            
                            Text("Total time: \(String(format: "%.0f", goalGB)) sec")
                                .font(.title2)
                                .padding().bold()
                        
                            Text("Time until the end of the current serie: \(String(format: "%.0f", timeRemainingGB)) sec")
                                .font(.title2)
                                .padding()
                            
                        
                            Slider(value: $timeRemainingGB, in: 0...120, step: 1)
                                .padding()
                                .accentColor(.red)
                            Button(action: self.setGB(num: 30.0),label: {Text("30  sec")
                                        .foregroundColor(Color.yellow)}).frame(width: 350, height: 40).background(Color.black)
                                        .cornerRadius(10)
                            Button(action: self.setGB(num: 60.0),label: {Text("60  sec")
                                        .foregroundColor(Color(hue: 0.111, saturation: 0.999, brightness: 0.917))}).frame(width: 350, height: 40).background(Color.black)
                                        .cornerRadius(10)
                            Button(action: self.setGB(num: 90.0),label: {Text("90  sec")
                                .foregroundColor(Color.red)}).frame(width: 350, height: 40).background(Color.black)
                                    .cornerRadius(10)
                            Button(action: {isTimerRunningGB.toggle()})
                            {
                                Text(isTimerRunningGB ? "Pause" : "Start")
                                    .font(.title)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }}
                        .onReceive(timer2) { _ in
                            if isTimerRunningGB && timeRemainingGB > 0 {
                                timeRemainingGB = timeRemainingGB - 1
                                goalGB = goalGB - 1
                            }
                            if goalGB==0{
                                self.timer2.upstream.connect().cancel()
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)){}
                            }
                       
                            
                        }
                    }
                }
            }
            
        }}
    
    func setPlank(num: Double) -> () -> Void
        {
            return {timeRemainingPlank=num}
        }
    func setGB(num: Double) -> () -> Void
        {
            return {timeRemainingGB=num}
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

