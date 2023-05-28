//
//  ContentView.swift
//  FitnessGoalSetter
//
//  Created by Stjepan Stojčević on 28.05.2023..
//

import SwiftUI

struct ContentView: View {
    @State public var timeRemaining : Double = 120
    @State private var isTimerRunning = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Fitness Goal Setter")
                .font(.title)
                .padding()
            Spacer()

            Text("Time: \(String(format: "%.0f", timeRemaining)) sec")
                .font(.title2)
                .padding()
            
            Slider(value: $timeRemaining, in: 0...120, step: 1)
                            .padding()
                            .accentColor(.red)
            Spacer()
            HStack{
                Spacer()
                VStack(spacing: 20){
                    Button(action: self.set(num: 30.0),label: {Text("30  sec")
                        .foregroundColor(Color.yellow)}).frame(width: 180, height: 40).background(Color.black)
                        .cornerRadius(10)
                    
                    Button(action: self.set(num: 90.0),label: {Text("90  sec")
                        .foregroundColor(Color(hue: 0.073, saturation: 1.0, brightness: 1.0))}).frame(width: 180, height: 40).background(Color.black)
                        .cornerRadius(10)
                }
                VStack(spacing: 20){
                    Button(action: self.set(num: 60.0),label: {Text("60  sec")
                        .foregroundColor(Color(hue: 0.111, saturation: 0.999, brightness: 0.917))}).frame(width: 180, height: 40).background(Color.black)
                        .cornerRadius(10)
                    Button(action: self.set(num: 120.0),label: {Text("120  sec")
                            .foregroundColor(Color(hue: 1.0, saturation: 1.0, brightness: 0.811))
                        }).frame(width: 180, height: 40).background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            
            Spacer()
            Button(action: {isTimerRunning.toggle()})
            {
                    Text(isTimerRunning ? "Pause" : "Start")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        }}
                    .onReceive(timer) { _ in
                        if isTimerRunning && timeRemaining > 0 {
                            timeRemaining -= 1
                        }
        }
    }
    
    func set(num: Double) -> () -> Void
        {
            return {timeRemaining=num}
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

