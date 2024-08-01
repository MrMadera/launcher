package launcher.download;

#if sys
import sys.io.File;
#end
import haxe.Http;
import haxe.io.Bytes;
import haxe.zip.Uncompress;

class DownloadManager 
{
    public static function downloadGame(url:String, destination:String):Void {
        #if sys
            var request = new Http(url);
            request.onData = function(data:String):Void {
                var bytes:Bytes = Bytes.ofString(data);
                File.saveBytes(destination, bytes);
                trace("Download completed!");
                unZipGame(destination);
            };
            request.onError = function(message:String):Void {
                trace("Error during download: " + message);
            };
            request.request();
        #end
    }

    public static function unZipGame(zipFilePath:String):Void 
    {
        #if sys
            try {
                var bytes = sys.io.File.getBytes(zipFilePath);
                var input = new haxe.io.BytesInput(bytes);
                var buffer = haxe.io.Bytes.alloc(1024);
                
                while (true) {
                try {
                    var readBytes = input.readBytes(buffer, 0, buffer.length);
                    if (readBytes == 0) break;
                    
                    var outputPath = zipFilePath.substring(0, zipFilePath.lastIndexOf('/')); 
                    var outputPathFile = outputPath + "/" + buffer.readString(0, readBytes);

                    sys.io.File.saveBytes(outputPathFile, buffer);
                } catch (e:Dynamic) {
                    if (e is haxe.io.Eof) break;
                    throw e;
                }
                }

                trace("Unzip completed!");

            } 
            catch (e:Dynamic) 
            {
                trace("Unzip error: " + e);
            }
        #end
    }
}