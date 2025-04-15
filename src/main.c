#include "headers/raylib.h"
#include "headers/resource_dir.h"

int main(void)
{
    InitWindow(800, 450, "Beelo's Raylib Template");
    SearchAndSetResourceDir("assets");

    Texture2D blob = LoadTexture("blob.png");
    
    while (!WindowShouldClose())
    {
        BeginDrawing();
            ClearBackground(RAYWHITE);
            DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);
            DrawTexture(blob, 400 - (blob.width / 2), 150, WHITE);
        EndDrawing();
    }

    CloseWindow();

    return 0;
}