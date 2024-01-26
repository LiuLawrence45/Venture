//
//  ItineraryDescription.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI



/*
 Formatting for the Itinerary Description
 */

struct ItineraryDescription: View {
    var itinerary: ItineraryModel
    
    var body: some View {
        
        ZStack {
            Color("White").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack{
                    
                    ForEach(0..<itinerary.title.count, id: \.self) { index in
                        let title = itinerary.title[index]
                        var caption = itinerary.caption[index]
                        
                        
                        VStack(alignment: .center) {
                            Text(title)
                                .multilineTextAlignment(.center)
                                .font(.title3.weight(.semibold))
                            
                            //Divider()
                                Image("861A6374")
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .padding(.bottom, 20)
                            if itinerary.caption.count > index {
                                Text(itinerary.caption[index])
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .opacity(0.8)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        
                        
                        
//                        GeometryReader { geometry in
//                            
//                            let minY = geometry.frame(in: .global).minY
//                            let centerY = UIScreen.main.bounds.height / 2
//                            let distanceFromCenter = abs(minY - centerY)
//                            let relativeDistance = distanceFromCenter / centerY
//                            let scale = 1 - (relativeDistance / 2)
//                            
//                        VStack(alignment: .center) {
//                            Text(title)
//                                .multilineTextAlignment(.center)
//                                .font(.title3.weight(.semibold))
//                            Divider()
////                            Image("861A6374")
////                                .resizable()
////                                .frame(maxWidth: .infinity)
////                                .frame(height: 20)
//                            if itinerary.caption.count > index {
//                                Text(itinerary.caption[index])
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                            }
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 10)
//                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//                        .scaleEffect(max(0.5, scale))
//                            
//                        }
//                        .frame(maxWidth: .infinity)
////                        .frame(height: CGFloat(caption.count))
//                        .frame(height: 200)
                        
                    }
                    .padding(.horizontal, 10)
                }
            }
            
        }
    }
}



struct ChecklistView: View {
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(items, id: \.self) { item in
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text(item)
                }
                .padding(.vertical, 2)
            }
        }
        .padding(.horizontal)
    }
}


struct ItineraryDescription_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ItineraryDescription(itinerary: posts[0].itinerary!)
        
        //(namespace: namespace, show: .constant(true))
            //.environmentObject(Model())
    }
}

