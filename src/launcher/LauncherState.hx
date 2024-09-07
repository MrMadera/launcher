package launcher;

import launcher.download.DownloadingSubState;
import farfadox.utils.net.downloads.GoogleDriveDownloader;
import openfl.Assets;
import launcher.info.VersionsInfo;
import flixel.FlxState;
import sys.io.Process;

#if sys
import sys.io.File;
#end

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
        selectVersionTxt.x -= 375;
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
        updateTexts();
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

    public function updateTexts()
    {
        switch(VersionsInfo.currentVersion)
        {
            case '0.4.1':
                var path:String = VersionsInfo.getAppdata() + '/downloads/fnf_041.zip';
                var pathFolder:String = VersionsInfo.getAppdata() + '/downloads/fnf_041/';
                if(sys.FileSystem.exists(path) || sys.FileSystem.exists(pathFolder))
                {
                    playTxt.text = 'Play';
                    playTxt.screenCenter(X);
                }
                else
                {
                    playTxt.text = 'Download';
                    playTxt.screenCenter(X);
                }
            case '0.4.0':
                var path:String = VersionsInfo.getAppdata() + '/downloads/fnf_040.zip';
                var pathFolder:String = VersionsInfo.getAppdata() + '/downloads/fnf_040/';
                if(sys.FileSystem.exists(path) || sys.FileSystem.exists(pathFolder))
                {
                    playTxt.text = 'Play';
                    playTxt.screenCenter(X);
                }
                else
                {
                    playTxt.text = 'Download';
                    playTxt.screenCenter(X);
                }
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
                        var path:String = VersionsInfo.getAppdata() + '/downloads/fnf_041.zip';
                        trace('Super path: ' + path);
                        var pathFolder:String = VersionsInfo.getAppdata() + '/downloads/fnf_041/';
                        if(sys.FileSystem.exists(path) || sys.FileSystem.exists(pathFolder))
                        {
                            // Open game
                            trace('Open game!');
                            var path = 'C:\\Users\\User\\AppData\\Roaming\\MrMadera\\Launcher\\downloads\\fnf_041\\0.4.1\\Funkin.exe';
                            var process = new sys.io.Process(path);
                            Sys.exit(1);
                        }
                        else
                        {
                            // Download game
                            trace('Download game!');

                            //DownloadManager.downloadGame('https://github.com/MrMadera/launcher/raw/main/games/0.4.1.zip', savePath);
                            GoogleDriveDownloader.extension = 'zip';
                            GoogleDriveDownloader.autoUnzip = true;
                            GoogleDriveDownloader.customOutputPath = VersionsInfo.getAppdata();
                            new GoogleDriveDownloader('https://drive.google.com/file/d/1vVjTvzBsTbtihZaIky1Z8xW24ocUicEv/view?usp=sharing', 'fnf_041');
                            openSubState(new DownloadingSubState(true));
                        }
                    case '0.4.0':
                        var path:String = VersionsInfo.getAppdata() + '/downloads/fnf_040.zip';
                        var pathFolder:String = VersionsInfo.getAppdata() + '/downloads/fnf_040/';
                        if(sys.FileSystem.exists(path) || sys.FileSystem.exists(pathFolder))
                        {
                            // Open game
                            trace('Open game!');
                            var path = 'C:\\Users\\User\\AppData\\Roaming\\MrMadera\\Launcher\\downloads\\fnf_040\\0.4.0\\Funkin.exe';
                            var process = new sys.io.Process(path);
                            Sys.exit(1);
                        }
                        else
                        {
                            // Download game
                            trace('Download game!');

                            //DownloadManager.downloadGame('https://github.com/MrMadera/launcher/raw/main/games/0.4.1.zip', savePath);
                            GoogleDriveDownloader.extension = 'zip';
                            GoogleDriveDownloader.autoUnzip = true;
                            GoogleDriveDownloader.customOutputPath = VersionsInfo.getAppdata();
                            new GoogleDriveDownloader('https://drive.google.com/file/d/13_Wxf0E0C4CA8YYPNCPfVGMnazLCJ26I/view?usp=sharing', 'fnf_040');
                            openSubState(new DownloadingSubState(true));
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