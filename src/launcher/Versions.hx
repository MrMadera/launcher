package launcher;

import launcher.info.VersionsInfo;
import farfadox.utils.ui.CustomButton as LauncherButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class Versions extends FlxSubState {
    private var curSelected:Int = 0;
    private var versionsGrp:FlxTypedGroup<LauncherButton>;
    
    var cursorNormal:FlxSprite;
    var cursorSelected:FlxSprite;

    override function create() {
        super.create();
        
        cursorNormal = new FlxSprite(0, 0, 'assets/images/cursor/cursorSelect.png');
        cursorSelected = new FlxSprite(0, 0, 'assets/images/cursor/cursorGrab.png');

        var bg:FlxSprite = new FlxSprite().makeGraphic(1280, 720, 0xFF000000);
        bg.alpha = 0.4;
        add(bg);

        versionsGrp = new FlxTypedGroup<LauncherButton>();
        add(versionsGrp);

        for(i in 0...VersionsInfo.versions.length) {
            var btn:LauncherButton = new LauncherButton(0, 150 + (i * 150), 250, 100, 0xFF000000, VersionsInfo.versions[i], 24, 0xFFFFFFFF, onPressVersionButton);
            btn.screenCenter(X);
            btn.ID = i;
            btn.bgSelectedColor = 0xFFFFFFFF;
            versionsGrp.add(btn);
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        updateCurselected();

        if (FlxG.keys.justPressed.ESCAPE) {
            close();
        }
        
        var cursorChanged:Bool = false;

        versionsGrp.forEach(function(i:LauncherButton) {
            if (FlxG.mouse.overlaps(i) && i.ID == curSelected) {
                FlxG.mouse.load(cursorSelected.pixels);
                cursorChanged = true;
            }
        });

        if (!cursorChanged) {
            FlxG.mouse.load(cursorNormal.pixels);
        }
    }

    public function onPressVersionButton():Void 
    {
        VersionsInfo.currentVersion = versionsGrp.members[curSelected].txt.text;
        trace('CURRENT VERSION: ' + VersionsInfo.currentVersion);

        close();
    }

    public function updateCurselected() {
        versionsGrp.forEach(function(i:LauncherButton) {
            if (FlxG.mouse.overlaps(i)) {
                curSelected = i.ID;
            }
        });
    }
}
