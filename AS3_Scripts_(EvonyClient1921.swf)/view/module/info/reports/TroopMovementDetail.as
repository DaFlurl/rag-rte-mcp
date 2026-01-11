// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.TroopMovementDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.utils.ObjectProxy;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.containers.FormItem;
    import mx.containers.FormHeading;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import view.module.info.reports.ReportUi.LootResourceUi;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import view.module.trainningField.TroopTypeUI;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.Lang;
    import view.module.info.reports.ReportUi.LevyTypeTransform;
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

    public class TroopMovementDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1316782738startPos:String;
        private var _1234521609resourceObj:ObjectProxy;
        public var _TroopMovementDetail_Image1:Image;
        public var _TroopMovementDetail_Label1:Label;
        public var _TroopMovementDetail_Label2:Label;
        public var _TroopMovementDetail_Label3:Label;
        public var _TroopMovementDetail_Label4:Label;
        public var _TroopMovementDetail_FormItem2:FormItem;
        private var _841538326troopMovementObj:ObjectProxy;
        public var _TroopMovementDetail_FormHeading1:FormHeading;
        public var _TroopMovementDetail_FormHeading2:FormHeading;
        public var _TroopMovementDetail_FormHeading3:FormHeading;
        private var _1289920177troopContainer:VBox;
        public var _TroopMovementDetail_MyHRule1:MyHRule;
        public var _TroopMovementDetail_MyHRule2:MyHRule;
        public var _TroopMovementDetail_MyHRule3:MyHRule;
        public var _TroopMovementDetail_LootResourceUi1:LootResourceUi;
        private var _815590653targetPos:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 3;
                            this.left = "0";
                            this.right = "16";
                            this.bottom = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "direction":"vertical",
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TroopMovementDetail_Label1"
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TroopMovementDetail_Label2"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_TroopMovementDetail_MyHRule1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TroopMovementDetail_Label3"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_TroopMovementDetail_MyHRule2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_TroopMovementDetail_FormHeading1",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_TroopMovementDetail_Image1",
                                                            "events":{"complete":"___TroopMovementDetail_Image1_complete"}
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_TroopMovementDetail_Label4"
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_TroopMovementDetail_MyHRule3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_TroopMovementDetail_FormItem2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":LootResourceUi,
                                                "id":"_TroopMovementDetail_LootResourceUi1"
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
                                    "type":FormItem,
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
                                                                return ({"width":10});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_TroopMovementDetail_FormHeading2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":130});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_TroopMovementDetail_FormHeading3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":90});
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
                                })]});
                        }
                    })]});
            }
        });
        private var tpAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TroopMovementDetail()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___TroopMovementDetail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopMovementDetail._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get resourceObj():ObjectProxy
        {
            return (this._1234521609resourceObj);
        }

        private function getTroopTypeUI(_arg_1:int, _arg_2:int):TroopTypeUI
        {
            var _local_3:TroopTypeUI = (uiCache.getUI(TroopTypeUI) as TroopTypeUI);
            _local_3.imgSrc = _arg_1;
            _local_3.amount = _arg_2;
            return (_local_3);
        }

        private function set targetPos(_arg_1:String):void
        {
            var _local_2:Object = this._815590653targetPos;
            if (_local_2 !== _arg_1)
            {
                this._815590653targetPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPos", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TroopMovementDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopMovementDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_TroopMovementDetailWatcherSetupUtil");
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

        private function set resourceObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1234521609resourceObj;
            if (_local_2 !== _arg_1)
            {
                this._1234521609resourceObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceObj", _local_2, _arg_1));
            };
        }

        public function ___TroopMovementDetail_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get startPos():String
        {
            return (this._1316782738startPos);
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

        private function set startPos(_arg_1:String):void
        {
            var _local_2:Object = this._1316782738startPos;
            if (_local_2 !== _arg_1)
            {
                this._1316782738startPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPos", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get troopMovementObj():ObjectProxy
        {
            return (this._841538326troopMovementObj);
        }

        [Bindable(event="propertyChange")]
        private function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        private function _TroopMovementDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("向{0}执行{1}任务的部队返回{2}", this.targetPos, LevyTypeTransform.levyTypeTransf(this.troopMovementObj.type), this.startPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_Label1.text = _arg_1;
            }, "_TroopMovementDetail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.troopMovementObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label1.visible = _arg_1;
            }, "_TroopMovementDetail_Label1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.troopMovementObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label1.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_Label1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("向{0}执行{1}任务的部队到达目标地", this.targetPos, LevyTypeTransform.levyTypeTransf(this.troopMovementObj.type));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_Label2.text = _arg_1;
            }, "_TroopMovementDetail_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.troopMovementObj.isBack));
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label2.visible = _arg_1;
            }, "_TroopMovementDetail_Label2.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.troopMovementObj.isBack));
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label2.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_Label2.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.problem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_MyHRule1.visible = _arg_1;
            }, "_TroopMovementDetail_MyHRule1.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.problem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_MyHRule1.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_MyHRule1.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopMovementObj.problem;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_Label3.text = _arg_1;
            }, "_TroopMovementDetail_Label3.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.problem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label3.visible = _arg_1;
            }, "_TroopMovementDetail_Label3.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.problem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label3.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_Label3.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((!(this.troopMovementObj.heroUrl == null)) || (!(this.troopMovementObj.heroLevel == null))) || (this.troopMovementObj.isBack == true));
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_MyHRule2.visible = _arg_1;
            }, "_TroopMovementDetail_MyHRule2.visible");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((!(this.troopMovementObj.heroUrl == null)) || (!(this.troopMovementObj.heroLevel == null))) || (this.troopMovementObj.isBack == true));
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_MyHRule2.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_MyHRule2.includeInLayout");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("部队返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_FormHeading1.label = _arg_1;
            }, "_TroopMovementDetail_FormHeading1.label");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.troopMovementObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_FormHeading1.visible = _arg_1;
            }, "_TroopMovementDetail_FormHeading1.visible");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.troopMovementObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_FormHeading1.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_FormHeading1.includeInLayout");
            result[15] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.troopMovementObj.heroUrl);
            }, function (_arg_1:Object):void
            {
                _TroopMovementDetail_Image1.source = _arg_1;
            }, "_TroopMovementDetail_Image1.source");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.heroUrl == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Image1.visible = _arg_1;
            }, "_TroopMovementDetail_Image1.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.heroUrl == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Image1.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_Image1.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((this.troopMovementObj.heroName + "(") + ((Lang.msg("等级") + " ") + this.troopMovementObj.heroLevel)) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_Label4.text = _arg_1;
            }, "_TroopMovementDetail_Label4.text");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label4.visible = _arg_1;
            }, "_TroopMovementDetail_Label4.visible");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopMovementObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_Label4.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_Label4.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resourceObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_MyHRule3.visible = _arg_1;
            }, "_TroopMovementDetail_MyHRule3.visible");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resourceObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_MyHRule3.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_MyHRule3.includeInLayout");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resourceObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_FormItem2.visible = _arg_1;
            }, "_TroopMovementDetail_FormItem2.visible");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resourceObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopMovementDetail_FormItem2.includeInLayout = _arg_1;
            }, "_TroopMovementDetail_FormItem2.includeInLayout");
            result[25] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.resourceObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _TroopMovementDetail_LootResourceUi1.resourceObj = _arg_1;
            }, "_TroopMovementDetail_LootResourceUi1.resourceObj");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_FormHeading2.label = _arg_1;
            }, "_TroopMovementDetail_FormHeading2.label");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMovementDetail_FormHeading3.label = _arg_1;
            }, "_TroopMovementDetail_FormHeading3.label");
            result[28] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get troopContainer():VBox
        {
            return (this._1289920177troopContainer);
        }

        private function refresh():void
        {
            var _local_1:TroopTypeUI;
            this.troopContainer.removeAllChildren();
            for each (_local_1 in this.tpAc)
            {
                this.troopContainer.addChild(_local_1);
            };
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String, _arg_3:String):void
        {
            var _local_4:ArrayCollection;
            var _local_5:int;
            this.startPos = _arg_2;
            this.targetPos = _arg_3;
            this.tpAc.removeAll();
            this.uiCache.reset();
            this.troopMovementObj = _arg_1;
            if (((!(_arg_1.resource == null)) && (_arg_1.resource is Object)))
            {
                this.resourceObj = (_arg_1.resource as ObjectProxy);
            }
            else
            {
                this.resourceObj = _arg_1.resource;
            };
            if ((_arg_1.troops is ArrayCollection))
            {
                _local_4 = (_arg_1.troops as ArrayCollection);
                _local_5 = 0;
                while (_local_5 < _local_4.length)
                {
                    this.tpAc.addItem(this.getTroopTypeUI(_local_4[_local_5].typeId, _local_4[_local_5].count));
                    _local_5++;
                };
            }
            else
            {
                if (_arg_1.troops != null)
                {
                    this.tpAc.addItem(this.getTroopTypeUI(_arg_1.troops.typeId, _arg_1.troops.count));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        public function ___TroopMovementDetail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set troopMovementObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._841538326troopMovementObj;
            if (_local_2 !== _arg_1)
            {
                this._841538326troopMovementObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopMovementObj", _local_2, _arg_1));
            };
        }

        private function _TroopMovementDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("向{0}执行{1}任务的部队返回{2}", this.targetPos, LevyTypeTransform.levyTypeTransf(this.troopMovementObj.type), this.startPos);
            _local_1 = this.troopMovementObj.isBack;
            _local_1 = this.troopMovementObj.isBack;
            _local_1 = Lang.msg("向{0}执行{1}任务的部队到达目标地", this.targetPos, LevyTypeTransform.levyTypeTransf(this.troopMovementObj.type));
            _local_1 = (!(this.troopMovementObj.isBack));
            _local_1 = (!(this.troopMovementObj.isBack));
            _local_1 = ((this.troopMovementObj.problem == null) ? false : true);
            _local_1 = ((this.troopMovementObj.problem == null) ? false : true);
            _local_1 = this.troopMovementObj.problem;
            _local_1 = ((this.troopMovementObj.problem == null) ? false : true);
            _local_1 = ((this.troopMovementObj.problem == null) ? false : true);
            _local_1 = (((!(this.troopMovementObj.heroUrl == null)) || (!(this.troopMovementObj.heroLevel == null))) || (this.troopMovementObj.isBack == true));
            _local_1 = (((!(this.troopMovementObj.heroUrl == null)) || (!(this.troopMovementObj.heroLevel == null))) || (this.troopMovementObj.isBack == true));
            _local_1 = Lang.msg("部队返回");
            _local_1 = this.troopMovementObj.isBack;
            _local_1 = this.troopMovementObj.isBack;
            _local_1 = this.troopMovementObj.heroUrl;
            _local_1 = ((this.troopMovementObj.heroUrl == null) ? false : true);
            _local_1 = ((this.troopMovementObj.heroUrl == null) ? false : true);
            _local_1 = (((this.troopMovementObj.heroName + "(") + ((Lang.msg("等级") + " ") + this.troopMovementObj.heroLevel)) + ")");
            _local_1 = ((this.troopMovementObj.heroName == null) ? false : true);
            _local_1 = ((this.troopMovementObj.heroName == null) ? false : true);
            _local_1 = ((this.resourceObj == null) ? false : true);
            _local_1 = ((this.resourceObj == null) ? false : true);
            _local_1 = ((this.resourceObj == null) ? false : true);
            _local_1 = ((this.resourceObj == null) ? false : true);
            _local_1 = this.resourceObj;
            _local_1 = Lang.msg("军队");
            _local_1 = Lang.msg("数量");
        }


    }
}//package view.module.info.reports

