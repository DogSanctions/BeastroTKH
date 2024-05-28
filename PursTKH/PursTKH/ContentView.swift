//
//  ContentView.swift
//  PursTKH
//
//  Created by Jared Hubbard on 5/26/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BusinessHoursViewModel()
    @State private var showFullHours = false
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            // Background Image
            Image("restaurant")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title
                Text("BEASTRO by \nMarshawn Lynch")
                    .font(.system(size: 54, weight: .black))
                    .foregroundColor(.white)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .frame(width: 346, height: 216, alignment: .topLeading)
                    .padding(.top, 21)
                    .padding(.leading, 23)
                
                // Spacer to push content below
                Spacer().frame(height: 30)
                
                // Hours of operation card
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Open until 7pm")
                            .font(.custom("Hindi Siliguri", size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                        Spacer()
                        Image(systemName: showFullHours ? "chevron.up" : "chevron.right")
                            .foregroundColor(.black)
                    }
                    
                    Text("SEE FULL HOURS")
                        .font(.custom("Chivo", size:12))
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    
                    if showFullHours {
                        Divider().padding(.vertical, 8)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(viewModel.businessHours) { hour in
                                VStack(alignment: .leading) {
                                    Text(hour.dayOfWeek)
                                        .font(.headline)
                                    Text("\(hour.startLocalTime) - \(hour.endLocalTime)")
                                        .font(.subheadline)
                                }
                                .cornerRadius(5)
                            }
                        }
                    }
                }
                .padding(8)
                .frame(width: 346, height: showFullHours ? nil : 81, alignment: .topLeading)
                .background(Color.white.opacity(0.6))
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.25), radius: 10.2, x: 0, y: 4)
                .onTapGesture {
                    withAnimation {
                        showFullHours.toggle()
                    }
                }
                
                Spacer()
                
                // View Menu Button
                Button(action: {
                    showMenu.toggle()
                }) {
                    VStack {
                        Image(systemName: showMenu ? "chevron.down" : "chevron.up")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .opacity(0.5)
                        Image(systemName: showMenu ? "chevron.down" : "chevron.up")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Text("View Menu")
                            .font(.title2)
                            .foregroundColor(.white) // Text color
                    }
                    .padding()
                    .background(Color.clear)
                }
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showMenu) {
            // Placeholder for menu content
            Text("Menu content goes here")
                .font(.largeTitle)
                .padding()
        }
        .onAppear {
            viewModel.fetchBusinessHours()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Helper extension to set specific corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner : Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
