//
//  ContentView.swift
//  ColorizedView
//
//  Created by Anastasya Maximova on 22.01.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        VStack {
            Color(setColor())
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white, lineWidth: 6)
            )
            .frame(height: 200)
            .padding(.bottom, 20)
            
            SliderView(sliderColor: .red, sliderValue: $redSliderValue)
            SliderView(sliderColor: .green, sliderValue: $greenSliderValue)
            SliderView(sliderColor: .blue, sliderValue: $blueSliderValue)
            Spacer()
        }
        .padding()
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.cyan)
    }
    
    private func setColor() -> Color {
        return  Color(
            red: redSliderValue/255,
            green: greenSliderValue/255,
            blue: blueSliderValue/255
        )
    }
}

#Preview {
    ContentView()
}

struct SliderView: View {
    var sliderColor: Color
    @Binding var sliderValue: Double
    
    var body: some View {
        HStack{
            Text(string(value: sliderValue))
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 60, height: 40, alignment: .center)
            Slider(
                value: $sliderValue,
                in: 0...250,
                step: 1
            )
            .tint(sliderColor)
            .padding(.horizontal, 5)
        }
    }
    
    private func string(value:Double) -> String {
        String(format: "%.0f", value)
    }
}

