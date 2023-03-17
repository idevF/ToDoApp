//
//  AddView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct AddView: View {
    
    // MARK: PROPERTIES
    
    @EnvironmentObject private var listViewModel: ListViewModel
    
    // for dismiss from AddView
    @Environment(\.presentationMode) var presentationMode
    
    // for the textfield
    @State private var text: String = ""
    
    // for the alert
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    // for the date picker
    @State private var selectedDate: Date = Date()
    private let startingDate: Date = Calendar.current.startOfDay(for: Date())

    @State private var toggleIsOn: Bool = false

    // MARK: BODY
    
    var body: some View {
        VStack(spacing: 30.0) {
            
            addItemTextfield

            dueDateSelectionButton
            
            // shows date picker if the toggle button is on
            if toggleIsOn {
                dueDatePicker
            }

            saveButton
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add  🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
        .animation(.interactiveSpring(response: 1.5), value: toggleIsOn)
    }
}

// MARK: PREVIEW

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}

// MARK: COMPONENTS

extension AddView {

    private var addItemTextfield: some View {
        TextField("Enter here...", text: $text)
            .font(.headline)
            .frame(height: 55)
            .padding(.horizontal)
            .background(Color(uiColor: .systemGray4))
            .cornerRadius(10)
            .disableAutocorrection(true)
    }
    
    private var dueDateSelectionButton: some View {
        Toggle(isOn: $toggleIsOn) {
            Text("Select a due date")
                .font(.headline)
                .fontWeight(.semibold)
        }
        .tint(.accentColor)
        .padding()
        .background(Color(uiColor: .systemGray4))
        .cornerRadius(10)
    }
    
    private var dueDatePicker: some View {
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
    
    /// This button saves the entered data and returns to ListView.
    private var saveButton: some View {
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
    }
}

// MARK: FUNCTIONS

extension AddView {
    
    /// Saves the entered text and due date(if exists).
    ///
    /// This function adds the entered text and due date(if exists) to the list array of ListViewModel. And dismiss from AddView immediately.
    ///
    ///
    private func saveNewItem() {
        if isValidNewItem() {
            listViewModel.addItem(name: text,
                                  date: toggleIsOn ? selectedDate : Date.distantFuture)
            // dismiss from AddView
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    /// Validates the entered text in the textfield.
    ///
    /// This function validates the entered text and returns a Boolean. Alert title and message defined in this function.
    ///
    /// - Returns: Returns a Boolean.
    ///
    private func isValidNewItem() -> Bool {
        if text.count < 3 {
            alertTitle = "OOPPS! 😱"
            alertMessage = "The new text must be at least 3 characters long!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    /// Gets an alert with a title and a message.
    ///
    /// This function creates and return an alert. The alert has a title and a message defined in the isValidNewItem function.
    ///
    /// - Returns: Returns an alert with a title and a message.
    ///
    private func getAlert() -> Alert {
        return Alert(title: Text(alertTitle), message: Text(alertMessage))
    }
}
