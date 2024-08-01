package launcher;

import openfl.Assets;
import launcher.info.VersionsInfo;
import flixel.FlxState;

class LauncherState extends FlxState
{
    var cursorNormal:FlxSprite;
    var cursorSelected:FlxSprite;

    var bg:FlxSprite;

    var upBar:FlxSprite;
    var downBar:FlxSprite;

    var launcherTxt:FlxText;

    var playTxt:FlxText;
    var selectVersionTxt:FlxText;
    var signInTxt:FlxText;

    override function create()
    {
        super.create();

        cursorNormal = new FlxSprite(0, 0, 'assets/images/cursor/cursorSelect.png');
        cursorSelected = new FlxSprite(0, 0, 'assets/images/cursor/cursorGrab.png');

        // First load normal sprite
        FlxG.mouse.load(cursorNormal.pixels);

        bg = new FlxSprite(0, 0, 'assets/images/background.png');
        bg.antialiasing = true;
        add(bg);

        upBar = new FlxSprite().makeGraphic(1280, 105, 0xFF000000);
        add(upBar);
        
        downBar = new FlxSprite().makeGraphic(1280, 105, 0xFF000000);
        downBar.y = FlxG.height - downBar.height;
        add(downBar);

        launcherTxt = new FlxText(0, 20, FlxG.width, 'Friday night funkin launcher', 12);
        launcherTxt.setFormat('assets/fonts/FNFWeekTextFont-Regular.ttf', 70, 0xFFFFFFFF, CENTER);
        launcherTxt.antialiasing = true;
        add(launcherTxt);

        playTxt = new FlxText(0, 630, 0, 'Play', 12);
        playTxt.setFormat('assets/fonts/FNFWeekTextFont-Regular.ttf', 70, 0xFFFFFFFF, CENTER);
        playTxt.antialiasing = true;
        playTxt.screenCenter(X);
        add(playTxt);
        
        selectVersionTxt = new FlxText(0, 635, 0, 'Version', 12);
        selectVersionTxt.setFormat('assets/fonts/FNFWeekTextFont-Regular.ttf', 60, 0xFFFFFFFF, CENTER);
        selectVersionTxt.antialiasing = true;
        selectVersionTxt.screenCenter(X);
        selectVersionTxt.x -= 350;
        add(selectVersionTxt);
        
        signInTxt = new FlxText(0, 635, 0, 'Sign in', 12);
        signInTxt.setFormat('assets/fonts/FNFWeekTextFont-Regular.ttf', 60, 0xFFFFFFFF, CENTER);
        signInTxt.antialiasing = true;
        signInTxt.screenCenter(X);
        signInTxt.x += 350;
        add(signInTxt);
    }
    
    override function update(elapsed:Float)
    {
        super.update(elapsed);

        updateCursor();
        updateColors();
    }

    public function updateCursor()
    {
        if(FlxG.mouse.overlaps(playTxt) || FlxG.mouse.overlaps(selectVersionTxt) || FlxG.mouse.overlaps(signInTxt))
        {
            FlxG.mouse.load(cursorSelected.pixels);
        }
        else
        {
            FlxG.mouse.load(cursorNormal.pixels);
        }
    }

    public function updateColors()
    {
        if(FlxG.mouse.overlaps(playTxt))
        {
            playTxt.color = FlxColor.YELLOW;
            if(FlxG.mouse.justPressed)
            {
                switch(VersionsInfo.currentVersion)
                {
                    case '0.4.1':
                        var path:String = VersionsInfo.getProgramPath() + 'assets/data/games/0.4.1/Funkin.exe';
                        if(Assets.exists(path))
                        {
                            // Open game
                            trace('Open game!');
                        }
                        else
                        {
                            // Download game
                            trace('Download game!');
                        }
                }
            }
        }
        else
        {
            playTxt.color = FlxColor.WHITE;
        }
        
        if(FlxG.mouse.overlaps(selectVersionTxt))
        {
            selectVersionTxt.color = FlxColor.YELLOW;
            if(FlxG.mouse.justPressed)
            {
                FlxG.mouse.load(cursorNormal.pixels);
                openSubState(new Versions());
            }
        }
        else
        {
            selectVersionTxt.color = FlxColor.WHITE;
        }
        
        if(FlxG.mouse.overlaps(signInTxt))
        {
            signInTxt.color = FlxColor.YELLOW;
        }
        else
        {
            signInTxt.color = FlxColor.WHITE;
        }
    }
}