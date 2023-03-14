//
//  AddView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct AddView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 20.0) {
            TextField("Enter here...", text: $text)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Button {
                //
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
