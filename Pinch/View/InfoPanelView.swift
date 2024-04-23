//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Nikolay  Yuchormanski on 23.04.24.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale: CGFloat
    var offcet: CGSize
    
    @State private var isInfoPanelVisible: Bool = false
    
    var body: some View {
        HStack {
            //MARK: - HOT SPOT
            Image(systemName: "smallcircle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture (minimumDuration: 1) {
                    withAnimation(.easeOut){
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            
            
            //MARK: - INFO PANEL
            
            
            HStack (spacing: 2){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offcet.width)")
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offcet.height)")
                Spacer()
            }//: HSTACK
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        }
    }
}

#Preview {
    InfoPanelView(scale: 1, offcet: .zero)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
