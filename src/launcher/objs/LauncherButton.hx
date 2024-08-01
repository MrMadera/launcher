package launcher.objs;

class LauncherButton extends FlxSpriteGroup
{
    public var bgSelectedColor:FlxColor = 0xFFfe4900;
    public var txtSelectedColor:FlxColor = 0xFF000000;
    public var text:String;
    public var bgColor:FlxColor;
    public var txtColor:FlxColor;
    public var bgWidth:Int;
    public var bgHeight:Int;
    public var onPress:Void -> Void;
    var bg:FlxSprite;
    var txt:FlxText;

    public function new(x:Float, y:Float, width:Int, height:Int, _bgColor:FlxColor, _text:String, size:Int, _txtColor:FlxColor, _onPress:Void -> Void)
    {
        bgColor = _bgColor;
        txtColor = _txtColor;
        bgWidth = width;
        bgHeight = height;
        onPress = _onPress;
        text = _text;

        super(x, y);

        bg = new FlxSprite().makeGraphic(width, height, _bgColor);
        add(bg);

        txt = new FlxText(0, 0, bg.width, _text, size);
        txt.setFormat('assets/fonts/FNFWeekTextFont-Regular.ttf', size, _txtColor, CENTER);
        txt.y = (bg.height / 2) - (txt.height / 2);
        add(txt);
    }

    public override function update(elapsed:Float)
    {
        super.update(elapsed);

        if(FlxG.mouse.overlaps(this))
        {
            bg.makeGraphic(bgWidth, bgHeight, bgSelectedColor);
            txt.color = txtSelectedColor;
            if(FlxG.mouse.justPressed)
            {
                onPress();
            }
        }
        else
        {
            bg.makeGraphic(bgWidth, bgHeight, bgColor);
            txt.color = txtColor;
        }
    }
}