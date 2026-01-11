// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.http.multipart.Multipart

package org.httpclient.http.multipart
{
    import flash.utils.ByteArray;

    public class Multipart 
    {

        public static const BOUNDARY:String = "----------------314159265358979323846";
        private static const BOUNDARY_CHARS:String = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

        private var _partIndex:int = 0;
        private var _parts:Array = [];
        private var _bytesSent:uint = 0;
        private var _footerSent:Boolean = false;
        private var _footer:ByteArray;

        public function Multipart(_arg_1:Array)
        {
            this._parts = _arg_1;
            this._footer = this.footer();
        }

        private static function generateBoundary():String
        {
            var _local_4:Number;
            var _local_1:Number = (Math.round((Math.random() * 10)) * 30);
            var _local_2:* = "";
            var _local_3:Number = 0;
            while (_local_3 < _local_1)
            {
                _local_4 = Math.round((Math.random() * (BOUNDARY_CHARS.length - 1)));
                _local_2 = (_local_2 + BOUNDARY_CHARS.charAt(_local_4));
                _local_3++;
            };
            return (_local_2);
        }


        public function get length():uint
        {
            var _local_2:Part;
            var _local_1:uint;
            for each (_local_2 in this._parts)
            {
                _local_1 = (_local_1 + _local_2.length);
            };
            return (_local_1 + this._footer.length);
        }

        public function get currentPart():Part
        {
            if (!this.hasMoreParts)
            {
                return (null);
            };
            return (Part(this._parts[this._partIndex]));
        }

        protected function get hasMoreParts():Boolean
        {
            return (this._partIndex < this._parts.length);
        }

        public function readBytes(_arg_1:ByteArray, _arg_2:uint, _arg_3:uint):void
        {
            if (!this.hasMoreParts)
            {
                if (!this._footerSent)
                {
                    this._footer.readBytes(_arg_1, _arg_2, _arg_3);
                    this._footerSent = true;
                };
                return;
            };
            this.currentPart.readBytes(_arg_1, _arg_2, _arg_3);
            this._bytesSent = (this._bytesSent + _arg_1.length);
            if (this._bytesSent >= this.currentPart.length)
            {
                this.currentPart.close();
                this._partIndex = (this._partIndex + 1);
                this._bytesSent = 0;
            };
        }

        protected function footer():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeUTFBytes((("--" + Multipart.BOUNDARY) + "--\r\n"));
            _local_1.position = 0;
            return (_local_1);
        }

        public function get bytesAvailable():uint
        {
            if (this.hasMoreParts)
            {
                return (this.currentPart.bytesAvailable);
            };
            if (!this._footerSent)
            {
                return (this._footer.bytesAvailable);
            };
            return (0);
        }


    }
}//package org.httpclient.http.multipart

