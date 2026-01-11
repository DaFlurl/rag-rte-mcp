// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.RSLListLoader

package mx.core
{
    import flash.events.Event;

    public class RSLListLoader 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var chainedSecurityErrorHandler:Function;
        private var chainedIOErrorHandler:Function;
        private var rslList:Array = [];
        private var chainedRSLErrorHandler:Function;
        private var chainedCompleteHandler:Function;
        private var currentIndex:int = 0;
        private var chainedProgressHandler:Function;

        public function RSLListLoader(_arg_1:Array)
        {
            this.rslList = _arg_1;
        }

        private function loadNext():void
        {
            if (!isDone())
            {
                currentIndex++;
                if (currentIndex < rslList.length)
                {
                    rslList[currentIndex].load(chainedProgressHandler, listCompleteHandler, listIOErrorHandler, listSecurityErrorHandler, chainedRSLErrorHandler);
                };
            };
        }

        public function getIndex():int
        {
            return (currentIndex);
        }

        public function load(_arg_1:Function, _arg_2:Function, _arg_3:Function, _arg_4:Function, _arg_5:Function):void
        {
            chainedProgressHandler = _arg_1;
            chainedCompleteHandler = _arg_2;
            chainedIOErrorHandler = _arg_3;
            chainedSecurityErrorHandler = _arg_4;
            chainedRSLErrorHandler = _arg_5;
            currentIndex = -1;
            loadNext();
        }

        private function listCompleteHandler(_arg_1:Event):void
        {
            if (chainedCompleteHandler != null)
            {
                chainedCompleteHandler(_arg_1);
            };
            loadNext();
        }

        public function isDone():Boolean
        {
            return (currentIndex >= rslList.length);
        }

        private function listSecurityErrorHandler(_arg_1:Event):void
        {
            if (chainedSecurityErrorHandler != null)
            {
                chainedSecurityErrorHandler(_arg_1);
            };
        }

        public function getItemCount():int
        {
            return (rslList.length);
        }

        public function getItem(_arg_1:int):RSLItem
        {
            if (((_arg_1 < 0) || (_arg_1 >= rslList.length)))
            {
                return (null);
            };
            return (rslList[_arg_1]);
        }

        private function listIOErrorHandler(_arg_1:Event):void
        {
            if (chainedIOErrorHandler != null)
            {
                chainedIOErrorHandler(_arg_1);
            };
        }


    }
}//package mx.core

