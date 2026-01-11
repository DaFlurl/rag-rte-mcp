// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//EvonyClient_Miniloading

package 
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class EvonyClient_Miniloading extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

        public var dataClass:Class = EvonyClient_Miniloading_dataClass;

        public function EvonyClient_Miniloading()
        {
            initialWidth = (1580 / 20);
            initialHeight = (1580 / 20);
        }

        override public function get movieClipData():ByteArray
        {
            if (bytes == null)
            {
                bytes = ByteArray(new dataClass());
            };
            return (bytes);
        }


    }
}//package 

