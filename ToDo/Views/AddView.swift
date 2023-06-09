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
    @Environment(\.dismiss) private var dismiss
    
    // for the textfield
    @State private var text: String = ""
    
    // for the alert
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    @State private var toggleIsOn: Bool = false

    // MARK: BODY
    
    var body: some View {
        VStack(spacing: 30.0) {
            
            addItemTextfield

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
            .background(Color(uiColor: .systemGray5))
            .cornerRadius(10)
            .disableAutocorrection(true)
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
        .disabled(text.isEmpty)
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
            listViewModel.addItem(name: text)
            // dismiss from AddView
            dismiss()
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
