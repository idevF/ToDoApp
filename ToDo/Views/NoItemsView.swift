//
//  NoItemsView.swift
//  ToDo
//
//  Created by idevF on 15.03.2023.
//

import SwiftUI

struct NoItemsView: View {
    
    @State private var isAnimated: Bool = false
    private let secondaryAccentColor = Color("SecondaryAccentColor")
    
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
                    .padding()
                    .background(isAnimated ? Color.accentColor : secondaryAccentColor)
                    .cornerRadius(10)
            }
            .rotationEffect(Angle(degrees: isAnimated ? 360 : 0), anchor: .bottom)
            .animation(.spring(response: 1.7, dampingFraction: 0.5).repeatForever(), value: isAnimated)
            .scaleEffect(isAnimated ? 1.5 : 1.0)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(40)
        .onAppear(perform: startAnimation)
    }
    
    func startAnimation() {
        guard !isAnimated else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
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
