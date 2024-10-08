# Flutter Assessment 

## Description

This project contains the source code for a **Tic-Tac-Toe game**, where a single player competes against the computer. The game uses a basic algorithm for the computer's moves. The source code intentionally contains bugs and inefficiencies to be fixed and optimized by the developer.

![Main Game](/docs/tic_tac_toe.png)

**Grid Layout**

![Grid Layout](/docs/grid_layout.png)

## Instructions

1. **Algorithm Implementation**  
   - Implement your own algorithm by extending the existing interface.
   
2. **Bug Fixes**  
   - Fix bugs on the bottom sheet.
   
3. **UI Comparison and Corrections**  
   - Compare the UI with the provided Figma asset file and correct obvious UI mistakes (Ignore minor padding differences).
     - Files to review:
       - `lib/game/widgets/grid.dart`
       - `lib/game/widgets/game_page.dart`
       
4. **Border Corrections**  
   - Correct top-left and top-right borders on the following widget to match the design:
     - `lib/game/widgets/game_status_sheet.dart`
   
5. **UI and Widget Improvements**  
   - Find and improve UI bad practices:
     - `lib/game/widgets/grid.dart`
   
6. **Performance Enhancements**  
   - Improve build performance:
     - `lib/game/widgets/grid.dart`
   
7. **Animations**  
   - Add a game animation to improve the user experience.
   
8. **Reset Functionality**  
   - Add functionality to reset scores.
   
9. **Submission**  
   - Fork repository and submit pull request.

## Rules

- Your own algorithm should extend the class interface `IAlgorithm`.
- Bug fixes are open to interpretation. Focus, however, on the Dart files indicated.
- You are welcome to make any changes to the code if it limits your implementation.

