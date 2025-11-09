//
//  GeneratorScreen.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 04/11/2025.
//

import SwiftUI
struct GeneratorScreen: View {
    @State var viewModel = GeneratorScreenViewModel()
    @State var isPresented: Bool = false
    var body: some View {
        VStack {
            Text("Generate your Code")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
               
            TextField("enter your text to genrate code", text: $viewModel.textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 25)
                .padding()
                
            
            Picker(viewModel.codeType.rawValue,selection: $viewModel.codeType) {
                ForEach(CodeType.allCases, id: \.self) { type in
                    Text("\(type.rawValue)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if viewModel.textFieldText != "" {
                Image(uiImage: (viewModel.generatedImage ?? UIImage(systemName: "xmark"))!)
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 350, height: .infinity)
                    .aspectRatio(contentMode: .fill)
                    .padding(.vertical,20)
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350, height: .infinity)
                    .foregroundStyle(Color.gray.opacity(0.4))
                    .padding(.vertical,20)
            }
            
            HStack(){
                Button{
                    viewModel.shareImage()
                } label: {
                    CustomButtonView(text: "Share", imageName: "square.and.arrow.up",color: .cyan)
                }
                Button{
                    viewModel.saveImage()
                } label: {
                   CustomButtonView(text: "Save", imageName: "square.and.arrow.down")
                }
            
            }
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
           ShareSheet(items: [viewModel.generatedImage!])
        }
        .alert(item: $viewModel.alertitem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct CustomButtonView: View {
    var text: String
    var imageName: String
    var color: Color = .green
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(5)
            Text(text)
                .font(.title3)
                .bold()
        }
        .frame(width: 150, height: 65)
        .background(color.opacity(0.5))
        .cornerRadius(20)
        .padding(25)
    }
}
#Preview {
    GeneratorScreen()
}


