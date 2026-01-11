// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.TextAndSound

package view.module.guide
{
    import mx.core.UIComponent;
    import flash.media.SoundChannel;
    import flash.media.Sound;
    import flash.events.Event;
    import view.MainWin;
    import flash.net.URLRequest;

    public class TextAndSound extends UIComponent 
    {

        public static const EVENT_COMPLETE:String = "eventComplete";

        private var _channel:SoundChannel;
        private var _sound:Sound;
        private var _textLoaded:Boolean;
        private var _soundLoaded:Boolean;


        private function soundLoaded(_arg_1:Event):void
        {
            _textLoaded = true;
            _soundLoaded = true;
            checkFinish();
        }

        public function stop():void
        {
            if (_channel)
            {
                _channel.stop();
            };
        }

        private function textLoaded(_arg_1:Event):void
        {
        }

        public function play():void
        {
            if ((((MainWin.instance) && (MainWin.instance.guideLady)) && (MainWin.instance.guideLady._needSound)))
            {
                _channel = new SoundChannel();
                _channel = _sound.play();
                _channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
            };
        }

        private function onComplete(_arg_1:Event):void
        {
            MainWin.instance.guideLady.b_paly = true;
        }

        public function playOn():void
        {
            if (_channel)
            {
                _channel = _sound.play();
            };
        }

        public function source(_arg_1:String, _arg_2:String=null):void
        {
            if (MainWin.instance.guideLady._needSound)
            {
                _sound = new Sound();
                _sound.addEventListener(Event.COMPLETE, soundLoaded);
                _sound.load(new URLRequest(_arg_2));
            }
            else
            {
                _textLoaded = true;
                checkFinish();
            };
        }

        private function checkFinish():void
        {
            if (MainWin.instance.guideLady._needSound)
            {
                if (((_textLoaded) && (_soundLoaded)))
                {
                    dispatchEvent(new Event(EVENT_COMPLETE));
                };
            }
            else
            {
                dispatchEvent(new Event(EVENT_COMPLETE));
            };
        }


    }
}//package view.module.guide

