package launcher.info;

class VersionsInfo
{
    public static var versions:Array<String> = [
        '0.4.1',
        '0.4.0'
    ];

    public static var currentVersion:String = '0.4.1';
    
    public static function getProgramPath(folder:String = 'MrMadera')
    {
        #if sys
        return Sys.programPath();
        #end
    }
}