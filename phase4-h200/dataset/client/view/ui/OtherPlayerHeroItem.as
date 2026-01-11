// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.OtherPlayerHeroItem

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.Image;
    import com.evony.common.beans.HeroBean;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
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

    public class OtherPlayerHeroItem extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _619105883heroName:TextArea;
        private var _619252845heroIcon:Image;
        public var _OtherPlayerHeroItem_TextArea7:TextArea;
        private var _811312001heroMes:HeroBean;
        private var _2014132310heroLevel:TextArea;
        public var _OtherPlayerHeroItem_TextArea3:TextArea;
        public var _OtherPlayerHeroItem_TextArea4:TextArea;
        public var _OtherPlayerHeroItem_TextArea5:TextArea;
        public var _OtherPlayerHeroItem_TextArea6:TextArea;
        public var _OtherPlayerHeroItem_TextArea8:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":430,
                    "height":117,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"heroIcon",
                        "events":{"complete":"__heroIcon_complete"},
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "250";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Name:",
                                "height":20,
                                "styleName":"focusColor",
                                "y":10,
                                "width":80
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroName",
                        "stylesFactory":function ():void
                        {
                            this.top = "8";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "styleName":"labelWithBackGround",
                                "height":20,
                                "selectable":false,
                                "width":85,
                                "x":179
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "250";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Level:",
                                "height":20,
                                "styleName":"focusColor",
                                "y":39,
                                "width":80
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroLevel",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "y":35,
                                "selectable":false,
                                "width":85,
                                "x":179
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "250";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":64,
                                "text":"Strength:",
                                "width":80,
                                "height":20,
                                "styleName":"focusColor"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_OtherPlayerHeroItem_TextArea3",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "y":61,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "width":85,
                                "x":179
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.right = "250";
                            this.textAlign = "right";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":89,
                                "text":"Speed:",
                                "width":80,
                                "height":20,
                                "styleName":"focusColor"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_OtherPlayerHeroItem_TextArea4",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "y":86,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "width":85,
                                "x":179
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "80";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":10,
                                "text":"Politics:",
                                "width":105,
                                "height":20,
                                "styleName":"focusColor"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_OtherPlayerHeroItem_TextArea5",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.top = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "width":75,
                                "x":350
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "80";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":39,
                                "text":"Attack:",
                                "height":20,
                                "width":105,
                                "styleName":"focusColor"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_OtherPlayerHeroItem_TextArea6",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "y":35,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "width":75,
                                "x":350
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "80";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":64,
                                "text":"Intelligence:",
                                "height":20,
                                "styleName":"focusColor",
                                "width":105
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_OtherPlayerHeroItem_TextArea7",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "y":60,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "width":75,
                                "x":350
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.right = "80";
                            this.textAlign = "right";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":89,
                                "text":"Attribute:",
                                "width":105,
                                "height":20,
                                "styleName":"focusColor"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_OtherPlayerHeroItem_TextArea8",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "y":86,
                                "height":20,
                                "styleName":"labelWithBackGround",
                                "width":75,
                                "x":350
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "150";
                            this.top = "35";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/Controls/tab/line.png",
                                "percentWidth":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "150";
                            this.top = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/Controls/tab/line.png",
                                "percentWidth":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "150";
                            this.top = "84";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/Controls/tab/line.png",
                                "percentWidth":100
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

        public function OtherPlayerHeroItem()
        {
            mx_internal::_document = this;
            this.width = 430;
            this.height = 117;
            this.styleName = "textBackground";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            OtherPlayerHeroItem._watcherSetupUtil = _arg_1;
        }


        public function __heroIcon_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        private function _OtherPlayerHeroItem_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (heroMes.logoUrl);
            }, function (_arg_1:Object):void
            {
                heroIcon.source = _arg_1;
            }, "heroIcon.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroName.text = _arg_1;
            }, "heroName.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.level;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroLevel.text = _arg_1;
            }, "heroLevel.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.stamina + "/") + heroMes.maxStrength);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHeroItem_TextArea3.text = _arg_1;
            }, "_OtherPlayerHeroItem_TextArea3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.speed;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHeroItem_TextArea4.text = _arg_1;
            }, "_OtherPlayerHeroItem_TextArea4.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (heroMes.politics + heroMes.management);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHeroItem_TextArea5.text = _arg_1;
            }, "_OtherPlayerHeroItem_TextArea5.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (heroMes.power + heroMes.attack);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHeroItem_TextArea6.text = _arg_1;
            }, "_OtherPlayerHeroItem_TextArea6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (heroMes.intelligence + heroMes.stratagem);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHeroItem_TextArea7.text = _arg_1;
            }, "_OtherPlayerHeroItem_TextArea7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.remainPoint;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHeroItem_TextArea8.text = _arg_1;
            }, "_OtherPlayerHeroItem_TextArea8.text");
            result[8] = binding;
            return (result);
        }

        public function set heroName(_arg_1:TextArea):void
        {
            var _local_2:Object = this._619105883heroName;
            if (_local_2 !== _arg_1)
            {
                this._619105883heroName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroIcon():Image
        {
            return (this._619252845heroIcon);
        }

        private function _OtherPlayerHeroItem_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = heroMes.logoUrl;
            _local_1 = heroMes.name;
            _local_1 = heroMes.level;
            _local_1 = ((heroMes.stamina + "/") + heroMes.maxStrength);
            _local_1 = heroMes.speed;
            _local_1 = (heroMes.politics + heroMes.management);
            _local_1 = (heroMes.power + heroMes.attack);
            _local_1 = (heroMes.intelligence + heroMes.stratagem);
            _local_1 = heroMes.remainPoint;
        }

        override public function initialize():void
        {
            var target:OtherPlayerHeroItem;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _OtherPlayerHeroItem_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_OtherPlayerHeroItemWatcherSetupUtil");
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

        public function set heroLevel(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2014132310heroLevel;
            if (_local_2 !== _arg_1)
            {
                this._2014132310heroLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLevel", _local_2, _arg_1));
            };
        }

        public function set heroMes(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._811312001heroMes;
            if (_local_2 !== _arg_1)
            {
                this._811312001heroMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroMes", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroName():TextArea
        {
            return (this._619105883heroName);
        }

        public function set heroIcon(_arg_1:Image):void
        {
            var _local_2:Object = this._619252845heroIcon;
            if (_local_2 !== _arg_1)
            {
                this._619252845heroIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroLevel():TextArea
        {
            return (this._2014132310heroLevel);
        }


    }
}//package view.ui

