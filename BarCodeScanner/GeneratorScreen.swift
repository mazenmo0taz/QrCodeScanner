//
//  GeneratorScreen.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 04/11/2025.
//

import SwiftUI
struct GeneratorScreen: View {
    @State var viewModel = GeneratorScreenViewModel()
    var body: some View {
        VStack {
            TextField("enter your text to genrate code", text: $viewModel.textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if viewModel.textFieldText != "" {
                Image(uiImage: viewModel.generatedImage)
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 350, height: 350)
                    .aspectRatio(contentMode: .fill)
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350, height: 350)
                    .foregroundStyle(Color.gray.opacity(0.4))
            }
            Picker(viewModel.codeType.rawValue,selection: $viewModel.codeType) {
                ForEach(CodeType.allCases, id: \.self) { type in
                    Text("\(type.rawValue)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical,10)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertitem?.title ?? ""), message: Text(viewModel.alertitem?.message ?? ""), dismissButton: viewModel.alertitem?.dismissButton ?? .default(Text("OK")))
        }
        
    }
}
#Preview {
    GeneratorScreen()
}
