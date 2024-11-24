//
//  ContentView.swift
//  SwiftUI Game-Destiny
//
//  Created by BitDegree on 24/11/24.
//


import SwiftUI

// Define the structure for the story data
struct StoryAct {
    var text: String
    var choices: [Choice]
    
    struct Choice {
        var text: String
        var nextAct: Int
    }
}

struct ContentView: View {
    
    @State private var currentAct = 0
    @State private var ending: String? = nil
    @State private var progressText = "You wake up in a dark mansion..."
    
    let story = [
        StoryAct(
            text: "You wake up in a cold, dimly lit room. Strange whispers echo through the room.",
            choices: [
                StoryAct.Choice(text: "Explore the hallway", nextAct: 1),
                StoryAct.Choice(text: "Investigate the strange chest", nextAct: 2)
            ]
        ),
        StoryAct(
            text: "You step into the hallway, a figure beckons you. Do you follow?",
            choices: [
                StoryAct.Choice(text: "Follow the figure", nextAct: 3),
                StoryAct.Choice(text: "Ignore and explore another door", nextAct: 4)
            ]
        ),
        StoryAct(
            text: "You find an old chest and open it. Inside is a diary with cryptic entries about the mansion's curse.",
            choices: [
                StoryAct.Choice(text: "Read the diary", nextAct: 5),
                StoryAct.Choice(text: "Leave the chest and explore", nextAct: 4)
            ]
        ),
        StoryAct(
            text: "The figure turns, revealing a tortured soul. 'The curse is alive. A sacrifice must be made.'",
            choices: [
                StoryAct.Choice(text: "Ask for more details", nextAct: 6),
                StoryAct.Choice(text: "Refuse to believe and run", nextAct: 7)
            ]
        ),
        StoryAct(
            text: "You reach a locked door with strange symbols. Do you search for the key?",
            choices: [
                StoryAct.Choice(text: "Search for the key", nextAct: 8),
                StoryAct.Choice(text: "Try to break the door", nextAct: 9)
            ]
        ),
        StoryAct(
            text: "You find the key hidden in a drawer. Do you use it to open the door?",
            choices: [
                StoryAct.Choice(text: "Use the key to open the door", nextAct: 10),
                StoryAct.Choice(text: "Look for another way out", nextAct: 9)
            ]
        ),
        StoryAct(
            text: "You enter a hidden passage behind a bookshelf. It leads to an eerie library.",
            choices: [
                StoryAct.Choice(text: "Enter the library", nextAct: 11),
                StoryAct.Choice(text: "Turn back", nextAct: 9)
            ]
        ),
        StoryAct(
            text: "The ritual chamber is filled with symbols and an altar. Blood stains the floor.",
            choices: [
                StoryAct.Choice(text: "Perform the ritual", nextAct: 12),
                StoryAct.Choice(text: "Look for another escape route", nextAct: 13)
            ]
        ),
        StoryAct(
            text: "You manage to break the door open, but a grotesque creature lunges at you.",
            choices: [
                StoryAct.Choice(text: "Fight the creature", nextAct: 14),
                StoryAct.Choice(text: "Run away", nextAct: 15)
            ]
        ),
        StoryAct(
            text: "In the library, you find a book that pulsates with dark energy. Do you read it?",
            choices: [
                StoryAct.Choice(text: "Read the book", nextAct: 14),
                StoryAct.Choice(text: "Leave the book and explore", nextAct: 15)
            ]
        ),
        StoryAct(
            text: "The ritual begins to take hold, and the mansion’s power courses through you.",
            choices: [
                StoryAct.Choice(text: "Continue with the ritual", nextAct: 15),
                StoryAct.Choice(text: "Try to stop it", nextAct: 13)
            ]
        ),
        StoryAct(
            text: "You uncover the dark truth of the mansion. To escape, you must make a sacrifice.",
            choices: [
                StoryAct.Choice(text: "Confront the curse", nextAct: 14),
                StoryAct.Choice(text: "Try to escape", nextAct: 15)
            ]
        ),
        StoryAct(
            text: "The mansion’s master offers you a choice: sacrifice something precious, or stay here forever.",
            choices: [
                StoryAct.Choice(text: "Accept the challenge", nextAct: 15),
                StoryAct.Choice(text: "Reject the offer", nextAct: 13)
            ]
        ),
        StoryAct(
            text: "The final confrontation with the mansion’s evil forces begins. Do you fight or flee?",
            choices: [
                StoryAct.Choice(text: "Fight to the end", nextAct: 15),
                StoryAct.Choice(text: "Flee", nextAct: 15)
            ]
        )
    ]
    
    var body: some View {
        VStack {
            if let ending = ending {
                Text(ending)
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                Text(story[currentAct].text)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                
                ForEach(story[currentAct].choices, id: \.text) { choice in
                    Button(action: {
                        handleChoice(choice)
                    }) {
                        Text(choice.text)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(5)
                    }
                }
            }
        }
        .navigationTitle("Interactive Story")
    }
    
    func handleChoice(_ choice: StoryAct.Choice) {
        if choice.nextAct < story.count {
            currentAct = choice.nextAct
            // If the game reaches an ending act, show the result.
            if currentAct == 15 {
                ending = "The story ends here. You have escaped, but at a cost..."
            }
        }
    }
}


