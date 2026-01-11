// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BaseFunctionWindow

package view.ui
{
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import view.castle.MainFrame;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import flash.events.Event;
    import mx.events.FlexEvent;

    public class BaseFunctionWindow extends BaseWindow 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":495
                });
            }
        });
        public var title:String = "";
        private var winTitle:WinTitle;

        public function BaseFunctionWindow()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 495;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.styleName = "BaseFunctionWindow";
            this.addEventListener("creationComplete", ___BaseFunctionWindow_BaseWindow1_creationComplete);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function initClass():void
        {
            trace(((this.className + ".initClass() ") + this.numChildren));
            winTitle = new WinTitle();
            winTitle.title = title;
            winTitle.addEventListener("onClose", onClose);
            this.addChild(winTitle);
        }

        protected function onClose(_arg_1:Event):void
        {
            if (MainFrame.instance != null)
            {
                if (MainFrame.instance.currentView == MainFrame.instance.townView)
                {
                    MainFrame.instance.townView.restorePlayAll();
                }
                else
                {
                    if (MainFrame.instance.currentView == MainFrame.instance.cityView)
                    {
                        MainFrame.instance.cityView.restorePlayAll();
                    }
                    else
                    {
                        if (MainFrame.instance.currentView == MainFrame.instance.mapWin)
                        {
                            MainFrame.instance.mapWin.restorePlayAll();
                        };
                    };
                };
            };
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
        }

        public function ___BaseFunctionWindow_BaseWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            initClass();
        }


    }
}//package view.ui

