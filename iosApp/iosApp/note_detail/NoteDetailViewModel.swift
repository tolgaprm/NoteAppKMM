//
//  NoteDetailViewModel.swift
//  iosApp
//
//  Created by Tolga Pirim on 1.04.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension NoteDetailScreen{
     @MainActor class NoteDetailViewModel : ObservableObject{
         private var noteDataSource:NoteDataSource? = nil
         
         private var noteId:Int64? = nil
         @Published var noteTitle : String = ""
         @Published var noteContent = ""
         @Published private(set) var noteColor = Note.Companion().generateRandomColor()
         
         
         init(noteDataSource: NoteDataSource? = nil){
             self.noteDataSource = noteDataSource
         }
         
         func loadNoteIfExists(id:Int64?){
             if id != nil {
                 self.noteId = id
                 noteDataSource?.getNoteById(id: id!, completionHandler: {note,error in
                     self.noteTitle = note?.title ?? ""
                     self.noteContent = note?.content ?? ""
                     self.noteColor = note?.colorHex ?? Note.Companion().generateRandomColor()
                 })
             }
         }
         
         func saveNote(onSaved: @escaping () -> Void){
             noteDataSource?.insertNote(
                note: Note(id: noteId == nil ? nil : KotlinLong(value: noteId!),
                           title: self.noteTitle,
                           content: self.noteContent,
                           colorHex: self.noteColor,
                           created: DateTimeUtil().now()
                ),
                completionHandler: { error in
                    onSaved()
                })
         }
         
         func setParamsAndLoadNote(noteDataSource:NoteDataSource, noteId:Int64?){
             self.noteDataSource = noteDataSource
             loadNoteIfExists(id: noteId)
         }
        
    }
}
