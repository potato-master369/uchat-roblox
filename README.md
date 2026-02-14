Roblox store: [https://create.roblox.com/store/asset/140163641734207/UChatReDist-UChat-Latest-Build]


# README - UChat Chat System

*This file is a modified version of the README.luau for Github MarkDown*

---
Current Version: v1.0.0 (Feb 2, 2026)
Contact: @stupid_guy049 (Kitasan_Black)
         mailto:random.nonprivate.email@gmail.com
         github:potato-master369

REPORT AN ISSUE: Don't. I don't really care.

Setup:

* Copy the contents of the folders (e.g. Put my contents in `StarterGui`)
    
* Be sure to ensure you did not copy the ENTIRE folder. Say, copy UChatUpdate, NOT the `Put my contents in ReplicatedStorag` folder.
    
* You can delete this script and the remaining folders after setup.
    
# Docs

## RemoteEvents
* **UChatUpdate: FireServer(filterstring, data)**
  * Sends a message to all clients (supports **RichText** format).
  * **Arguments:**
    * `filterstring` *(string)*  
      The content. This will be filtered using `TextService`.
    * `data` *(string)*  
      Header (e.g. `"[System]"`) that will be prepended to `filterstring`.

---

## Server Scripts
* **UChat_Server**
  * Contains the server logic:
    * Enforcement of Roblox content policy  
      (e.g. kick players from countries that disallow user‑inputted text).
    * Management of `UChatUpdate`  
      (handles filtering and firing to all clients).
    * Chat bubble rendering.

---

## Client Scripts
* **UChat_ServerHandler**
  * Handles output from the server:
    * Adds messages to the buffer.
    * Displays messages.
  * Creates an **OK token** (`_G.UChatServerOK`)  
    which prevents the Input Handler from conflicting.

* **UChat_InputHandler**
  * Handles user input from the TextBox:
    * Sends input to the server.
  * **Config:**
    * `_G.UChatBufferSize` *(number)*  
      Number of messages (items) to store in the buffer.

---

## GUIs
* **UChatGui (ServerStorage)**
  * Template for the chat bubble.

* **UChatGui (StarterGui)**
  * Contains:
    * TextBox input
    * ScrollableFrame for output (prevents wrapping issues)
    * Output TextBox
