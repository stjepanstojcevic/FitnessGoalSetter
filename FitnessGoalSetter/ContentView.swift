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
    @State private var timeRemainingS: Double = 120
    @State private var goalPlank : Double = 100
    @State private var goalGB : Double = 100
    @State private var goalS : Double = 100
    @State private var isTimerRunningPlank = false
    @State private var isTimerRunningGB = false
    @State private var isTimerRunningS = false
    @State private var prikaz1 = false
    @State private var prikaz2 = false
    @State private var prikaz3 = false
    
    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer3 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter
    }()
    
    var body: some View {
        ZStack{
            VStack(spacing:10){
                //unos tablice treninga
                Text("Plank goal in seconds : ")
                    .font(.title2)
                    .padding()
                TextField("    ", value: $goalPlank, formatter: numberFormatter)
                    .fixedSize()
                    .keyboardType(.decimalPad).foregroundColor(Color.blue)
                Image("plankslika").resizable().frame(width: 90, height: 90).cornerRadius(35)
                    .shadow(color: Color.black.opacity(0.99), radius: 40, x: 0, y: 5)
                Text("Glute bridge goal in seconds : ")
                    .font(.title2)
                    .padding()
                TextField("    ", value: $goalGB, formatter: numberFormatter)
                    .fixedSize()
                    .keyboardType(.decimalPad).foregroundColor(Color(hue: 0.453, saturation: 0.858, brightness: 0.544))
                Image("glutebridgeslika").resizable().frame(width: 90, height: 90).cornerRadius(35)
                    .shadow(color: Color.black.opacity(0.99), radius: 40, x: 0, y: 5)
                Text("Squats goal in seconds : ")
                    .font(.title2)
                    .padding()
                TextField("    ", value: $goalS, formatter: numberFormatter)
                    .fixedSize()
                    .keyboardType(.decimalPad).foregroundColor(Color(hue: 0.934, saturation: 0.632, brightness: 0.769))
                Image("cucanjslika").resizable().frame(width: 90, height: 90).cornerRadius(35)
                    .shadow(color: Color.black.opacity(0.99), radius: 40, x: 0, y: 5)
                Spacer()
            }
            VStack{
                Spacer()
                Button(action: {withAnimation {prikaz1.toggle()}}) {
                        Text("Go hard and good luck")
                        .font(.title).fontWeight(.bold)
                        .padding().foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 100)
                                .fill(Color.red)
                                .shadow(color: Color.red.opacity(0.99), radius: 40, x: 0, y: 5))
                                .scaleEffect(0.7)}}
            .sheet(isPresented: $prikaz1){
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
                        Button(action: {
                            timeRemainingPlank = 30.0
                        },label: {Text("30  sec")
                            .foregroundColor(Color.yellow)}).frame(width: 350, height: 40).background(Color.black)
                            .cornerRadius(10)
                        Button(action: {
                            timeRemainingPlank = 60.0
                        },label: {Text("60  sec")
                            .foregroundColor(Color(hue: 0.111, saturation: 0.999, brightness: 0.917))}).frame(width: 350, height: 40).background(Color.black)
                            .cornerRadius(10)
                        Button(action: {
                            timeRemainingPlank = 90.0
                        },label: {Text("90  sec")
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
                    }}.sheet(isPresented: $prikaz2){
                    Form{
                        Section("Glute Bridge")
                        {
                            Button("Squats"){
                                prikaz3.toggle()
                            }
                            Text("Total time: \(String(format: "%.0f", goalGB)) sec")
                                .font(.title2)
                                .padding().bold()
                            Text("Time until the end of the current serie: \(String(format: "%.0f", timeRemainingGB)) sec")
                                .font(.title2)
                                .padding()
                            Slider(value: $timeRemainingGB, in: 0...120, step: 1)
                                .padding()
                                .accentColor(.red)
                            Button(action: {
                                timeRemainingGB = 30.0
                            },label: {Text("30  sec")
                                .foregroundColor(Color.yellow)}).frame(width: 350, height: 40).background(Color.black)
                                .cornerRadius(10)
                            Button(action: {
                                timeRemainingGB = 60.0
                            },label: {Text("60  sec")
                                .foregroundColor(Color(hue: 0.111, saturation: 0.999, brightness: 0.917))}).frame(width: 350, height: 40).background(Color.black)
                                .cornerRadius(10)
                            Button(action: {
                                timeRemainingGB = 90.0
                            },label: {Text("90  sec")
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
                            
                        }}.sheet(isPresented: $prikaz3){
                        Form{
                            Section("Squats")
                            {
                                
                                Text("Total time: \(String(format: "%.0f", goalS)) sec")
                                    .font(.title2)
                                    .padding().bold()
                                
                                Text("Time until the end of the current serie: \(String(format: "%.0f", timeRemainingS)) sec")
                                    .font(.title2)
                                    .padding()
                                
                                
                                Slider(value: $timeRemainingS, in: 0...120, step: 1)
                                    .padding()
                                    .accentColor(.red)
                                Button(action: {
                                    timeRemainingS = 30.0
                                },label: {Text("30  sec")
                                    .foregroundColor(Color.yellow)}).frame(width: 350, height: 40).background(Color.black)
                                    .cornerRadius(10)
                                Button(action: {
                                    timeRemainingS = 60.0
                                },label: {Text("60  sec")
                                    .foregroundColor(Color(hue: 0.111, saturation: 0.999, brightness: 0.917))}).frame(width: 350, height: 40).background(Color.black)
                                    .cornerRadius(10)
                                Button(action: {
                                    timeRemainingS = 90.0
                                },label: {Text("90  sec")
                                    .foregroundColor(Color.red)}).frame(width: 350, height: 40).background(Color.black)
                                    .cornerRadius(10)
                                Button(action: {isTimerRunningS.toggle()})
                                {
                                    Text(isTimerRunningS ? "Pause" : "Start")
                                        .font(.title)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }}
                            .onReceive(timer3) { _ in
                                if isTimerRunningS && timeRemainingS > 0 {
                                    timeRemainingS = timeRemainingS - 1
                                    goalS = goalS - 1
                                }
                                if goalS==0{
                                    self.timer3.upstream.connect().cancel()
                                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)){}
                                }}}}}}}}}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

