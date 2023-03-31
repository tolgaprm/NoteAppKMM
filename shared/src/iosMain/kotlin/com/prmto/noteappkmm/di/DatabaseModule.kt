package com.prmto.noteappkmm.di

import com.prmto.noteappkmm.data.local.DatabaseDriverFactory
import com.prmto.noteappkmm.data.note.SqlDelightNoteDataSource
import com.prmto.noteappkmm.database.NoteDatabase
import com.prmto.noteappkmm.domain.note.NoteDataSource

class DatabaseModule {

    private val factory by lazy { DatabaseDriverFactory() }
    val noteDataSource: NoteDataSource by lazy {
        SqlDelightNoteDataSource(
            NoteDatabase(
                factory.createDriver()
            )
        )
    }
}