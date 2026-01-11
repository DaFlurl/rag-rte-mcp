// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.doubleBuilding

package view
{
    import mx.containers.Canvas;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import flash.net.SharedObject;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
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
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class doubleBuilding extends Canvas 
    {

        public static var instance:doubleBuilding = new (doubleBuilding)();

        private var _1039690024notice:Text;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":540,
                    "height":200,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"System",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"notice",
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.textAlign = "left";
                            this.top = "80";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Congratulations!All new players can build two buildings at one time in 72 hours.",
                                "percentWidth":80,
                                "styleName":"ParamgraphText1",
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___doubleBuilding_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    })]
                });
            }
        });

        public function doubleBuilding()
        {
            mx_internal::_document = this;
            this.width = 540;
            this.height = 200;
        }

        public static function show():void
        {
            var _local_1:SharedObject = SharedObject.getLocal("doubleBuilding", "/");
            if (_local_1.data.value != null)
            {
                return;
            };
            _local_1.data.value = "First";
            _local_1.flush();
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___doubleBuilding_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function set notice(_arg_1:Text):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
            };
        }


    }
}//package view

