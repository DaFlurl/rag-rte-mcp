// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.AskForHelpUI

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import com.evony.util.EvonyImage;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import com.evony.Context;
    import com.evony.data.FbData;
    import view.RandomEventWin;
    import com.evony.util.MinePopupManager;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.FlexEvent;
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

    use namespace mx_internal;

    public class AskForHelpUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AskForHelpUI_Button1:Button;
        private var _1316460709helptimes:int = 0;
        private var _738344555iconFile:EvonyImage;
        public var _AskForHelpUI_Text1:Text;
        private var _1921954855descriptText:Text;
        private var _410956671container:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":530,
                    "height":60,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"container",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"canvasGroupBackGround",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"iconFile",
                                    "events":{
                                        "mouseOver":"__iconFile_mouseOver",
                                        "mouseOut":"__iconFile_mouseOut",
                                        "mouseMove":"__iconFile_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "3";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@askforhelp.png",
                                            "width":50,
                                            "height":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_AskForHelpUI_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "0";
                                        this.left = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"contentheader2",
                                            "width":290
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"descriptText",
                                    "events":{
                                        "mouseOver":"__descriptText_mouseOver",
                                        "mouseOut":"__descriptText_mouseOut",
                                        "mouseMove":"__descriptText_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "60";
                                        this.right = "80";
                                        this.top = "25";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "htmlText":"Every  facebook friend who helps will reduce the build or research time by 1 minute or 1%, whichever is greater.",
                                            "mouseChildren":false,
                                            "styleName":"ParamgraphText2",
                                            "height":45,
                                            "width":370
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AskForHelpUI_Button1",
                                    "events":{"click":"___AskForHelpUI_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "10";
                                        this.top = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":65,
                                            "styleName":"b75",
                                            "height":22
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AskForHelpUI()
        {
            mx_internal::_document = this;
            this.width = 530;
            this.height = 60;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AskForHelpUI_Canvas1_creationComplete);
            this.addEventListener("click", ___AskForHelpUI_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AskForHelpUI._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get container():Canvas
        {
            return (this._410956671container);
        }

        private function onTreasureDescTxtMove(_arg_1:MouseEvent):void
        {
        }

        private function onItemSelectedOk(_arg_1:Boolean):void
        {
            var _local_2:Object;
            trace((((className + ".onItemSelectedOk(") + _arg_1) + ")"));
            if (_arg_1)
            {
                if (SpeedupItemSelector.getInstance().speedType == SpeedupItemSelector.ON_COIN_BUILD_SPEED)
                {
                    Context.getInstance().isSpeedType = 0;
                }
                else
                {
                    if (SpeedupItemSelector.getInstance().speedType == SpeedupItemSelector.ON_COIN_TECH_SPEED)
                    {
                        Context.getInstance().isSpeedType = 1;
                    };
                };
                if (Context.getInstance().facebookUser)
                {
                    _local_2 = FbData.getInstance().getValue(20045);
                    if (_local_2 != null)
                    {
                        RandomEventWin.show(11);
                    };
                };
                MinePopupManager.instance.removePopup();
            };
        }

        private function init():void
        {
            this.enabled = true;
            if (SpeedupItemSelector.getInstance().speedType == SpeedupItemSelector.ON_COIN_BUILD_SPEED)
            {
                this.helptimes = SpeedupItemSelector.getInstance().buildBean.help;
            }
            else
            {
                if (SpeedupItemSelector.getInstance().speedType == SpeedupItemSelector.ON_COIN_TECH_SPEED)
                {
                    this.helptimes = SpeedupItemSelector.getInstance().teachBean.help;
                };
            };
        }

        public function set container(_arg_1:Canvas):void
        {
            var _local_2:Object = this._410956671container;
            if (_local_2 !== _arg_1)
            {
                this._410956671container = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "container", _local_2, _arg_1));
            };
        }

        public function __descriptText_mouseOver(_arg_1:MouseEvent):void
        {
            onTreasureDescTxtRollOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():EvonyImage
        {
            return (this._738344555iconFile);
        }

        override public function initialize():void
        {
            var target:AskForHelpUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AskForHelpUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_AskForHelpUIWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        private function onTreasureDescTxtRollOver(_arg_1:MouseEvent):void
        {
        }

        [Bindable(event="propertyChange")]
        private function get helptimes():int
        {
            return (this._1316460709helptimes);
        }

        public function __descriptText_mouseMove(_arg_1:MouseEvent):void
        {
            onTreasureDescTxtMove(_arg_1);
        }

        public function set iconFile(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        public function __descriptText_mouseOut(_arg_1:MouseEvent):void
        {
            onTreasureDescTxtRollOut();
        }

        public function set descriptText(_arg_1:Text):void
        {
            var _local_2:Object = this._1921954855descriptText;
            if (_local_2 !== _arg_1)
            {
                this._1921954855descriptText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "descriptText", _local_2, _arg_1));
            };
        }

        private function _AskForHelpUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (("Ask For Help ( Friends helps: " + this.helptimes) + " )");
            _local_1 = Lang.msg("使用物品");
        }

        private function onTreasureDescTxtRollOut():void
        {
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function ___AskForHelpUI_Button1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        private function set helptimes(_arg_1:int):void
        {
            var _local_2:Object = this._1316460709helptimes;
            if (_local_2 !== _arg_1)
            {
                this._1316460709helptimes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "helptimes", _local_2, _arg_1));
            };
        }

        private function _AskForHelpUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("Ask For Help ( Friends helps: " + this.helptimes) + " )");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AskForHelpUI_Text1.text = _arg_1;
            }, "_AskForHelpUI_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用物品");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AskForHelpUI_Button1.label = _arg_1;
            }, "_AskForHelpUI_Button1.label");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get descriptText():Text
        {
            return (this._1921954855descriptText);
        }

        public function refresh():void
        {
            this.init();
        }

        public function ___AskForHelpUI_Canvas1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        private function onMouseOut():void
        {
        }

        private function onClick():void
        {
            AlertWin.show("Your friends will helps reduce the build or research time!", onItemSelectedOk, "Ok", "Cancel");
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
        }

        public function ___AskForHelpUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
        }


    }
}//package view.ui

