//
//  ContentView.swift
//  Pinch
//
//  Created by Nikolay  Yuchormanski on 23.04.24.
//

import SwiftUI


struct ContentView: View {
    
    //MARK: - PROPERTY
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffcet: CGSize = .zero
    
    
    //MARK: - FUNCTION
    
    func resetValues() {
        return withAnimation(.spring()){
            imageScale = 1
            imageOffcet = .zero
        }
    }
    
    //MARK: - CONTENT
    
    var body: some View {
        NavigationView {
            
            
            ZStack{
                Color.clear // за да се позиционира InfoPanelView на ТОП , трябва да има цомпонент , който да запълва цялата страница. По този начин InfoPanela ще отиде максимално нагоре
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffcet.width, y: imageOffcet.height)
                    .scaleEffect(imageScale)
                
                //MARK: - TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        } else {
                            resetValues()
                        }
                    })
                
                //MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                withAnimation(.linear(duration: 1)){
                                    imageOffcet = gesture.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetValues()
                                }
                            })
                    )
                
                
                
                
                
                
                
            }//: Zstack
            
            .navigationTitle("Pinch % Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform:{
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }}
            )
            
            //MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offcet: imageOffcet)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            
            
        }// : NavigationView
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
