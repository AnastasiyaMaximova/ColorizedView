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
    @State private var redText = ""
    @State private var greenText = ""
    @State private var blueText = ""
    @State private var isPresented = false
    @State private var doneButtonPressed = false
    @State private var redValidateText = ""
    @State private var greenValidateText = ""
    @State private var blueValidateText = ""

    
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
                
                SliderView(
                    sliderColor: .red,
                    sliderValue: $redSliderValue,
                    text: $redText,
                    isPresented: $isPresented,
                    validatedText: $redValidateText,
                    doneButtonPressed: $doneButtonPressed
                )
                SliderView(
                    sliderColor: .green,
                    sliderValue: $greenSliderValue,
                    text: $greenText,
                    isPresented: $isPresented,
                    validatedText: $greenValidateText,
                    doneButtonPressed: $doneButtonPressed
                )
                SliderView(
                    sliderColor: .blue,
                    sliderValue: $blueSliderValue,
                    text: $blueText,
                    isPresented: $isPresented,
                    validatedText: $blueValidateText,
                    doneButtonPressed: $doneButtonPressed
                )
                Spacer()
            }
            .padding()
            .containerRelativeFrame([.horizontal, .vertical])
            .background(.cyan)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        doneButtonPressed = true
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.white)
                    )
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .shadow(radius: 3)
                    .alert("Wrong format!", isPresented: $isPresented){
                        Button("OK"){}
                    } message: {
                        Text("Please, enter correct value.")
                    }
                }
                
            }
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
    @Binding var text: String
    @Binding var isPresented: Bool
    @Binding var validatedText: String
    @Binding var doneButtonPressed: Bool
    
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
            .onAppear {
                text = string(value: sliderValue)
            }
            .onChange(of: sliderValue) {
                    text = string(value: sliderValue)

            }
            
            TextField("", text: $text)
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
                .frame(width: 60, height: 40, alignment: .center)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .onChange(of: text){
                    if doneButtonPressed{
                        if !isPresented{
                            validText()
                            setSlider()
                            doneButtonPressed.toggle()
                        }
                    }
                }
        }
                
        }
    
    private func validText(){
        guard let validText = Double(text) else {
            isPresented.toggle()
            return
        }
        if !(0...255).contains(validText){
            isPresented.toggle()
            return
        }
        validatedText = string(value: validText)
    
    }
    
    private func setSlider() {
        if let value = Double(validatedText) {
            sliderValue = value
        }
    }

}

private func string(value:Double) -> String {
    String(format: "%.0f", value)
}
