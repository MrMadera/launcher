package launcher.download;

import farfadox.utils.net.downloads.GoogleDriveDownloader;
import farfadox.utils.net.downloads.MediafireDownloader;

import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxG;

enum DownloadType
{
    GDRIVE;
    MEDIAFIRE;
} 

class DownloadingSubState extends FlxSubState
{
    public var isGDrive:Bool;

    public var downloadStatus:FlxText;
    public var downloadBytesStatus:FlxText;
    public var processBar:FlxBar;

    public var percent:Float;

    public function new(_isGDrive:Bool) 
    {
        super();

        isGDrive = _isGDrive;
        
        var bg:FlxSprite = new FlxSprite().makeGraphic(1280, 720, 0xFF000000);
        bg.alpha = 0.6;
        add(bg);

        downloadStatus = new FlxText(0, 266, 0, '');
		downloadStatus.setFormat("VCR OSD Mono", 46, FlxColor.WHITE, LEFT);
        add(downloadStatus);

        downloadBytesStatus = new FlxText(0, 333, 0, '');
		downloadBytesStatus.setFormat("VCR OSD Mono", 46, FlxColor.WHITE, LEFT);
        add(downloadBytesStatus);

        processBar = new FlxBar(0, 400, LEFT_TO_RIGHT, 666, 10, this, 'percent', 0, 1);
        processBar.createFilledBar(FlxColor.GRAY, 0xFFFFFFFF);
        processBar.screenCenter(X);
        add(processBar);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        updateTexts(isGDrive ? DownloadType.GDRIVE : DownloadType.MEDIAFIRE);

        if(FlxG.keys.justPressed.ESCAPE)
        {
            if(GoogleDriveDownloader.canCancelDownloads)
            {
                GoogleDriveDownloader.canceledDownload = true;
                new FlxTimer().start(0.8, function(tmr:FlxTimer)
                {
                    close();
                });
                trace('Cancel this pls!');
            }
            else
            {
                close();
            }

            if(MediafireDownloader.canCancelDownloads)
            {
                MediafireDownloader.canceledDownload = true;
                new FlxTimer().start(0.8, function(tmr:FlxTimer)
                {
                    close();
                });
                trace('Cancel this pls!');
            }
            else
            {
                close();
            }
        }
    }

    public function updateTexts(type:DownloadType)
    {
        switch(type)
        {
            case GDRIVE:
                downloadStatus.text = GoogleDriveDownloader.downloadStatus;
                downloadStatus.screenCenter(X);

                downloadBytesStatus.visible = GoogleDriveDownloader.downloadStatus == 'Downloading...';
                processBar.visible = downloadBytesStatus.visible;
                downloadBytesStatus.text = GoogleDriveDownloader.loadedBytes(GoogleDriveDownloader.bytesDownloaded) + '/' + GoogleDriveDownloader.loadedBytes(GoogleDriveDownloader.totalBytes);
                downloadBytesStatus.screenCenter(X);

                percent = GoogleDriveDownloader.bytesDownloaded / GoogleDriveDownloader.totalBytes;
                
            case MEDIAFIRE:
                // nothing
                downloadStatus.text = MediafireDownloader.downloadStatus;
                downloadStatus.screenCenter(X);

                downloadBytesStatus.visible = MediafireDownloader.downloadStatus == 'Downloading...';
                processBar.visible = downloadBytesStatus.visible;
                downloadBytesStatus.text = MediafireDownloader.loadedBytes(MediafireDownloader.bytesDownloaded) + '/' + MediafireDownloader.loadedBytes(MediafireDownloader.totalBytes);
                downloadBytesStatus.screenCenter(X);

                percent = MediafireDownloader.bytesDownloaded / MediafireDownloader.totalBytes;
        }
    }
}