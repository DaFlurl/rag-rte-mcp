// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.BattleTroopUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.containers.VBox;
    import mx.controls.Label;
    import mx.containers.FormHeading;
    import view.ui.MyHRule;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import com.evony.util.UICache;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
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

    public class BattleTroopUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _BattleTroopUi_Image1:Image;
        public var _BattleTroopUi_VBox2:VBox;
        public var _BattleTroopUi_Label2:Label;
        public var _BattleTroopUi_Label3:Label;
        public var _BattleTroopUi_Label4:Label;
        public var _BattleTroopUi_Label1:Label;
        public var _BattleTroopUi_FormHeading1:FormHeading;
        public var _BattleTroopUi_FormHeading2:FormHeading;
        public var _BattleTroopUi_FormHeading3:FormHeading;
        public var _BattleTroopUi_MyHRule3:MyHRule;
        private var _1060409059battleTroopObj:ObjectProxy;
        public var _BattleTroopUi_MyHRule1:MyHRule;
        public var _BattleTroopUi_MyHRule2:MyHRule;
        private var _1289920177troopContainer:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_BattleTroopUi_Image1",
                                                "events":{"complete":"___BattleTroopUi_Image1_complete"}
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BattleTroopUi_Label1"
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BattleTroopUi_Label2"
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleTroopUi_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BattleTroopUi_Label3"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_BattleTroopUi_MyHRule2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BattleTroopUi_Label4"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleTroopUi_MyHRule3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_BattleTroopUi_VBox2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                    this.horizontalGap = 5;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":40});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_BattleTroopUi_FormHeading1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":80});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_BattleTroopUi_FormHeading2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":80});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_BattleTroopUi_FormHeading3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":80});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"troopContainer"
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var uiCache:UICache = new UICache(50);
        private var ac:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BattleTroopUi()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", ___BattleTroopUi_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BattleTroopUi._watcherSetupUtil = _arg_1;
        }


        private function getTroopTypeUI(_arg_1:int, _arg_2:int, _arg_3:int):LostTroopUI
        {
            var _local_4:LostTroopUI = (uiCache.getUI(LostTroopUI) as LostTroopUI);
            _local_4.imgSrc = _arg_1;
            _local_4.count = _arg_2;
            _local_4.lose = _arg_3;
            return (_local_4);
        }

        override public function initialize():void
        {
            var target:BattleTroopUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BattleTroopUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_BattleTroopUiWatcherSetupUtil");
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

        private function init():void
        {
            this.refresh();
        }

        public function set attackObj(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.battleTroopObj = _arg_1;
            this.ac.removeAll();
            this.uiCache.reset();
            if ((_arg_1.troopUnit is ArrayCollection))
            {
                _local_2 = (_arg_1.troopUnit as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.ac.addItem(this.getTroopTypeUI(_local_2[_local_3].typeId, _local_2[_local_3].count, _local_2[_local_3].lose));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.troopUnit != null)
                {
                    this.ac.addItem(this.getTroopTypeUI(_arg_1.troopUnit.typeId, _arg_1.troopUnit.count, _arg_1.troopUnit.lose));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        public function ___BattleTroopUi_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get battleTroopObj():ObjectProxy
        {
            return (this._1060409059battleTroopObj);
        }

        public function set troopContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1289920177troopContainer;
            if (_local_2 !== _arg_1)
            {
                this._1289920177troopContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopContainer", _local_2, _arg_1));
            };
        }

        private function set battleTroopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1060409059battleTroopObj;
            if (_local_2 !== _arg_1)
            {
                this._1060409059battleTroopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "battleTroopObj", _local_2, _arg_1));
            };
        }

        private function _BattleTroopUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.battleTroopObj.heroUrl;
            _local_1 = ((this.battleTroopObj.heroUrl != null) ? true : false);
            _local_1 = this.battleTroopObj.heroName;
            _local_1 = ((this.battleTroopObj.heroName == null) ? false : true);
            _local_1 = (((("(" + Lang.msg("等级")) + " ") + this.battleTroopObj.heroLevel) + ")");
            _local_1 = ((this.battleTroopObj.heroLevel == null) ? false : true);
            _local_1 = ((!(this.battleTroopObj.heroExp == null)) || (!(this.battleTroopObj.castlePos == null)));
            _local_1 = ((!(this.battleTroopObj.heroExp == null)) || (!(this.battleTroopObj.castlePos == null)));
            _local_1 = ((Lang.msg("英雄经验值") + ":") + this.battleTroopObj.heroExp);
            _local_1 = ((this.battleTroopObj.heroExp == null) ? false : true);
            _local_1 = ((this.battleTroopObj.heroExp == null) ? false : true);
            _local_1 = ((this.battleTroopObj.castlePos == null) ? false : true);
            _local_1 = ((this.battleTroopObj.castlePos == null) ? false : true);
            _local_1 = ((Lang.msg("城堡") + ": ") + this.battleTroopObj.castlePos);
            _local_1 = ((this.battleTroopObj.castlePos == null) ? false : true);
            _local_1 = ((this.battleTroopObj.castlePos == null) ? false : true);
            _local_1 = ((this.battleTroopObj.troopUnit != null) ? true : false);
            _local_1 = ((this.battleTroopObj.troopUnit != null) ? true : false);
            _local_1 = ((this.battleTroopObj.troopUnit != null) ? true : false);
            _local_1 = ((this.battleTroopObj.troopUnit != null) ? true : false);
            _local_1 = Lang.msg("军队");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("战斗损失");
        }

        [Bindable(event="propertyChange")]
        public function get troopContainer():VBox
        {
            return (this._1289920177troopContainer);
        }

        public function ___BattleTroopUi_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function refresh():void
        {
            var _local_1:LostTroopUI;
            this.troopContainer.removeAllChildren();
            for each (_local_1 in this.ac)
            {
                this.troopContainer.addChild(_local_1);
            };
        }

        private function _BattleTroopUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.battleTroopObj.heroUrl);
            }, function (_arg_1:Object):void
            {
                _BattleTroopUi_Image1.source = _arg_1;
            }, "_BattleTroopUi_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.heroUrl != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Image1.visible = _arg_1;
            }, "_BattleTroopUi_Image1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.battleTroopObj.heroName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_Label1.text = _arg_1;
            }, "_BattleTroopUi_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Label1.visible = _arg_1;
            }, "_BattleTroopUi_Label1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((("(" + Lang.msg("等级")) + " ") + this.battleTroopObj.heroLevel) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_Label2.text = _arg_1;
            }, "_BattleTroopUi_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.heroLevel == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Label2.visible = _arg_1;
            }, "_BattleTroopUi_Label2.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.battleTroopObj.heroExp == null)) || (!(this.battleTroopObj.castlePos == null)));
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_MyHRule1.visible = _arg_1;
            }, "_BattleTroopUi_MyHRule1.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.battleTroopObj.heroExp == null)) || (!(this.battleTroopObj.castlePos == null)));
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_MyHRule1.includeInLayout = _arg_1;
            }, "_BattleTroopUi_MyHRule1.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("英雄经验值") + ":") + this.battleTroopObj.heroExp);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_Label3.text = _arg_1;
            }, "_BattleTroopUi_Label3.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Label3.visible = _arg_1;
            }, "_BattleTroopUi_Label3.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Label3.includeInLayout = _arg_1;
            }, "_BattleTroopUi_Label3.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.castlePos == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_MyHRule2.visible = _arg_1;
            }, "_BattleTroopUi_MyHRule2.visible");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.castlePos == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_MyHRule2.includeInLayout = _arg_1;
            }, "_BattleTroopUi_MyHRule2.includeInLayout");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("城堡") + ": ") + this.battleTroopObj.castlePos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_Label4.text = _arg_1;
            }, "_BattleTroopUi_Label4.text");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.castlePos == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Label4.visible = _arg_1;
            }, "_BattleTroopUi_Label4.visible");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.castlePos == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_Label4.includeInLayout = _arg_1;
            }, "_BattleTroopUi_Label4.includeInLayout");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.troopUnit != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_MyHRule3.visible = _arg_1;
            }, "_BattleTroopUi_MyHRule3.visible");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.troopUnit != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_MyHRule3.includeInLayout = _arg_1;
            }, "_BattleTroopUi_MyHRule3.includeInLayout");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.troopUnit != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_VBox2.visible = _arg_1;
            }, "_BattleTroopUi_VBox2.visible");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleTroopObj.troopUnit != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleTroopUi_VBox2.includeInLayout = _arg_1;
            }, "_BattleTroopUi_VBox2.includeInLayout");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_FormHeading1.label = _arg_1;
            }, "_BattleTroopUi_FormHeading1.label");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_FormHeading2.label = _arg_1;
            }, "_BattleTroopUi_FormHeading2.label");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("战斗损失");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTroopUi_FormHeading3.label = _arg_1;
            }, "_BattleTroopUi_FormHeading3.label");
            result[22] = binding;
            return (result);
        }


    }
}//package view.module.info.reports.ReportUi

