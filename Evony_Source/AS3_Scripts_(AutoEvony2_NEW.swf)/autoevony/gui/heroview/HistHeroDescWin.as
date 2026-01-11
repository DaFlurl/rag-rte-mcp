// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.heroview.HistHeroDescWin

package autoevony.gui.heroview
{
    import mx.containers.Canvas;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class HistHeroDescWin extends Canvas 
    {

        private var _90814320_desc:TextArea;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":300,
                    "width":400,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Hero Info"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "15";
                            this.top = "50";
                            this.bottom = "15";
                            this.right = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_desc",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.right = "5";
                                        this.top = "5";
                                        this.bottom = "5";
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "editable":false,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HistHeroDescWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var closeFunc:Function = null;

        public function HistHeroDescWin()
        {
            mx_internal::_document = this;
            this.height = 300;
            this.width = 400;
        }

        public function set _desc(_arg_1:TextArea):void
        {
            var _local_2:Object = this._90814320_desc;
            if (_local_2 !== _arg_1)
            {
                this._90814320_desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_desc", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get _desc():TextArea
        {
            return (this._90814320_desc);
        }

        private function close():void
        {
            this.closeFunc.apply(null, [this]);
        }

        public function ___HistHeroDescWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        public function updateInfo(_arg_1:Object, _arg_2:Function=null):void
        {
            this.closeFunc = _arg_2;
            this._desc.text = (_arg_1 as String);
        }


    }
}//package autoevony.gui.heroview

