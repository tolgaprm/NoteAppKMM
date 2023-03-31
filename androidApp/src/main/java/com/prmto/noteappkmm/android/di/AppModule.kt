package com.prmto.noteappkmm.android.di

import android.app.Application
import com.prmto.noteappkmm.data.local.DatabaseDriverFactory
import com.prmto.noteappkmm.data.note.SqlDelightNoteDataSource
import com.prmto.noteappkmm.database.NoteDatabase
import com.prmto.noteappkmm.domain.note.NoteDataSource
import com.squareup.sqldelight.db.SqlDriver
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideSqlDriver(app: Application): SqlDriver {
        return DatabaseDriverFactory(app).createDriver()
    }

    @Provides
    @Singleton
    fun provideNoteDataSource(driver: SqlDriver): NoteDataSource {
        return SqlDelightNoteDataSource(NoteDatabase.invoke(driver))
    }
}