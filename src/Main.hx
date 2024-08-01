package;

import flixel.FlxGame;
import openfl.display.Sprite;
import launcher.LauncherState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, LauncherState));

        //FlxG.mouse.useSystemCursor = true;
        
        var cursorNormal:FlxSprite = new FlxSprite(0, 0, 'assets/images/cursor/cursorSelect.png');
        FlxG.mouse.load(cursorNormal.pixels);
	}
}