// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.TroopInfoUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.utils.ObjectProxy;
    import view.ui.MyHRule;
    import mx.containers.FormItem;
    import mx.containers.VBox;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.containers.FormHeading;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import com.evony.Lang;
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

    public class TroopInfoUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TroopInfoUi_LootResourceUi1:LootResourceUi;
        private var _350031151lootObj:ObjectProxy;
        public var _TroopInfoUi_MyHRule1:MyHRule;
        public var _TroopInfoUi_MyHRule2:MyHRule;
        public var _TroopInfoUi_MyHRule3:MyHRule;
        public var _TroopInfoUi_FormItem1:FormItem;
        public var _TroopInfoUi_FormItem2:FormItem;
        private var _1289920177troopContainer:VBox;
        public var _TroopInfoUi_Image1:Image;
        public var _TroopInfoUi_Label2:Label;
        public var _TroopInfoUi_Label3:Label;
        public var _TroopInfoUi_Label4:Label;
        public var _TroopInfoUi_Label5:Label;
        public var _TroopInfoUi_Label6:Label;
        public var _TroopInfoUi_Label1:Label;
        private var _330505002bakTroopsObj:ObjectProxy;
        private var _1320690644preCount:int;
        private var _1949304161injured:int;
        public var _TroopInfoUi_FormHeading1:FormHeading;
        private var _934624660remain:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_TroopInfoUi_Image1",
                                                "events":{"complete":"___TroopInfoUi_Image1_complete"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":5,
                                                        "y":10,
                                                        "width":37,
                                                        "height":39
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TroopInfoUi_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":62,
                                                        "y":16
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TroopInfoUi_Label2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":218,
                                                        "y":16
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_TroopInfoUi_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_TroopInfoUi_FormItem1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_TroopInfoUi_FormHeading1"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_TroopInfoUi_MyHRule2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":LootResourceUi,
                                                "id":"_TroopInfoUi_LootResourceUi1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_TroopInfoUi_MyHRule3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_TroopInfoUi_FormItem2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 5;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":40});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_TroopInfoUi_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_TroopInfoUi_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_TroopInfoUi_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":110,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_TroopInfoUi_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                })]
                            });
                        }
                    })]});
            }
        });
        private var bakTpAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TroopInfoUi()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", ___TroopInfoUi_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopInfoUi._watcherSetupUtil = _arg_1;
        }


        private function refresh():void
        {
            var _local_1:TroopUi;
            this.troopContainer.removeAllChildren();
            for each (_local_1 in this.bakTpAc)
            {
                this.troopContainer.addChild(_local_1);
            };
        }

        [Bindable(event="propertyChange")]
        private function get remain():int
        {
            return (this._934624660remain);
        }

        override public function initialize():void
        {
            var target:TroopInfoUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopInfoUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_TroopInfoUiWatcherSetupUtil");
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

        public function ___TroopInfoUi_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
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

        private function init():void
        {
            this.refresh();
        }

        public function ___TroopInfoUi_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _TroopInfoUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.bakTroopsObj.heroUrl;
            _local_1 = ((this.bakTroopsObj.heroUrl == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.heroUrl == null) ? false : true);
            _local_1 = (((((this.bakTroopsObj.heroName + " (") + Lang.msg("等级")) + "") + this.bakTroopsObj.heroLevel) + ")");
            _local_1 = ((this.bakTroopsObj.heroName == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.heroName == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.isHeroBeSeized == true) ? Lang.msg("英雄被捉") : Lang.msg("英雄没有被捉"));
            _local_1 = ((this.bakTroopsObj.isHeroBeSeized == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.isHeroBeSeized == null) ? false : true);
            _local_1 = (!(this.lootObj == null));
            _local_1 = (!(this.lootObj == null));
            _local_1 = (!(this.lootObj == null));
            _local_1 = (!(this.lootObj == null));
            _local_1 = ((this.bakTroopsObj.isBack == true) ? Lang.msg("带回资源") : Lang.msg("带回资源"));
            _local_1 = ((this.lootObj == null) ? false : true);
            _local_1 = ((this.lootObj == null) ? false : true);
            _local_1 = this.lootObj;
            _local_1 = ((this.lootObj == null) ? false : true);
            _local_1 = ((this.lootObj == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.troopInfo == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.troopInfo == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.troopInfo == null) ? false : true);
            _local_1 = ((this.bakTroopsObj.troopInfo == null) ? false : true);
            _local_1 = Lang.msg("军队");
            _local_1 = Lang.msg("总数量");
            _local_1 = ((this.preCount == 0) ? false : true);
            _local_1 = ((this.preCount == 0) ? false : true);
            _local_1 = Lang.msg("剩余数量");
            _local_1 = ((this.remain == 0) ? false : true);
            _local_1 = ((this.remain == 0) ? false : true);
            _local_1 = Lang.msg("伤兵数量");
            _local_1 = ((this.injured == 0) ? false : true);
            _local_1 = ((this.injured == 0) ? false : true);
        }

        public function set troopsObj(_arg_1:Object):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.bakTroopsObj = ObjectProxy(_arg_1);
            this.bakTpAc.removeAll();
            this.uiCache.reset();
            if (((!(_arg_1.resource == null)) && (_arg_1.resource is Object)))
            {
                this.lootObj = (_arg_1.resource as ObjectProxy);
            }
            else
            {
                this.lootObj = _arg_1.resource;
            };
            if ((_arg_1.troopInfo is ArrayCollection))
            {
                _local_2 = (_arg_1.troopInfo as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.bakTpAc.addItem(this.getTroopUI(_local_2[_local_3]));
                    this.preCount = _local_2[_local_3].preCount;
                    this.remain = _local_2[_local_3].remain;
                    this.injured = _local_2[_local_3].injured;
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.troopInfo != null)
                {
                    this.bakTpAc.addItem(this.getTroopUI(_arg_1.troopInfo));
                    this.preCount = _arg_1.troopInfo.preCount;
                    this.remain = _arg_1.troopInfo.remain;
                    this.injured = _arg_1.troopInfo.injured;
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get lootObj():ObjectProxy
        {
            return (this._350031151lootObj);
        }

        private function getTroopUI(_arg_1:Object):TroopUi
        {
            var _local_2:TroopUi = (uiCache.getUI(TroopUi) as TroopUi);
            _local_2.troopInfoObj = _arg_1;
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get bakTroopsObj():ObjectProxy
        {
            return (this._330505002bakTroopsObj);
        }

        [Bindable(event="propertyChange")]
        private function get preCount():int
        {
            return (this._1320690644preCount);
        }

        private function _TroopInfoUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.bakTroopsObj.heroUrl);
            }, function (_arg_1:Object):void
            {
                _TroopInfoUi_Image1.source = _arg_1;
            }, "_TroopInfoUi_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.heroUrl == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Image1.visible = _arg_1;
            }, "_TroopInfoUi_Image1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.heroUrl == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Image1.includeInLayout = _arg_1;
            }, "_TroopInfoUi_Image1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((((this.bakTroopsObj.heroName + " (") + Lang.msg("等级")) + "") + this.bakTroopsObj.heroLevel) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_Label1.text = _arg_1;
            }, "_TroopInfoUi_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label1.visible = _arg_1;
            }, "_TroopInfoUi_Label1.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label1.includeInLayout = _arg_1;
            }, "_TroopInfoUi_Label1.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.bakTroopsObj.isHeroBeSeized == true) ? Lang.msg("英雄被捉") : Lang.msg("英雄没有被捉"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_Label2.text = _arg_1;
            }, "_TroopInfoUi_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.isHeroBeSeized == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label2.visible = _arg_1;
            }, "_TroopInfoUi_Label2.visible");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.isHeroBeSeized == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label2.includeInLayout = _arg_1;
            }, "_TroopInfoUi_Label2.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.lootObj == null));
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_MyHRule1.visible = _arg_1;
            }, "_TroopInfoUi_MyHRule1.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.lootObj == null));
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_MyHRule1.includeInLayout = _arg_1;
            }, "_TroopInfoUi_MyHRule1.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.lootObj == null));
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_FormItem1.visible = _arg_1;
            }, "_TroopInfoUi_FormItem1.visible");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.lootObj == null));
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_FormItem1.includeInLayout = _arg_1;
            }, "_TroopInfoUi_FormItem1.includeInLayout");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.bakTroopsObj.isBack == true) ? Lang.msg("带回资源") : Lang.msg("带回资源"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_FormHeading1.label = _arg_1;
            }, "_TroopInfoUi_FormHeading1.label");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lootObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_MyHRule2.visible = _arg_1;
            }, "_TroopInfoUi_MyHRule2.visible");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lootObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_MyHRule2.includeInLayout = _arg_1;
            }, "_TroopInfoUi_MyHRule2.includeInLayout");
            result[15] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.lootObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _TroopInfoUi_LootResourceUi1.resourceObj = _arg_1;
            }, "_TroopInfoUi_LootResourceUi1.resourceObj");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lootObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_LootResourceUi1.visible = _arg_1;
            }, "_TroopInfoUi_LootResourceUi1.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lootObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_LootResourceUi1.includeInLayout = _arg_1;
            }, "_TroopInfoUi_LootResourceUi1.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.troopInfo == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_MyHRule3.visible = _arg_1;
            }, "_TroopInfoUi_MyHRule3.visible");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.troopInfo == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_MyHRule3.includeInLayout = _arg_1;
            }, "_TroopInfoUi_MyHRule3.includeInLayout");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.troopInfo == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_FormItem2.visible = _arg_1;
            }, "_TroopInfoUi_FormItem2.visible");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopsObj.troopInfo == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_FormItem2.includeInLayout = _arg_1;
            }, "_TroopInfoUi_FormItem2.includeInLayout");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_Label3.text = _arg_1;
            }, "_TroopInfoUi_Label3.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("总数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_Label4.text = _arg_1;
            }, "_TroopInfoUi_Label4.text");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.preCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label4.visible = _arg_1;
            }, "_TroopInfoUi_Label4.visible");
            result[25] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.preCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label4.includeInLayout = _arg_1;
            }, "_TroopInfoUi_Label4.includeInLayout");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("剩余数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_Label5.text = _arg_1;
            }, "_TroopInfoUi_Label5.text");
            result[27] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.remain == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label5.visible = _arg_1;
            }, "_TroopInfoUi_Label5.visible");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.remain == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label5.includeInLayout = _arg_1;
            }, "_TroopInfoUi_Label5.includeInLayout");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("伤兵数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopInfoUi_Label6.text = _arg_1;
            }, "_TroopInfoUi_Label6.text");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.injured == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label6.visible = _arg_1;
            }, "_TroopInfoUi_Label6.visible");
            result[31] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.injured == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopInfoUi_Label6.includeInLayout = _arg_1;
            }, "_TroopInfoUi_Label6.includeInLayout");
            result[32] = binding;
            return (result);
        }

        private function set injured(_arg_1:int):void
        {
            var _local_2:Object = this._1949304161injured;
            if (_local_2 !== _arg_1)
            {
                this._1949304161injured = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "injured", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get troopContainer():VBox
        {
            return (this._1289920177troopContainer);
        }

        private function set lootObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._350031151lootObj;
            if (_local_2 !== _arg_1)
            {
                this._350031151lootObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lootObj", _local_2, _arg_1));
            };
        }

        private function set preCount(_arg_1:int):void
        {
            var _local_2:Object = this._1320690644preCount;
            if (_local_2 !== _arg_1)
            {
                this._1320690644preCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "preCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get injured():int
        {
            return (this._1949304161injured);
        }

        private function set bakTroopsObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._330505002bakTroopsObj;
            if (_local_2 !== _arg_1)
            {
                this._330505002bakTroopsObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bakTroopsObj", _local_2, _arg_1));
            };
        }

        private function set remain(_arg_1:int):void
        {
            var _local_2:Object = this._934624660remain;
            if (_local_2 !== _arg_1)
            {
                this._934624660remain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remain", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

