// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.JSUtil

package com.evony.util
{
    import flash.external.ExternalInterface;
    import com.evony.Context;
    import view.ui.RegisterInfoWin;
    import view.MainWin;

    public class JSUtil 
    {

        private static var instance:JSUtil;


        public static function getInstance():JSUtil
        {
            if (instance == null)
            {
                instance = new (JSUtil)();
            };
            return (instance);
        }


        public function exitGameSet(_arg_1:Boolean):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("promptSaveGame", Context.getInstance().userName, _arg_1);
            };
        }

        public function AddFbDataCallback():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("SetFbData", SetFbDataCallback);
            };
        }

        private function exitGameCallback(_arg_1:String):void
        {
            RegisterInfoWin.show(false);
        }

        public function AddExitGameCallback():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("exitGame", exitGameCallback);
            };
        }

        private function SetFbDataCallback(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            MainWin.instance.fbBar.setFbData(_arg_1, _arg_2, _arg_3);
        }


    }
}//package com.evony.util

