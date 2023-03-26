package com.prmto.noteappkmm

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform