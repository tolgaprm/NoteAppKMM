//
//  NoteListViewModel.swift
//  iosApp
//
//  Created by Tolga Pirim on 31.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension NoteListScreen{
   @MainActor class NoteListViewModel : ObservableObject{
       private var noteDataSource:NoteDataSource?=nil
       
       private let searchNotes = SearchNotes()
       
       private var notes = [Note]()
       @Published private(set) var filterNotes = [Note]()
       @Published var searchText = ""{
           didSet{
               self.filterNotes = searchNotes.execute(query: searchText, notes: self.notes)
           }
       }
       @Published private(set) var isSearchActive = false
       
       init(noteDataSource: NoteDataSource? = nil) {
           self.noteDataSource = noteDataSource
       }
       
       func loadNotes(){
           noteDataSource?.getAllNotes(completionHandler: {notes,error in
               self.notes = notes ?? []
               self.filterNotes = self.notes
               
           })
       }
       
       func deleteNoteById(id:Int64?){
           if id != nil{
               noteDataSource?.deleteNoteById(id: id!, completionHandler: { error in
                   self.loadNotes()
               })
           }
       }
       
       func toggleIsSearchActive(){
           isSearchActive = !isSearchActive
           if !isSearchActive{
               self.searchText = ""
           }
       }
       
       func setNoteDataSource(noteDataSource:NoteDataSource){
           self.noteDataSource = noteDataSource
           noteDataSource.insertNote(note: Note(id: nil, title: "My first note", content: "Note Content", colorHex: 0xFF5124, created: DateTimeUtil().now()), completionHandler: {error in
               
           })
       }
    }
}
