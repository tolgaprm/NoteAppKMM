package com.prmto.noteappkmm.data.note

import com.prmto.noteappkmm.domain.note.Note
import database.NoteEntity
import kotlinx.datetime.Instant
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toLocalDateTime

fun NoteEntity.toNote() = Note(
    id = id,
    title = title,
    content = content,
    colorHex = colorHex,
    created = Instant.fromEpochMilliseconds(created).toLocalDateTime(timeZone = TimeZone.currentSystemDefault())
)