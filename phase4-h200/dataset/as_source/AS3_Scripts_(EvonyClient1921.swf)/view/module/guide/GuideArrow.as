// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.GuideArrow

package view.module.guide
{
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import flash.display.Sprite;
    import mx.core.UIComponent;
    import com.evony.Context;
    import com.evony.util.ResourceLoader;

    public class GuideArrow extends Canvas 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Canvas});
        public var type:String;

        public function GuideArrow()
        {
            mx_internal::_document = this;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.addEventListener("creationComplete", ___GuideArrow_Canvas1_creationComplete);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function ___GuideArrow_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function resourceReady(_arg_1:Object):void
        {
            var _local_2:Sprite = (_arg_1 as Sprite);
            var _local_3:UIComponent = new UIComponent();
            this.addChild(_local_3);
            _local_3.addChild(_local_2);
        }

        private function init():void
        {
            if (Context.getInstance().needUserGuide)
            {
                ResourceLoader.loadResource("fla/dynamic/guide.swf", this.type, resourceReady, ResourceLoader.LOAD_DEMAND);
            };
        }


    }
}//package view.module.guide

