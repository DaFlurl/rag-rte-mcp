// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.forge.Forge

package view.module.forge
{
    import view.ui.BaseBuildingWindow;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.ItemClickEvent;

    public class Forge extends BaseBuildingWindow 
    {

        public static const EVENT_SHOW:String = "Forge.show";

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":BaseBuildingWindow});

        public function Forge()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
        }

        override public function refresh():void
        {
            super.refresh();
        }


    }
}//package view.module.forge

