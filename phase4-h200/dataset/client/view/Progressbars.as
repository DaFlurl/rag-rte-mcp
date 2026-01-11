// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.Progressbars

package view
{
    import mx.preloaders.DownloadProgressBar;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.events.ProgressEvent;
    import flash.display.Sprite;
    import flash.external.ExternalInterface;

    public class Progressbars extends DownloadProgressBar 
    {

        public function Progressbars()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onProgressAddedToStage);
        }

        private function completeHandlers(_arg_1:Event):void
        {
        }

        private function onProgressAddedToStage(_arg_1:Event):void
        {
        }

        private function initComHandler(_arg_1:FlexEvent):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function initHandler(_arg_1:FlexEvent):void
        {
        }

        override public function set preloader(_arg_1:Sprite):void
        {
            _arg_1.addEventListener(ProgressEvent.PROGRESS, progessHandler);
            _arg_1.addEventListener(Event.COMPLETE, completeHandlers);
            _arg_1.addEventListener(FlexEvent.INIT_COMPLETE, initComHandler);
            _arg_1.addEventListener(FlexEvent.INIT_PROGRESS, initHandler);
        }

        private function progessHandler(_arg_1:ProgressEvent):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("processHandler", _arg_1.bytesLoaded, _arg_1.bytesTotal);
            };
        }


    }
}//package view

