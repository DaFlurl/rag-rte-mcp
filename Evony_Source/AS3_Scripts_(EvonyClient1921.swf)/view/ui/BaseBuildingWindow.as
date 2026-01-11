// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BaseBuildingWindow

package view.ui
{
    import mx.containers.Canvas;
    import com.evony.common.beans.BuildingBean;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;

    public class BaseBuildingWindow extends Canvas 
    {

        private var buildingBean:BuildingBean;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Canvas});

        public function BaseBuildingWindow()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___BaseBuildingWindow_Canvas1_creationComplete);
        }

        public function destroy():void
        {
            trace((this.className + "_BaseClass.destroy()"));
        }

        public function ___BaseBuildingWindow_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            initClass();
        }

        public function initClass():void
        {
            trace((this.className + ".initClass()"));
            this.refresh();
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function getBuildingBean():BuildingBean
        {
            return (buildingBean);
        }

        public function refresh():void
        {
            trace((this.className + "_BaseClass.refresh()"));
        }

        public function onShowEvent(_arg_1:BuildingBean):void
        {
            trace((this.className + ".onShowEvent()"));
            this.buildingBean = _arg_1;
            if (this.initialized)
            {
                this.refresh();
            };
        }


    }
}//package view.ui

