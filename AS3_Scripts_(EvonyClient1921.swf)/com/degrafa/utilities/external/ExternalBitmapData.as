// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.utilities.external.ExternalBitmapData

package com.degrafa.utilities.external
{
    import flash.display.BitmapData;
    import flash.display.Loader;

    public class ExternalBitmapData extends ExternalDataAsset implements IExternalData 
    {

        private var tempBitmapdata:BitmapData;

        public function ExternalBitmapData(_arg_1:String=null, _arg_2:Number=NaN, _arg_3:LoadingLocation=null)
        {
            dataType = BitmapData;
            super(_arg_1, _arg_2, Loader);
        }

        public static function getUniqueInstance(_arg_1:String=null, _arg_2:LoadingLocation=null):ExternalBitmapData
        {
            return (ExternalDataAsset.getUniqueInstance(_arg_1, _arg_2, ExternalBitmapData) as ExternalBitmapData);
        }


        override protected function processLoad(loader:Object):String
        {
            tempBitmapdata = (_data as BitmapData);
            var err:Boolean;
            try
            {
                _data = new BitmapData((loader as Loader).content.width, (loader as Loader).content.height, true, 0);
                _data.draw((loader as Loader).content);
            }
            catch(e:Error)
            {
                err = true;
            };
            (loader as Loader).unload();
            if (!err)
            {
                return (ExternalDataAsset.STATUS_READY);
            };
            return (ExternalDataAsset.STATUS_SECURITY_ERROR);
        }

        override protected function cleanUp():void
        {
            if (tempBitmapdata)
            {
                tempBitmapdata.dispose();
            };
            tempBitmapdata = null;
        }


    }
}//package com.degrafa.utilities.external

