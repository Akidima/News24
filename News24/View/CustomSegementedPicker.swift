//
//  CustomSegementedPicker.swift
//  News24
//
//  Created by GA on 03/07/2023.
//

import SwiftUI

struct CustomSegementedPicker: View {
    @Binding var fetchTaskToken: FetchTaskToken
   
    @State private var selection = 0
    @State private var frames = Array<CGRect>(repeating: .zero, count: 20)
    
    
    private let selectedItemColor: Color
    private let backgroundColor: Color
    private let selectedItemFontColor: Color
    private let defaultItemColor: Color
    
    init(fetchTaskToken: Binding<FetchTaskToken>, selectedItemColor: Color, backgroundColor: Color, selectedItemFontColor: Color, defaultItemColor: Color) {
        
        self._fetchTaskToken = fetchTaskToken
       
        self.selectedItemColor = selectedItemColor
        self.backgroundColor = backgroundColor
        self.selectedItemFontColor = selectedItemFontColor
        self.defaultItemColor = defaultItemColor
        
        
    }
    
    
    
    var body: some View {
        VStack{
            ZStack{
                HStack(spacing: 0){
                    ForEach(Array(Category.allCases.enumerated()), id: \.element) { index, category in
                        Text(category.text)
                            .tag(category)
                            .foregroundColor(selection == index ? selectedItemFontColor : defaultItemColor)
                            .onTapGesture {
                                self.selection = index
                                let selectedCategory = Category.allCases[index]  // Get the selected category
                                fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background {
                                GeometryReader { geo in
                                    Color.clear.onAppear{
                                        self.setFrame(index: index, frame: geo.frame(in: .global))
                                    }
                                }
                            }
                    }
                }
                .background(alignment: .leading){
                    Capsule()
                        .fill(selectedItemColor)
                        .frame(width: self.frames[self.selection].width, height: 28)
                        .offset(x: self.frames[self.selection].minX - self.frames[0].minX)
                }
                .padding(5)
            }
            .background(backgroundColor)
            .animation(.spring(), value: selection)
        }
        .cornerRadius(40)
        .padding()
        
    }
    private func setFrame(index: Int, frame: CGRect) {
        DispatchQueue.main.async {
            self.frames[index] = frame
        }
    }
   
        
        
    }

