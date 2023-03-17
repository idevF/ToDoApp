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
    
    @State private var selectedDate: Date = Date()
    private let startingDate: Date = Calendar.current.startOfDay(for: Date())

    @State private var toggleIsOn: Bool = false

    var body: some View {
        VStack(spacing: 30.0) {
            TextField("Enter here...", text: $text)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color(uiColor: .systemGray4))
                .cornerRadius(10)
                .disableAutocorrection(true)

            Toggle(isOn: $toggleIsOn) {
                Text("Select a due date")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .tint(.accentColor)
            .padding()
            .background(Color(uiColor: .systemGray4))
            .cornerRadius(10)
            
            if toggleIsOn {
                DatePicker("Due Date",
                           selection: $selectedDate,
                           in: startingDate...,
                           displayedComponents: [.date, .hourAndMinute]
                )
                    .datePickerStyle(.compact)
                    .accentColor(Color.red)
                    .font(.headline)
                    .padding()
                    .background(Color(uiColor: .systemGray4))
                    .cornerRadius(10)
            }

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
        .navigationTitle("Add  🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
        .animation(.interactiveSpring(response: 1.5), value: toggleIsOn)
    }
    
    private func saveNewItem() {
        if isValidNewItem() {
            listViewModel.addItem(name: text,
                                  date: toggleIsOn ? selectedDate : Date.distantFuture)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func isValidNewItem() -> Bool {
        if text.count < 3 {
            alertTitle = "OOPPS! 😱"
            alertMessage = "The new text must be at least 3 characters long!"
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
