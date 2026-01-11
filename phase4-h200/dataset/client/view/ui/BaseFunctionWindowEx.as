// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BaseFunctionWindowEx

package view.ui
{
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.core.mx_internal;
    import view.castle.MainFrame;
    import view.MainWin;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import flash.events.Event;
    import mx.events.FlexEvent;

    public class BaseFunctionWindowEx extends BaseWindow 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":550
                });
            }
        });
        private var myWin:MyWindow;
        public var title:String = "";
        private var winTitle:WinTitle;

        public function BaseFunctionWindowEx()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 550;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("initialize", ___BaseFunctionWindowEx_BaseWindow1_initialize);
        }

        public function initClass():void
        {
            trace(((this.className + ".initClass() ") + this.numChildren));
            winTitle = new WinTitle();
            winTitle.title = title;
            winTitle.addEventListener("onClose", onClose);
            this.addChild(winTitle);
            myWin = new MyWindow();
            myWin.x = 0;
            myWin.y = 0;
            myWin.width = this.width;
            myWin.height = this.height;
            this.addChildAt(myWin, 0);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        protected function onClose(_arg_1:Event):void
        {
            if (MainFrame.instance != null)
            {
                MainWin.instance.addMoneyPic.visible = false;
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

        public function ___BaseFunctionWindowEx_BaseWindow1_initialize(_arg_1:FlexEvent):void
        {
            initClass();
        }


    }
}//package view.ui

