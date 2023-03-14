//
//  AddView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject private var listViewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var text: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20.0) {
            TextField("Enter here...", text: $text)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Button {
                saveNewItem()
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add new todo")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    private func saveNewItem() {
        if isValidNewItem() {
            listViewModel.addItem(name: text)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func isValidNewItem() -> Bool {
        if text.count < 3 {
            alertTitle = "OOPPS! 😱"
            alertMessage = "The new todo item must be at least 3 characters long!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    private func getAlert() -> Alert {
        return Alert(title: Text(alertTitle), message: Text(alertMessage))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
