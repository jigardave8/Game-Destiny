//
//  ContentView.swift
//  SwiftUI Game-Destiny
//
//  Created by BitDegree on 24/11/24.
//


import SwiftUI

// Define the ending type
enum Ending: String {
    case escape = "The Great Escape"
    case trapped = "Eternal Resident"
    case revelation = "Dark Revelation"
    case sacrifice = "Noble Sacrifice"
    case peaceful = "Spiritual Guardian"
    case corrupted = "Dark Embrace"

    var description: String {
        switch self {
        case .escape:
            return "You successfully escape the mansion, but its memory haunts you forever."
        case .trapped:
            return "The mansion claims you as part of its eternal history."
        case .revelation:
            return "You uncover the mansion's dark secrets and your connection to it."
        case .sacrifice:
            return "Your sacrifice saves others trapped in the mansion."
        case .peaceful:
            return "You make peace with the spirits and become the mansion's guardian."
        case .corrupted:
            return "The mansion's dark power consumes you completely."
        }
    }
}

// Story Act and Choices
struct StoryAct {
    var text: String
    var choices: [Choice]
    var ending: Ending?
    
    struct Choice {
        var text: String
        var nextAct: Int
        var animation: AnimationType?
    }
}

enum AnimationType {
    case fadeIn, shake, spin
}

struct ContentView: View {
    @State private var currentAct = 0
    @State private var showChoice = true
    @State private var animateEffect: AnimationType? = nil
    @State private var fadeOpacity = 1.0
    @State private var showEnding = false
    @State private var currentEnding: Ending?
    
