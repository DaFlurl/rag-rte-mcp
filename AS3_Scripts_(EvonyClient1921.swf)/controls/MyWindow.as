// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//controls.MyWindow

package controls
{
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import com.degrafa.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class MyWindow extends Canvas 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":480,
                    "height":320,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "25";
                            this.right = "25";
                            this.top = "30";
                            this.bottom = "20";
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "events":{"complete":"___MyWindow_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "source":"controls/window/cd.png"
                            });
                        }
                    })]
                });
            }
        });

        public function MyWindow()
        {
            mx_internal::_document = this;
            this.width = 480;
            this.height = 320;
            this.alpha = 1;
            this.styleName = "MyWindow";
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function doClose():void
        {
            trace("关闭窗口");
            PopUpManager.removePopUp(this);
        }

        public function ___MyWindow_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }


    }
}//package controls

