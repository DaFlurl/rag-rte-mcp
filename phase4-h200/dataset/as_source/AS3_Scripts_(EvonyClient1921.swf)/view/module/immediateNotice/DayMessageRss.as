// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.immediateNotice.DayMessageRss

package view.module.immediateNotice
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.GameConfig;
    import com.evony.Lang;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    use namespace mx_internal;

    public class DayMessageRss extends Canvas implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "DayMessageRss.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _DayMessageRss_Button1:Button;
        private var newscount:uint = 4;
        private var _1367706280canvas:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"canvas",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":582,
                                "height":374,
                                "styleName":"TipDay",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 18;
                                        this.fontWeight = "bold";
                                        this.color = 0x2A1600;
                                        this.top = "65";
                                        this.left = "270";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"text":"Tips:"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "100";
                                        this.left = "260";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "name":"label1",
                                            "selectable":true,
                                            "text":"",
                                            "styleName":"LabelBlack16"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "130";
                                        this.left = "260";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "name":"label2",
                                            "selectable":true,
                                            "text":"",
                                            "styleName":"LabelBlack16"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "160";
                                        this.left = "260";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "name":"label3",
                                            "selectable":true,
                                            "text":"",
                                            "styleName":"LabelBlack16"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "190";
                                        this.left = "260";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "name":"label4",
                                            "selectable":true,
                                            "text":"",
                                            "styleName":"LabelBlack16"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_DayMessageRss_Button1",
                                    "events":{"click":"___DayMessageRss_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "25";
                                        this.left = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"YellowButton"});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function DayMessageRss()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___DayMessageRss_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            DayMessageRss._watcherSetupUtil = _arg_1;
        }


        private function loadFailure():void
        {
            onExit();
        }

        private function loadDayMsg():void
        {
            UIUtil.loadFile(GameConfig.instance.newsRSS, loadDayMsgHandle, loadFailure);
        }

        private function _DayMessageRss_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("我确定");
        }

        private function loadDayMsgHandle(_arg_1:Object):void
        {
            this.visible = true;
            var _local_2:XMLList = XML(_arg_1).channel.child("item");
            setLabelText(_local_2);
        }

        public function ___DayMessageRss_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onExit():void
        {
        }

        override public function initialize():void
        {
            var target:DayMessageRss;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DayMessageRss_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_immediateNotice_DayMessageRssWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        public function get canvas():Canvas
        {
            return (this._1367706280canvas);
        }

        public function ___DayMessageRss_Button1_click(_arg_1:MouseEvent):void
        {
            onExit();
        }

        private function init():void
        {
            this.visible = false;
            loadDayMsg();
        }

        public function set canvas(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1367706280canvas;
            if (_local_2 !== _arg_1)
            {
                this._1367706280canvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canvas", _local_2, _arg_1));
            };
        }

        private function _DayMessageRss_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("我确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DayMessageRss_Button1.label = _arg_1;
            }, "_DayMessageRss_Button1.label");
            result[0] = binding;
            return (result);
        }

        private function setLabelText(_arg_1:XMLList):void
        {
            var _local_2:uint = ((newscount > _arg_1.length()) ? _arg_1.length() : newscount);
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                (canvas.getChildByName(("label" + (_local_3 + 1))) as Label).htmlText = ((((((_local_3 + 1) + ".<a href='") + _arg_1[_local_3].link) + "' target='_blank'>") + _arg_1[_local_3].title) + "</a>");
                _local_3++;
            };
        }


    }
}//package view.module.immediateNotice

