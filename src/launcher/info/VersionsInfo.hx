package launcher.info;

class VersionsInfo
{
    public static var versions:Array<String> = [
        '0.4.1',
        '0.4.0'
    ];

    public static var currentVersion:String = '0.4.1';
    
    public static function getAppdata(folder:String = 'MrMadera')
    {
        var company:String = #if (flixel < "5.0.0") folder #else FlxG.stage.application.meta.get('company');
        @:privateAccess
        var file:String = FlxSave.validate(FlxG.stage.application.meta.get('file')); #end
        #if sys
        return Sys.getEnv("APPDATA") + "/" + company + "/" + file;
        #end
    }
}