    let story: [StoryAct] = [
        StoryAct(
            text: "You wake up in a cold, dimly lit room. Strange whispers echo in the distance. Something doesn't feel right...",
            choices: [
                StoryAct.Choice(text: "Investigate the whispers", nextAct: 1, animation: .fadeIn),
                StoryAct.Choice(text: "Hide under the bed", nextAct: 2, animation: nil),
                StoryAct.Choice(text: "Scream for help", nextAct: 3, animation: .shake)
            ]
        ),
        // Other story acts go here...
        // Act 2
         StoryAct(
             text: "You cautiously follow the whispers and find a door slightly ajar. A faint light seeps through the crack.",
             choices: [
                 StoryAct.Choice(text: "Open the door slowly", nextAct: 4, animation: nil),
                 StoryAct.Choice(text: "Turn back and look for another way", nextAct: 5, animation: nil),
                 StoryAct.Choice(text: "Run through the door without hesitation", nextAct: 6, animation: .spin)
             ]
         ),
         // Act 3
         StoryAct(
             text: "You hide under the bed, holding your breath. Heavy footsteps approach. The door creaks open, and the room falls silent.",
             choices: [
                 StoryAct.Choice(text: "Stay hidden", nextAct: 7, animation: nil),
                 StoryAct.Choice(text: "Peek out cautiously", nextAct: 8, animation: nil),
                 StoryAct.Choice(text: "Dash for the door", nextAct: 6, animation: .spin)
             ]
         ),
         // Act 4
         StoryAct(
             text: "The room beyond the door reveals an old library filled with dusty books and eerie portraits. A single candle flickers on a desk.",
             choices: [
                 StoryAct.Choice(text: "Examine the desk", nextAct: 9, animation: .fadeIn),
                 StoryAct.Choice(text: "Inspect the portraits", nextAct: 10, animation: nil),
                 StoryAct.Choice(text: "Light more candles", nextAct: 11, animation: nil)
             ]
         ),
         // Act 5
         StoryAct(
             text: "You search for another way and stumble upon a hidden staircase leading down into the darkness.",
             choices: [
                 StoryAct.Choice(text: "Descend the staircase", nextAct: 12, animation: nil),
                 StoryAct.Choice(text: "Return to the room", nextAct: 2, animation: nil),
                 StoryAct.Choice(text: "Search for tools to light your way", nextAct: 13, animation: nil)
             ]
         ),
         // Act 6
         StoryAct(
             text: "You run through the door, triggering a tripwire. A loud alarm echoes through the halls.",
             choices: [
                 StoryAct.Choice(text: "Keep running", nextAct: 14, animation: .spin),
                 StoryAct.Choice(text: "Hide nearby", nextAct: 15, animation: nil),
                 StoryAct.Choice(text: "Go back and disable the alarm", nextAct: 16, animation: nil)
             ]
         ),
         // Act 7
         StoryAct(
             text: "You stay hidden as the footsteps stop just outside the bed. A cold hand reaches down toward you...",
             choices: [
                 StoryAct.Choice(text: "Grab the hand", nextAct: 17, animation: nil),
                 StoryAct.Choice(text: "Kick the hand away", nextAct: 18, animation: nil),
                 StoryAct.Choice(text: "Close your eyes and hope it goes away", nextAct: 19, animation: nil)
             ]
         ),
         // Act 8
         StoryAct(
             text: "Peeking out, you see a shadowy figure standing in the doorway. Its face is obscured, but it seems to be searching for something.",
             choices: [
                 StoryAct.Choice(text: "Confront the figure", nextAct: 20, animation: nil),
                 StoryAct.Choice(text: "Sneak past it", nextAct: 21, animation: nil),
                 StoryAct.Choice(text: "Throw something to distract it", nextAct: 22, animation: nil)
             ]
         ),
         // Act 9
         StoryAct(
             text: "On the desk, you find an old journal. Its pages are filled with cryptic notes and strange symbols.",
             choices: [
                 StoryAct.Choice(text: "Try to decipher the notes", nextAct: 23, animation: .fadeIn),
                 StoryAct.Choice(text: "Rip out a page and keep it", nextAct: 24, animation: nil),
                 StoryAct.Choice(text: "Ignore the journal and keep exploring", nextAct: 25, animation: nil)
             ]
         ),
         // Act 10
         StoryAct(
             text: "One portrait stands out: a woman with piercing eyes that seem to follow your every move. Her nameplate reads 'Margaret'.",
             choices: [
                 StoryAct.Choice(text: "Touch the portrait", nextAct: 26, animation: nil),
                 StoryAct.Choice(text: "Speak to the portrait", nextAct: 27, animation: nil),
                 StoryAct.Choice(text: "Turn it to face the wall", nextAct: 28, animation: nil)
             ]
         ),
        
        // Act 11
        StoryAct(
            text: "As you light more candles, the room begins to shift and morph. The bookshelves rearrange themselves, revealing a hidden passage.",
            choices: [
                StoryAct.Choice(text: "Enter the hidden passage", nextAct: 29, animation: .fadeIn),
                StoryAct.Choice(text: "Blow out the candles", nextAct: 30, animation: nil),
                StoryAct.Choice(text: "Search the shelves for a clue", nextAct: 31, animation: nil)
            ]
        ),

        // Act 12
        StoryAct(
            text: "The staircase seems endless. Strange carvings on the walls depict ominous symbols.",
            choices: [
                StoryAct.Choice(text: "Touch the carvings", nextAct: 32, animation: nil),
                StoryAct.Choice(text: "Descend further", nextAct: 33, animation: nil),
                StoryAct.Choice(text: "Turn back", nextAct: 5, animation: nil)
            ]
        ),

        // Act 13
        StoryAct(
            text: "You find a lantern and some matches. The lantern casts eerie shadows on the walls.",
            choices: [
                StoryAct.Choice(text: "Use the lantern and proceed", nextAct: 12, animation: .fadeIn),
                StoryAct.Choice(text: "Explore the room further", nextAct: 34, animation: nil),
                StoryAct.Choice(text: "Wait and see if someone comes", nextAct: 35, animation: nil)
            ]
        ),

        // Act 14
        StoryAct(
            text: "Running through the hallway, you hear growls behind you. A strange creature is chasing you!",
            choices: [
                StoryAct.Choice(text: "Find a room to hide in", nextAct: 36, animation: nil),
                StoryAct.Choice(text: "Keep running", nextAct: 37, animation: .shake),
                StoryAct.Choice(text: "Face the creature", nextAct: 38, animation: nil)
            ]
        ),

        // Act 15
        StoryAct(
            text: "You hide behind a large cabinet, your breath shallow. The alarm shuts off, but faint growling continues nearby.",
            choices: [
                StoryAct.Choice(text: "Stay hidden and wait", nextAct: 39, animation: nil),
                StoryAct.Choice(text: "Peek around the corner", nextAct: 40, animation: nil),
                StoryAct.Choice(text: "Make a run for it", nextAct: 6, animation: nil)
            ]
        ),

        // Act 16
        StoryAct(
            text: "You attempt to disable the alarm, but it’s more complex than it looks. The growling grows louder.",
            choices: [
                StoryAct.Choice(text: "Keep working on it", nextAct: 41, animation: nil),
                StoryAct.Choice(text: "Run before it’s too late", nextAct: 14, animation: nil),
                StoryAct.Choice(text: "Set a trap nearby", nextAct: 42, animation: nil)
            ]
        ),

        // Act 17
        StoryAct(
            text: "You grab the cold hand, and a sudden jolt of electricity runs through your body. You lose consciousness.",
            choices: [
                StoryAct.Choice(text: "Wake up in a new place", nextAct: 43, animation: .fadeIn),
                StoryAct.Choice(text: "Resist and try to pull free", nextAct: 44, animation: nil),
                StoryAct.Choice(text: "Give in to the sensation", nextAct: 45, animation: nil)
            ]
        ),

        // Act 18
        StoryAct(
            text: "You kick the hand away, and it disappears under the bed. Silence follows, but something moves in the shadows.",
            choices: [
                StoryAct.Choice(text: "Search the shadows", nextAct: 46, animation: nil),
                StoryAct.Choice(text: "Escape the room", nextAct: 6, animation: nil),
                StoryAct.Choice(text: "Barricade the door", nextAct: 47, animation: nil)
            ]
        ),

        // Act 19
        StoryAct(
            text: "You close your eyes tightly, hoping the danger will pass. The footsteps retreat, leaving you alone—for now.",
            choices: [
                StoryAct.Choice(text: "Search the room quickly", nextAct: 48, animation: nil),
                StoryAct.Choice(text: "Leave and find another area", nextAct: 49, animation: nil),
                StoryAct.Choice(text: "Take a moment to collect yourself", nextAct: 50, animation: nil)
            ]
        ),

        // Act 20
        StoryAct(
            text: "You confront the figure, and it reveals its face—a grotesque, twisted version of your own.",
            choices: [
                StoryAct.Choice(text: "Run in terror", nextAct: 51, animation: nil),
                StoryAct.Choice(text: "Ask it why it looks like you", nextAct: 52, animation: nil),
                StoryAct.Choice(text: "Attack it", nextAct: 53, animation: nil)
            ]
        ),
        // Act 20 (Continued)
        StoryAct(
            text: "You confront the figure, and it reveals its face—a grotesque, twisted version of your own.",
            choices: [
                StoryAct.Choice(text: "Run in terror", nextAct: 21, animation: .shake),
                StoryAct.Choice(text: "Ask it why it looks like you", nextAct: 22, animation: .fadeIn),
                StoryAct.Choice(text: "Attack it", nextAct: 23, animation: nil)
            ]
        ),

        // Act 21
        StoryAct(
            text: "As you flee, the figure laughs maniacally, and the corridor stretches endlessly ahead of you.",
            choices: [
                StoryAct.Choice(text: "Keep running", nextAct: 24, animation: nil),
                StoryAct.Choice(text: "Turn around and face it", nextAct: 20, animation: .shake),
                StoryAct.Choice(text: "Find a door to escape", nextAct: 25, animation: nil)
            ]
        ),

        // Act 22
        StoryAct(
            text: "The figure smiles eerily and whispers, 'I am what you fear the most.' Its form begins to shift.",
            choices: [
                StoryAct.Choice(text: "Ask it what it wants", nextAct: 26, animation: nil),
                StoryAct.Choice(text: "Try to touch the figure", nextAct: 27, animation: .shake),
                StoryAct.Choice(text: "Run away", nextAct: 21, animation: nil)
            ]
        ),

        // Act 23
        StoryAct(
            text: "You lunge at the figure, but your hands pass through it as if it’s made of smoke.",
            choices: [
                StoryAct.Choice(text: "Try again", nextAct: 28, animation: nil),
                StoryAct.Choice(text: "Step back cautiously", nextAct: 22, animation: nil),
                StoryAct.Choice(text: "Call for help", nextAct: 29, animation: .fadeIn)
            ]
        ),

        // Act 24
        StoryAct(
            text: "You find a door at the end of the corridor. It’s locked, but there’s a strange keyhole glowing faintly.",
            choices: [
                StoryAct.Choice(text: "Search for the key", nextAct: 30, animation: nil),
                StoryAct.Choice(text: "Try to force the door open", nextAct: 31, animation: nil),
                StoryAct.Choice(text: "Turn back", nextAct: 21, animation: .shake)
            ]
        ),

        // Act 25
        StoryAct(
            text: "You open a door and find a room filled with mirrors. Each mirror reflects a distorted version of reality.",
            choices: [
                StoryAct.Choice(text: "Step into a mirror", nextAct: 32, animation: nil),
                StoryAct.Choice(text: "Break a mirror", nextAct: 33, animation: .shake),
                StoryAct.Choice(text: "Look for clues in the reflections", nextAct: 34, animation: nil)
            ]
        ),

        // Act 26
        StoryAct(
            text: "The figure begins to speak in riddles, offering cryptic clues about your escape.",
            choices: [
                StoryAct.Choice(text: "Solve the riddle", nextAct: 35, animation: nil),
                StoryAct.Choice(text: "Ignore the riddles and leave", nextAct: 36, animation: nil),
                StoryAct.Choice(text: "Ask for more clues", nextAct: 37, animation: .fadeIn)
            ]
        ),

        // Act 27
        StoryAct(
            text: "Your hand passes through the figure, and you feel a surge of cold. A memory flashes before your eyes.",
            choices: [
                StoryAct.Choice(text: "Focus on the memory", nextAct: 38, animation: nil),
                StoryAct.Choice(text: "Pull back immediately", nextAct: 22, animation: nil),
                StoryAct.Choice(text: "Ask the figure about the memory", nextAct: 39, animation: nil)
            ]
        ),

        // Act 28
        StoryAct(
            text: "You feel an invisible barrier holding you back. The figure says, 'Your choices define your path.'",
            choices: [
                StoryAct.Choice(text: "Ask it what it means", nextAct: 40, animation: nil),
                StoryAct.Choice(text: "Step back and observe", nextAct: 41, animation: nil),
                StoryAct.Choice(text: "Leave the figure behind", nextAct: 36, animation: nil)
            ]
        ),

        // Act 29
        StoryAct(
            text: "You hear a voice in the distance calling your name. It sounds familiar, but distorted.",
            choices: [
                StoryAct.Choice(text: "Follow the voice", nextAct: 42, animation: nil),
                StoryAct.Choice(text: "Ignore it and stay put", nextAct: 43, animation: nil),
                StoryAct.Choice(text: "Call back to the voice", nextAct: 44, animation: nil)
            ]
        ),

        // Act 30
        StoryAct(
            text: "You find yourself in a massive hall with four doors, each radiating a different energy. This is the final choice.",
            choices: [
                StoryAct.Choice(text: "Enter the door of light", nextAct: 60, animation: .fadeIn),
                StoryAct.Choice(text: "Enter the door of shadows", nextAct: 61, animation: nil),
                StoryAct.Choice(text: "Enter the door of chaos", nextAct: 62, animation: .shake),
                StoryAct.Choice(text: "Stay in the hall and wait", nextAct: 63, animation: nil)
            ]
        ),
        // Act 31
        StoryAct(
            text: "You try to force the door open, but it resists with an unnatural strength. A whisper echoes, 'The key is within you.'",
            choices: [
                StoryAct.Choice(text: "Search yourself for the key", nextAct: 40, animation: .fadeIn),
                StoryAct.Choice(text: "Try again with more force", nextAct: 32, animation: .shake),
                StoryAct.Choice(text: "Step back and analyze the door", nextAct: 33, animation: nil)
            ]
        ),

        // Act 32
        StoryAct(
            text: "You step into one of the mirrors, and reality bends around you. You find yourself in a forest shrouded in fog.",
            choices: [
                StoryAct.Choice(text: "Explore the forest", nextAct: 34, animation: nil),
                StoryAct.Choice(text: "Search for a way back", nextAct: 35, animation: nil),
                StoryAct.Choice(text: "Call out for help", nextAct: 36, animation: .fadeIn)
            ]
        ),

        // Act 33
        StoryAct(
            text: "You shatter the mirror, and shards scatter, creating glowing runes on the ground. A new portal opens.",
            choices: [
                StoryAct.Choice(text: "Step into the portal", nextAct: 37, animation: .shake),
                StoryAct.Choice(text: "Study the runes", nextAct: 38, animation: nil),
                StoryAct.Choice(text: "Wait and observe", nextAct: 39, animation: nil)
            ]
        ),

        // Act 34
        StoryAct(
            text: "As you explore the forest, you encounter a mysterious figure who seems to be guiding you silently.",
            choices: [
                StoryAct.Choice(text: "Follow the figure", nextAct: 40, animation: nil),
                StoryAct.Choice(text: "Ignore it and proceed alone", nextAct: 35, animation: .shake),
                StoryAct.Choice(text: "Confront the figure", nextAct: 36, animation: nil)
            ]
        ),

        // Act 35
        StoryAct(
            text: "You search for a way back, but the forest seems alive, shifting and changing with each step you take.",
            choices: [
                StoryAct.Choice(text: "Continue searching", nextAct: 38, animation: nil),
                StoryAct.Choice(text: "Stop and observe your surroundings", nextAct: 39, animation: nil),
                StoryAct.Choice(text: "Climb a tree for a better view", nextAct: 40, animation: nil)
            ]
        ),

        // Act 36
        StoryAct(
            text: "Your voice echoes through the forest, but instead of help, the echoes start to form chilling whispers.",
            choices: [
                StoryAct.Choice(text: "Cover your ears and run", nextAct: 33, animation: nil),
                StoryAct.Choice(text: "Listen to the whispers", nextAct: 34, animation: nil),
                StoryAct.Choice(text: "Shout louder to drown them out", nextAct: 37, animation: nil)
            ]
        ),

        // Act 37
        StoryAct(
            text: "The portal pulls you into a void where time and space feel meaningless. You see visions of possible futures.",
            choices: [
                StoryAct.Choice(text: "Choose a future to follow", nextAct: 39, animation: nil),
                StoryAct.Choice(text: "Try to escape the void", nextAct: 40, animation: nil),
                StoryAct.Choice(text: "Embrace the void", nextAct: 41, animation: .shake)
            ]
        ),

        // Act 38
        StoryAct(
            text: "The runes glow brighter, and you feel an ancient power flowing through you. The whispers return, now clearer.",
            choices: [
                StoryAct.Choice(text: "Follow the whispers", nextAct: 32, animation: nil),
                StoryAct.Choice(text: "Harness the power of the runes", nextAct: 40, animation: .fadeIn),
                StoryAct.Choice(text: "Erase the runes", nextAct: 35, animation: nil)
            ]
        ),

        // Act 39
        StoryAct(
            text: "You observe closely, realizing the shifting surroundings are showing you a pattern, a clue to the next step.",
            choices: [
                StoryAct.Choice(text: "Decode the pattern", nextAct: 36, animation: nil),
                StoryAct.Choice(text: "Ignore the pattern and move on", nextAct: 37, animation: nil),
                StoryAct.Choice(text: "Mark the pattern for later", nextAct: 33, animation: nil)
            ]
        ),

        // Act 40
        StoryAct(
            text: "The figure leads you to a clearing where a radiant key lies suspended in mid-air, glowing with immense power.",
            choices: [
                StoryAct.Choice(text: "Take the key", nextAct: 41, animation: nil),
                StoryAct.Choice(text: "Examine the key for traps", nextAct: 42, animation: nil),
                StoryAct.Choice(text: "Leave it untouched", nextAct: 43, animation: .shake)
            ]
        ),
        // Act 41
        StoryAct(
            text: "You take the radiant key, and an intense light engulfs you. The environment shifts to a grand ancient hall.",
            choices: [
                StoryAct.Choice(text: "Explore the hall", nextAct: 42, animation: .fadeIn),
                StoryAct.Choice(text: "Use the key immediately", nextAct: 43, animation: nil),
                StoryAct.Choice(text: "Search for hidden dangers", nextAct: 44, animation: .shake)
            ]
        ),

        // Act 42
        StoryAct(
            text: "The hall is filled with artifacts and inscriptions detailing the origin of the whispers and their creator.",
            choices: [
                StoryAct.Choice(text: "Study the inscriptions", nextAct: 45, animation: .fadeIn),
                StoryAct.Choice(text: "Ignore the artifacts and press forward", nextAct: 43, animation: nil),
                StoryAct.Choice(text: "Take an artifact for protection", nextAct: 46, animation: nil)
            ]
        ),

        // Act 43
        StoryAct(
            text: "You insert the key into a glowing pedestal. The hall trembles, revealing a hidden doorway.",
            choices: [
                StoryAct.Choice(text: "Step through the doorway", nextAct: 47, animation: nil),
                StoryAct.Choice(text: "Wait and observe", nextAct: 44, animation: nil),
                StoryAct.Choice(text: "Leave the hall", nextAct: 48, animation: nil)
            ]
        ),

        // Act 44
        StoryAct(
            text: "As you search, you find a cryptic note that reads: 'Not all who seek the truth survive it.'",
            choices: [
                StoryAct.Choice(text: "Follow the warning and leave", nextAct: 48, animation: nil),
                StoryAct.Choice(text: "Ignore it and move forward", nextAct: 45, animation: .shake),
                StoryAct.Choice(text: "Keep searching for clues", nextAct: 46, animation: nil)
            ]
        ),

        // Act 45
        StoryAct(
            text: "The inscriptions tell of a being bound by its own greed, whose power you now hold in the key.",
            choices: [
                StoryAct.Choice(text: "Release the being", nextAct: 49, animation: .shake),
                StoryAct.Choice(text: "Use the key to seal its power forever", nextAct: 50, animation: .fadeIn),
                StoryAct.Choice(text: "Abandon the key", nextAct: 48, animation: nil)
            ]
        ),

        // Act 46
        StoryAct(
            text: "The artifact you take hums with energy, altering your perception. You feel connected to the whispers.",
            choices: [
                StoryAct.Choice(text: "Use the artifact to confront the whispers", nextAct: 47, animation: nil),
                StoryAct.Choice(text: "Discard it and move forward", nextAct: 43, animation: nil),
                StoryAct.Choice(text: "Investigate its effects further", nextAct: 49, animation: nil)
            ]
        ),

        // Act 47
        StoryAct(
            text: "You step through the doorway into a realm where time stands still. Four paths appear, each glowing.",
            choices: [
                StoryAct.Choice(text: "Choose the path of knowledge", nextAct: 49, animation: nil),
                StoryAct.Choice(text: "Choose the path of power", nextAct: 50, animation: nil),
                StoryAct.Choice(text: "Choose the path of freedom", nextAct: 48, animation: nil)
            ]
        ),

        // Act 48
        StoryAct(
            text: "You turn back, choosing not to meddle further. The hall fades, and you find yourself back at the beginning.",
            choices: [
                StoryAct.Choice(text: "End the journey", nextAct: 51, animation: .shake),
                StoryAct.Choice(text: "Reflect on your choices", nextAct: 51, animation: nil),
                StoryAct.Choice(text: "Restart the journey", nextAct: 1, animation: .fadeIn)
            ]
        ),

        // Act 49
        StoryAct(
            text: "You release the being trapped by the whispers. It thanks you but warns of future consequences.",
            choices: [
                StoryAct.Choice(text: "Accept the risks and move on", nextAct: 51, animation: .shake),
                StoryAct.Choice(text: "Demand answers before leaving", nextAct: 50, animation: nil),
                StoryAct.Choice(text: "Attack the being", nextAct: 48, animation: nil)
            ]
        ),

        // Act 50
        StoryAct(
            text: "You seal the being’s power forever, ensuring no one can misuse it again. The hall begins to collapse.",
            choices: [
                StoryAct.Choice(text: "Escape to safety", nextAct: 51, animation: nil),
                StoryAct.Choice(text: "Stay and witness the end", nextAct: 51, animation: .shake),
                StoryAct.Choice(text: "Take the key with you", nextAct: 51, animation: .fadeIn)
            ]
        ),

        // Act 51 (Final Act - Closing)
        StoryAct(
            text: "Your journey comes to an end. The choices you made shaped not only your fate but the world’s balance.",
            choices: [
                StoryAct.Choice(text: "Reflect on the journey", nextAct: 1, animation: .shake),
//                StoryAct.Choice(text: "Restart the game", nextAct: 1, animation: .fadeIn)
            ]
            // Uncomment if you want to use a custom closing animation
        //    animation: .specialClosingAnimation, // Custom animation for the end screen
//            onEnter: {
//                // Trigger a unique animation for the final act
//                withAnimation(.easeInOut(duration: 3)) {
//                    // Example of fading out to a stunning end screen
//                    // endScreenView = EndScreenView()
//                }
//            }
        )


    ]

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.black, Color.gray.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Main content
            VStack {
                Spacer()
                
                // Story Text
                Text(story[currentAct].text)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.5)))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                
                Spacer()
                
                // Choices
                if showChoice {
                    ForEach(story[currentAct].choices.indices, id: \.self) { index in
                        let choice = story[currentAct].choices[index]
                        Button(action: {
                            handleChoice(choice)
                        }) {
                            Text(choice.text)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue.opacity(0.8))
                                )
                        }
                        .padding(.horizontal)
                        .transition(.scale)
                    }
                }
            }
            .padding()
            
            // Ending Screen
            if showEnding, let ending = currentEnding {
                VStack {
                    Text("THE END")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    Text(ending.rawValue)
                        .font(.title2)
                        .foregroundColor(.red)
                    Text(ending.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            animateEffect = nil
        }
    }
    
    func handleChoice(_ choice: StoryAct.Choice) {
        withAnimation {
            animateEffect = choice.animation
            currentAct = choice.nextAct
            
            // Check if it's an ending
            if let ending = story[currentAct].ending {
                currentEnding = ending
                showEnding = true
            }
        }
    }
}
