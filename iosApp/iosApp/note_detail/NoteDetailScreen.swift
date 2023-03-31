//
//  NoteDetailScreen.swift
//  iosApp
//
//  Created by Tolga Pirim on 31.03.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared


struct NoteDetailScreen: View {
    private var noteDataSource:NoteDataSource?
    private var noteId:Int64?=nil
    
    init(noteDataSource: NoteDataSource? = nil, noteId: Int64? = nil) {
        self.noteDataSource = noteDataSource
        self.noteId = noteId
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NoteDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailScreen()
    }
}
