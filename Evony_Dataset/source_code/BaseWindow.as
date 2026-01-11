// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BaseWindow

package view.ui
{
    import mx.containers.Canvas;
    import mx.events.FlexEvent;
    import com.evony.common.MouseManager;

    public class BaseWindow extends Canvas 
    {

        public var eventData:Object = null;
        private var show:Boolean = false;

        public function BaseWindow()
        {
            this.addEventListener(FlexEvent.CREATION_COMPLETE, init, false, -1);
        }

        private function init(_arg_1:FlexEvent):void
        {
            MouseManager.setNormal();
            if (this.show)
            {
                this.refresh();
            };
        }

        public function destroy():void
        {
            trace((this.className + " BaseClass.destroy()"));
        }

        public function refresh():void
        {
            trace((this.className + " BaseClass.refresh()"));
        }

        public function onShowEvent():void
        {
            trace((this.className + " onShowEvent()"));
            this.show = true;
            if (this.initialized)
            {
                this.refresh();
            }
            else
            {
                MouseManager.setBusy();
            };
        }


    }
}//package view.ui

