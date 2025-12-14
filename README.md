# FangRunner

FangRunner is a 2D platformer game developed using the Godot Engine. You play as a werewolf battling enemies through multiple levels.

## Features

*   Classic 2D platformer gameplay
*   Multiple levels to explore
*   Various enemies including skeletons and demons
*   Collectable gems
*   Main Menu, Pause Screen, and Game Over Screen

## Controls

*   **Left/Right Arrow Keys:** Move the player left and right.
*   **Spacebar / Enter:** Jump.
*   **Escape Key:** Pause the game.

## Project Structure

The project is organized into the following main directories:

*   `Player/`: Contains the player character scene and script.
*   `Enemies/`: Contains the enemy scenes and scripts (Skeleton, Demon).
*   `Worlds/`: Contains the game level scenes (`world.tscn`, `world_2.tscn`, etc.).
*   `Collectables/`: Contains collectable items like the Gem.
*   `UI/`: Contains user interface scenes like the main menu, game over screen, and pause menu.
*   `Assets/`: Contains all the art and audio assets for the game, organized into subdirectories for characters, environments, UI, and music.
*   `Global/`: Contains global scripts for managing game state (`Game.gd`).

## How to Run the Project

1.  Download and install the Godot Engine (version 4.x is recommended).
2.  Clone or download this repository.
3.  Open the Godot Engine.
4.  Click "Import" and navigate to the cloned/downloaded project folder.
5.  Select the `project.godot` file.
6.  Once the project is imported, click the "Play" button in the top right corner of the editor to run the game.
