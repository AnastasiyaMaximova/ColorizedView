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
    @State private var redText = "0,5"
    @State private var greenText = "0,5"
    @State private var blueText = "0,5"
    @State private var isPresented = false
    @State private var validateText = ""
   
  
    
    var body: some View {
        VStack {
            Color(
                red: redSliderValue,
                green: greenSliderValue,
                blue: blueSliderValue
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white, lineWidth: 6)
                )
                .frame(height: 200)
                .padding(.bottom, 20)
            
            SliderView(
                sliderValue: $redSliderValue,
                sliderColor: SliderColor.red.color,
                text: $redText,
                isPresented: $isPresented,
                validatedText: $validateText
            )
            SliderView(
                sliderValue: $greenSliderValue,
                sliderColor: SliderColor.green.color,
                text: $greenText,
                isPresented: $isPresented,
                validatedText: $validateText
            )
            SliderView(
                sliderValue: $blueSliderValue,
                sliderColor: SliderColor.blue.color,
                text: $blueText,
                isPresented: $isPresented,
                validatedText: $validateText
            )
            Spacer()
        }
        .padding()
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.cyan)
        
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done"){
                }
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(.white)
                )
                .foregroundStyle(.black)
                .font(.headline)
                .shadow(radius: 3)
                .alert("Wrong format!", isPresented: $isPresented){
                    Button("OK"){}
                } message: {
                    Text("Please, enter correct value.")
                }
            }
        }
    }
    
    private enum SliderColor {
        case red
        case green
        case blue
        var color: Color {
            switch self{
            case .red: return .red
            case .green: return .green
            case .blue: return .blue
            }
        }
    }
    
    private func validText(text: String?){
        guard let validText = text else {return}
        if validText.isEmpty || !(0...255).contains(Double(validText) ?? 0){
            isPresented.toggle()
            return
        }
        switch validText {
        case redText:
            validateText = redText
            redSliderValue = Double(validText) ?? 0
        case greenText:
            validateText = greenText
            greenSliderValue = Double(validText) ?? 0
        default:
            validateText = blueText
            blueSliderValue = Double(validText) ?? 0
        }
    }
//    private func setColor() -> Color {
//        return Color(
//                red: redSliderValue,
//                green: greenSliderValue,
//                blue: blueSliderValue
//                )
//    }

//    private func setColor() {
//        colorView.backgroundColor = UIColor(
//            red: CGFloat(redSlider.value),
//            green: CGFloat(greenSlider.value),
//            blue: CGFloat(blueSlider.value),
//            alpha: 1
//        )
//    }
    
    
    
}

#Preview {
    ContentView()
}

struct SliderView: View {
    
    @Binding var sliderValue: Double
    var sliderColor: Color
    @Binding var text: String
    @Binding var isPresented: Bool
    @Binding var validatedText: String
    
    var body: some View {
        HStack{
            Text(sliderValue.formatted())
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
            
            TextField("", text: $text)
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
                .frame(width: 60, height: 40, alignment: .center)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
//                .toolbar{
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Button("Done"){
//                           validText()
//                            sliderValue = Double(validatedText) ?? 0
//                        }
//                        .background(
//                            RoundedRectangle(cornerRadius: 6, style: .continuous)
//                                .fill(.white)
//                        )
//                        .foregroundStyle(.black)
//                        .font(.headline)
//                        .shadow(radius: 3)
//                        .alert("Wrong format!", isPresented: $isPresented){
//                            Button("OK"){
//                                text = ""
//                            }
//                        } message: {
//                            Text("Please, enter correct value.")                            }
//                    }
//                }
        }
                
        }
    
    private func validText(){
        if text.isEmpty || !(0...255).contains(Double(text)!){
            isPresented.toggle()
            return
        }
        validatedText = text
    
    }
    
}
