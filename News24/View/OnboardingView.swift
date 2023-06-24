//
//  OnboardingView.swift
//  News24
//
//  Created by GA on 18/06/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Environment(\.dismiss) var dismiss
    @AppStorage("hasViewedWalkthrough") var  hasViewedWalkthrough:Bool = false
    
    
    let pageHeadings = [ "Stay Informed"
    , "Personalized News", "Breaking News Alerts"
    ]
    
    let pageSubHeadings = [ "Get the latest news and updates from around the world delivered right to your fingertips.",
    
    
    "Tailor your news feed to your interests and preferences, ensuring you receive relevant and engaging articles.",
                            
    "Never miss an important story with real-time notifications on breaking news events and developments."
    ]
    
    
    let pageImages = [ "animation1", "animation2", "animation3"
    ]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pageHeadings.indices, id: \.self) { index in
                    OnboardingPage(animationFilename: pageImages[index], heading: pageHeadings[index], subHeading: pageSubHeadings[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
        .animation(.default, value: currentPage)
            
            VStack(spacing: 20) {
                    Button(action: {
                        if currentPage < pageHeadings.count - 1 {
                            currentPage += 1
                        } else {
                            hasViewedWalkthrough = true
                            dismiss()
            }
                        
                    })
                {
           
            Text(currentPage == pageHeadings.count - 1 ? "GET STARTED" : "NEXT")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 50)
                .background(Color(.black))
                .cornerRadius(25)
            }
                       if currentPage < pageHeadings.count - 1 {
                           Button(action: {
                               hasViewedWalkthrough = true
                               dismiss()
               }) {
                               Text("Skip")
                                   .font(.headline)
                                   .foregroundColor(Color(.darkGray))
               } }
                   }
                   .padding(.bottom)

        }
    }
}


struct OnboardingPage: View {
    let animationFilename: String
    let heading: String
    let subHeading: String
    
  
    
    var body: some View {
        VStack(spacing: 70) {
            LottieView(animationFile: animationFilename)
                .frame(height: 200)
            
            VStack(spacing: 10) {
                Text(heading)
                    .font(.headline)
                
                Text(subHeading)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top)
    }
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewDisplayName("Real")
        
        OnboardingPage(animationFilename: "animation2", heading: "Stay Informed", subHeading: "Get the latest news and updates from around the world delivered right to your fingertips.")
        
    }
}

