//
//  NoItemsView.swift
//  ToDo
//
//  Created by idevF on 15.03.2023.
//

import SwiftUI

struct NoItemsView: View {
    
    @State private var isAnimated: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Text("NO ITEMS!   🤔")
                .font(.title2)
                .fontWeight(.medium)

            Text("Press the button below to add your first todo!")
                .padding(.bottom, 50)
            
            NavigationLink(destination: AddView()) {
                Text("Press to add\n your first todo!\n 🥳")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 100)
                    .padding(.horizontal, isAnimated ? 20 : 80)
                    .background(isAnimated ? Color.accentColor : secondaryAccentColor)
                    .cornerRadius(10)
            }
            .shadow(color: isAnimated ? secondaryAccentColor : Color.accentColor,
                    radius: isAnimated ? 80 : 20)
            .scaleEffect(isAnimated ? 1.3 : 1.0)
            .offset(y: isAnimated ? -10 : 0)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
        .onAppear(perform: startAnimation)
    }
    
    func startAnimation() {
        guard !isAnimated else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 2.5).repeatForever()) {
                isAnimated.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
        }
    }
}
