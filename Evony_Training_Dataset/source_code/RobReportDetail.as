// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.RobReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.utils.ObjectProxy;
    import mx.containers.FormHeading;
    import view.ui.MyHRule;
    import view.module.info.reports.ReportUi.LootResourceUi;
    import mx.containers.VBox;
    import mx.containers.FormItem;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import view.module.trainningField.TroopTypeUI;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class RobReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1316782738startPos:String;
        private var _345486093robResource:ObjectProxy;
        public var _RobReportDetail_FormHeading1:FormHeading;
        public var _RobReportDetail_FormHeading2:FormHeading;
        public var _RobReportDetail_FormHeading3:FormHeading;
        public var _RobReportDetail_FormHeading4:FormHeading;
        public var _RobReportDetail_MyHRule3:MyHRule;
        public var _RobReportDetail_MyHRule1:MyHRule;
        public var _RobReportDetail_LootResourceUi1:LootResourceUi;
        private var _1787405715lostTroopContainer:VBox;
        public var _RobReportDetail_FormItem1:FormItem;
        public var _RobReportDetail_FormItem2:FormItem;
        public var _RobReportDetail_Label1:Label;
        private var _815590653targetPos:String;
        private var _110634834troop:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.verticalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_RobReportDetail_Label1"
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_RobReportDetail_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_RobReportDetail_FormItem1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_RobReportDetail_FormHeading1"
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
                                                "type":LootResourceUi,
                                                "id":"_RobReportDetail_LootResourceUi1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_RobReportDetail_MyHRule3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_RobReportDetail_FormItem2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_RobReportDetail_FormHeading2"
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
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_RobReportDetail_FormHeading3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":69});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_RobReportDetail_FormHeading4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":85});
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
                                                "id":"lostTroopContainer"
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var robAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function RobReportDetail()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___RobReportDetail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            RobReportDetail._watcherSetupUtil = _arg_1;
        }


        private function getTroopTypeUI(_arg_1:int, _arg_2:int):TroopTypeUI
        {
            var _local_3:TroopTypeUI = (uiCache.getUI(TroopTypeUI) as TroopTypeUI);
            _local_3.imgSrc = _arg_1;
            _local_3.amount = _arg_2;
            return (_local_3);
        }

        [Bindable(event="propertyChange")]
        public function get lostTroopContainer():VBox
        {
            return (this._1787405715lostTroopContainer);
        }

        override public function initialize():void
        {
            var target:RobReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _RobReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_RobReportDetailWatcherSetupUtil");
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
        private function get startPos():String
        {
            return (this._1316782738startPos);
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

        private function set troop(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        public function set lostTroopContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1787405715lostTroopContainer;
            if (_local_2 !== _arg_1)
            {
                this._1787405715lostTroopContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lostTroopContainer", _local_2, _arg_1));
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

        private function _RobReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (((Lang.msg("我军要到") + this.targetPos) + ". ") + Lang.msg("途中遭到打劫"));
            _local_1 = ((this.robResource == null) ? false : true);
            _local_1 = ((this.robResource == null) ? false : true);
            _local_1 = ((this.robResource == null) ? false : true);
            _local_1 = ((this.robResource == null) ? false : true);
            _local_1 = Lang.msg("被掠夺资源");
            _local_1 = this.robResource;
            _local_1 = ((this.robResource == null) ? false : true);
            _local_1 = ((this.robResource == null) ? false : true);
            _local_1 = ((this.troop == null) ? false : true);
            _local_1 = ((this.troop == null) ? false : true);
            _local_1 = Lang.msg("损失的兵");
            _local_1 = Lang.msg("军队");
            _local_1 = Lang.msg("数量");
        }

        public function ___RobReportDetail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set robResource(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._345486093robResource;
            if (_local_2 !== _arg_1)
            {
                this._345486093robResource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "robResource", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get troop():ObjectProxy
        {
            return (this._110634834troop);
        }

        private function refresh():void
        {
            var _local_1:TroopTypeUI;
            this.lostTroopContainer.removeAllChildren();
            for each (_local_1 in this.robAc)
            {
                this.lostTroopContainer.addChild(_local_1);
            };
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String, _arg_3:String):void
        {
            var _local_4:ArrayCollection;
            var _local_5:int;
            this.startPos = _arg_2;
            this.targetPos = _arg_3;
            this.troop = _arg_1.loseTroops;
            this.robAc.removeAll();
            this.uiCache.reset();
            if (((!(_arg_1.loseResource == null)) && (_arg_1.loseResource is Object)))
            {
                this.robResource = (_arg_1.loseResource as ObjectProxy);
            }
            else
            {
                this.robResource = _arg_1.loseResource;
            };
            if ((_arg_1.loseTroops is ArrayCollection))
            {
                _local_4 = (_arg_1.loseTroops as ArrayCollection);
                _local_5 = 0;
                while (_local_5 < _local_4.length)
                {
                    this.robAc.addItem(this.getTroopTypeUI(_local_4[_local_5].typeId, _local_4[_local_5].count));
                    _local_5++;
                };
            }
            else
            {
                if (this.troop != null)
                {
                    this.robAc.addItem(this.getTroopTypeUI(_arg_1.loseTroops.typeId, _arg_1.loseTroops.count));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get robResource():ObjectProxy
        {
            return (this._345486093robResource);
        }

        private function _RobReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((Lang.msg("我军要到") + this.targetPos) + ". ") + Lang.msg("途中遭到打劫"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RobReportDetail_Label1.text = _arg_1;
            }, "_RobReportDetail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.robResource == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_MyHRule1.visible = _arg_1;
            }, "_RobReportDetail_MyHRule1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.robResource == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_MyHRule1.includeInLayout = _arg_1;
            }, "_RobReportDetail_MyHRule1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.robResource == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_FormItem1.visible = _arg_1;
            }, "_RobReportDetail_FormItem1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.robResource == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_FormItem1.includeInLayout = _arg_1;
            }, "_RobReportDetail_FormItem1.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("被掠夺资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RobReportDetail_FormHeading1.label = _arg_1;
            }, "_RobReportDetail_FormHeading1.label");
            result[5] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.robResource);
            }, function (_arg_1:ObjectProxy):void
            {
                _RobReportDetail_LootResourceUi1.resourceObj = _arg_1;
            }, "_RobReportDetail_LootResourceUi1.resourceObj");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.robResource == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_MyHRule3.visible = _arg_1;
            }, "_RobReportDetail_MyHRule3.visible");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.robResource == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_MyHRule3.includeInLayout = _arg_1;
            }, "_RobReportDetail_MyHRule3.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troop == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_FormItem2.visible = _arg_1;
            }, "_RobReportDetail_FormItem2.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troop == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _RobReportDetail_FormItem2.includeInLayout = _arg_1;
            }, "_RobReportDetail_FormItem2.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("损失的兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RobReportDetail_FormHeading2.label = _arg_1;
            }, "_RobReportDetail_FormHeading2.label");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RobReportDetail_FormHeading3.label = _arg_1;
            }, "_RobReportDetail_FormHeading3.label");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RobReportDetail_FormHeading4.label = _arg_1;
            }, "_RobReportDetail_FormHeading4.label");
            result[13] = binding;
            return (result);
        }


    }
}//package view.module.info.reports

