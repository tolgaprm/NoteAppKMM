//
//  NoteListScreen.swift
//  iosApp
//
//  Created by Tolga Pirim on 31.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteListScreen: View {
    private var noteDataSource:NoteDataSource
   @StateObject var viewModel = NoteListViewModel(noteDataSource: nil)
    
    @State private var isNoteSelected = false
    @State private var selectedNoteId:Int64? = nil
    
    init(noteDataSource:NoteDataSource){
        self.noteDataSource = noteDataSource
    }
    
    // Burada noteDataSource'u direkt olarak viewModel' consctrcutina vermememizin
    // nedeni SwiftUI'da init loğu birden fazla oluşturulabiliyor. (Compose'daki recompose mantığı ) nedeniyle aynı durum burdada var ve bu durumu @StateObject annotation ile çözüyoruz ama viewModel, noteDataSource'dan önce oluşturuluyor o yüzden direkt olarak iletemiyoruz. Bunu bu ekran göründüğünde yapmamız lazım onuda onAppear'da yaıyoruz.
    
    var body: some View {
        VStack {
            ZStack {
                NavigationLink(
                    destination: NoteDetailScreen(
                        noteDataSource: self.noteDataSource,
                        noteId: selectedNoteId
                    ),
                    isActive:$isNoteSelected
                ){
                    EmptyView()
                }.hidden()
                
                HideableSearchTextField<NoteDetailScreen>(
                    onSearchToggled: {viewModel.toggleIsSearchActive()},
                    destinationProvider: {
                       NoteDetailScreen(noteDataSource: noteDataSource,
                       noteId: selectedNoteId)
                    },
                    isSearchActive: viewModel.isSearchActive,
                    searchText: $viewModel.searchText
                )
                .frame(maxWidth:.infinity,minHeight: 40)
                .padding()
                
                if !viewModel.isSearchActive {
                    Text("All Notes")
                        .font(.title2)
                }
            }
            
            List {
                ForEach(viewModel.filterNotes,id: \.self.id){note in
                    Button(action: {
                        isNoteSelected = true
                        selectedNoteId = note.id?.int64Value
                    }){
                        NoteItem(
                            note: note,
                            onDeleteClick: {
                                viewModel.deleteNoteById(id: note.id?.int64Value)
                            }
                        )
                    }
                }
            }
            .onAppear{
                viewModel.loadNotes()
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            
            
        }.onAppear{
            viewModel.setNoteDataSource(noteDataSource: noteDataSource)
        }
    }
}
