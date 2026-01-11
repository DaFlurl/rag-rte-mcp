// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BaseTooltip

package view.ui
{
    import mx.containers.Canvas;
    import mx.core.Application;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;

    public class BaseTooltip extends Canvas 
    {


        public function moveToMouse(_arg_1:MouseEvent):void
        {
            this.x = (_arg_1.stageX + 10);
            this.y = (_arg_1.stageY + 20);
            var _local_2:int = Application.application.width;
            var _local_3:int = Application.application.height;
            if ((this.x + this.width) > _local_2)
            {
                this.x = (_local_2 - this.width);
            };
            if ((this.y + this.height) > _local_3)
            {
                this.y = (_local_3 - this.height);
            };
            if (((this.x == (_local_2 - this.width)) && (this.y == (_local_3 - this.height))))
            {
                this.x = ((_arg_1.stageX - this.width) - 10);
            };
        }

        public function refresh():void
        {
        }

        public function destroy():void
        {
            PopUpManager.removePopUp(this);
        }


    }
}//package view.ui

