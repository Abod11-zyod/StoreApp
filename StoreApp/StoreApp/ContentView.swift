//
//  ContentView.swift
//  StoreApp
//
//  Created by mohammad yasir on 06/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchItem : String = ""
    
    @State var up = false
    
    var body: some View {
        ZStack(){
            VStack {
                HStack{
                    Image(systemName: "lightbulb")
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading , 20)
                Spacer()
            }
            
            
            VStack(alignment : .leading){
                Spacer()
                Text("What would you like ?")
                    .foregroundColor(.white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .padding(.leading)
                Spacer()
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.white)
                    TextField("Pizza , Chicken , Dosa", text: $searchItem)
                        .cornerRadius(100)
                        .padding(.trailing)
                        .font(Font.system(size: 17, weight: .medium, design: .serif))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onTapGesture{
                            up.toggle()
                        }
                    
                    
                }
                .padding(.leading , 7)
                
                Text("Explore")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(width: 70, height: 15, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        HStack(spacing : 15) {
                            ForEach(sectionData.filter({ "\($0)".localizedStandardContains(searchItem) || searchItem.isEmpty })) { item in
                                GeometryReader { geometry in
                                    CardView(section: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 10.0, y: 10.0, z: 0))
                                }.frame(width: 170 , height : 170)
                            }
                        }
                        .padding(.leading , 30)
                        .padding(.bottom,30)
                        .padding(.top)
                        
                        
                    }
                }
        
                Spacer()
                
            }
            
            
        }
        .padding(.top , 60)
        .frame(maxWidth : .infinity , maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)))
        .ignoresSafeArea(.all)
        .offset(x: 0, y: up ? -5 : 0)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CardView: View {
    
    var section : Section
    
    var body: some View {
        VStack{
            HStack(alignment:.top){
                Text(section.title)
                    .font(.system(size: 19, weight: .bold ,design: .rounded))
                    .frame(width: 50, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: section.logo)
                    .foregroundColor(.white)
            }
            
            Text(section.text)
                .font(.system(size: 13, weight: .bold))
                .frame(maxWidth: .infinity , alignment: .leading)
                .foregroundColor(.white)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:140)
            
        }
        .padding(.top,20)
        .padding(.leading , 8)
        .padding(.horizontal,20)
        .frame(width: 170, height: 170)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}



struct Section : Identifiable {
    var id = UUID()
    var title : String
    var text : String
    var logo : String
    var image : Image
    var color : Color
}

let sectionData = [
    Section(title: "Pizza", text: "Veg", logo: "heart", image: Image(uiImage: #imageLiteral(resourceName: "pizz")), color: Color(#colorLiteral(red: 0.639764348, green: 0.9764705896, blue: 0.3487065735, alpha: 0.7020280394))),
    Section(title: "Dosa", text: "Sliced", logo: "heart", image: Image(uiImage: #imageLiteral(resourceName: "dosa")), color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))),
    Section(title: "Biryani", text: "Non-Veg", logo: "heart", image: Image(uiImage: #imageLiteral(resourceName: "biryani")), color: Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))),
    Section(title: "Egg Fry", text: "Hot", logo: "heart", image: Image(uiImage: #imageLiteral(resourceName: "egg")), color: Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
]
