//
//  Home.swift
//  SwiftUI-StickyHeader
//
//  Created by macOS on 21/06/23.
//

import SwiftUI

struct Home: View {
    var size: CGSize
    var safeArea: EdgeInsets
    var arrAvangers = ["Ironman","Captain America","Hulk","Thor","Doctor Stange"]
    @State private var offsetY: CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                headerView()
                    .zIndex(1000)
                
                sampleCardsView()
            }
            .background {
                ScrollDetector { offset in
                    offsetY = -offset
                } onDraggingEnd: { offset, velocity in
                    
                }
            }
            
        }
    }
    
    // Header View
    @ViewBuilder
    func headerView() -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumheaderheight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumheaderheight), 1), 0)
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom))
                
                VStack(spacing: 20) {
                    // Profile Image
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        let halfScaledHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding: CGFloat = 15
                        let resizedOffsetY = (midY - (minimumheaderheight - halfScaledHeight - bottomPadding))
                        
                        Image("Marvel")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width, height: rect.height)
                            .clipShape(Circle())
                            .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                            .offset(x: -(rect.minX - 15) * progress,y: -resizedOffsetY * progress)
                    }
                    .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)
                    
                    Text("Marvel Super Heros")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom, 15)
            }
            .frame(height: (headerHeight + offsetY) < minimumheaderheight ? minimumheaderheight : (headerHeight + offsetY), alignment: .bottom)
            .offset(y:-offsetY)
        }
        .frame(height: headerHeight)

    }
    
    @ViewBuilder
    func sampleCardsView() -> some View {
        VStack(spacing: 15) {
            ForEach(0...4, id: \.self) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(LinearGradient(gradient: Gradient(colors: [.purple, .red, .blue]), startPoint: .leading, endPoint: .trailing))
                        .frame(height: 150)
                    
                    HStack {
                        Image("Avanger_" + "\(item)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                        Text(arrAvangers[item])
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Spacer()
                    }
                    .multilineTextAlignment(.center)
                    .padding(.leading,15)
                }
            }
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
