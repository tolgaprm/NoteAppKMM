package com.prmto.noteappkmm.domain.note

import com.prmto.noteappkmm.domain.time.DateTimeUtil

class SearchNotes {

    fun execute(query: String, notes: List<Note>): List<Note> {
        if (query.isBlank()) return notes
        val lowerCaseQuery = query.lowercase()
        return notes.filter { note ->
            note.title.trim().lowercase().contains(lowerCaseQuery) ||
                    note.content.trim().lowercase().contains(lowerCaseQuery)
        }.sortedBy {
            DateTimeUtil.toEpochMillis(it.created)
        }
    }
}