//
//  ContentView.swift
//  PokeApp
//
//  Created by IOS SENAC on 10/16/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)], spacing: 15){
                    ForEach(viewModel.results){ result in
                        if let url = result.url{
                            PokemonItem(url: url)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                                
                        }
                    }
                }.padding()
                if viewModel.isLoading {
                    ProgressView()
                }
                if(viewModel.results.count < viewModel.count){
                    Button("Carregar Mais") {
                        viewModel.nextPage()
                    }.padding()

                } else {
                    let _ = print(viewModel.results.count)
                    let _ = print(viewModel.count)
                }
               
                
            }.navigationBarTitle("Pokedex", displayMode: .inline)

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct PokemonItem: View{
    @ObservedObject var viewmodel: PokemonViewModel
    
    init(url: String) {
        self.viewmodel = PokemonViewModel(pokemonUrl: url)
    }
    
    var body: some View{

        if(viewmodel.isLoading){
            ProgressView()
        }
        else if let data = viewmodel.image, let image = UIImage(data: data), let pokemonName = viewmodel.pokemon?.name {
            NavigationLink(destination: PokemonDetail(viewmodel: viewmodel)){
                VStack{
                    Image(uiImage: image)
                        .shadow(radius: 30 )
                    Text(pokemonName.capitalized)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray)
                }.padding(.vertical)
            }
        }
        else{
            Image(systemName: "exclamationmark.circle")
        }
    }
}

struct PokemonDetail: View{
    @ObservedObject var viewmodel: PokemonViewModel
    
    var body: some View{
        if viewmodel.isLoading{
            ProgressView()
        }
        else if let data = viewmodel.image, let image = UIImage(data: data), let pokemonName = viewmodel.pokemon?.name {
            VStack{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200, alignment: .center)
                    .shadow(radius: 30)
        
                
                HStack{
                    Text("Nome: ")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                    Text(viewmodel.pokemon?.name?.capitalized ?? "")
                        .fontWeight(.medium)

                    Spacer()
                }.padding()
                
                HStack{
                    Text("Experiencia Base: ")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                    Text("\(viewmodel.pokemon?.baseExperience ?? 0)")
                        .fontWeight(.medium)

                    Spacer()
                }.padding()
                
                
                HStack{
                    Text("Altura: ")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                    Text("\(viewmodel.pokemon?.height ?? 0)")
                        .fontWeight(.medium)
                    Spacer()
                }.padding()
                
                Spacer()
                
                
            }.navigationBarTitle(pokemonName.capitalized)
        }
    }
}
