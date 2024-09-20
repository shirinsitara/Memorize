import SwiftUI
import ConfettiSwiftUI

struct Celebration: View {
    @Binding var isGameOver: Bool
    
    var body: some View {
        ZStack {
            // Your celebration content
//            ConfettiCannon(counter: $isGameOver, num: 100)
//                .frame(width: 400, height: 400)
//                .opacity(isGameOver ? 1 : 0)
//                .animation(.easeInOut(duration: 1), value: isGameOver)
            Text("you did it")
        
            if isGameOver {
                Text("Congratulations!")
            }
        }
    }
}

