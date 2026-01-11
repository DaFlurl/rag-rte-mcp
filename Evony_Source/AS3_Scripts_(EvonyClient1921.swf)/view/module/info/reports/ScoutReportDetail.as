// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ScoutReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.ReportUi.ScoutInfoUi;
    import mx.utils.ObjectProxy;
    import view.module.info.reports.ReportUi.ScoutResults;
    import mx.containers.FormItem;
    import mx.containers.FormHeading;
    import view.module.info.reports.ReportUi.AutoHealReportDetail;
    import view.ui.MyHRule;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.core.mx_internal;
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

    public class ScoutReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1316782738startPos:String;
        public var _ScoutReportDetail_ScoutInfoUi1:ScoutInfoUi;
        private var _595557056autoHealObj:ObjectProxy;
        private var _1584232309scoutInfoObj:ObjectProxy;
        public var _ScoutReportDetail_ScoutResults1:ScoutResults;
        public var _ScoutReportDetail_FormItem2:FormItem;
        public var _ScoutReportDetail_FormItem3:FormItem;
        public var _ScoutReportDetail_FormHeading1:FormHeading;
        public var _ScoutReportDetail_FormHeading2:FormHeading;
        public var _ScoutReportDetail_AutoHealReportDetail1:AutoHealReportDetail;
        private var _487938044battleWin:ScoutBattleReportDetail;
        public var _ScoutReportDetail_MyHRule2:MyHRule;
        public var _ScoutReportDetail_MyHRule4:MyHRule;
        public var _ScoutReportDetail_Label1:Label;
        public var _ScoutReportDetail_MyHRule6:MyHRule;
        public var _ScoutReportDetail_MyHRule5:MyHRule;
        public var _ScoutReportDetail_Label2:Label;
        private var _487945953battleObj:ObjectProxy;
        private var _417656519ScoutObj:ObjectProxy;
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
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "16";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"reportFrom",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ScoutReportDetail_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":100});
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
                                                "type":ScoutResults,
                                                "id":"_ScoutReportDetail_ScoutResults1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutReportDetail_MyHRule2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_ScoutReportDetail_FormItem2",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_ScoutReportDetail_FormHeading1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontSize = 13;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tableContent1"
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
                                                "type":ScoutInfoUi,
                                                "id":"_ScoutReportDetail_ScoutInfoUi1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutReportDetail_MyHRule4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_ScoutReportDetail_FormItem3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_ScoutReportDetail_FormHeading2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutReportDetail_MyHRule5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ScoutBattleReportDetail,
                                                "id":"battleWin",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutReportDetail_Label2"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutReportDetail_MyHRule6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AutoHealReportDetail,
                                    "id":"_ScoutReportDetail_AutoHealReportDetail1"
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

        public function ScoutReportDetail()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___ScoutReportDetail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ScoutReportDetail._watcherSetupUtil = _arg_1;
        }


        private function set autoHealObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._595557056autoHealObj;
            if (_local_2 !== _arg_1)
            {
                this._595557056autoHealObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoHealObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get battleWin():ScoutBattleReportDetail
        {
            return (this._487938044battleWin);
        }

        public function set battleWin(_arg_1:ScoutBattleReportDetail):void
        {
            var _local_2:Object = this._487938044battleWin;
            if (_local_2 !== _arg_1)
            {
                this._487938044battleWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "battleWin", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get scoutInfoObj():ObjectProxy
        {
            return (this._1584232309scoutInfoObj);
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

        private function init():void
        {
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        private function get startPos():String
        {
            return (this._1316782738startPos);
        }

        override public function initialize():void
        {
            var target:ScoutReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ScoutReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ScoutReportDetailWatcherSetupUtil");
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

        private function set scoutInfoObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1584232309scoutInfoObj;
            if (_local_2 !== _arg_1)
            {
                this._1584232309scoutInfoObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scoutInfoObj", _local_2, _arg_1));
            };
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
        private function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        [Bindable(event="propertyChange")]
        private function get battleObj():ObjectProxy
        {
            return (this._487945953battleObj);
        }

        private function _ScoutReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("执行侦查任务的军队已经到达目标") + " ") + this.targetPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutReportDetail_Label1.text = _arg_1;
            }, "_ScoutReportDetail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.ScoutObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutReportDetail_ScoutResults1.myScoutObj = _arg_1;
            }, "_ScoutReportDetail_ScoutResults1.myScoutObj");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule2.visible = _arg_1;
            }, "_ScoutReportDetail_MyHRule2.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule2.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_MyHRule2.includeInLayout");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_FormItem2.visible = _arg_1;
            }, "_ScoutReportDetail_FormItem2.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_FormItem2.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_FormItem2.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("侦察报告") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutReportDetail_FormHeading1.label = _arg_1;
            }, "_ScoutReportDetail_FormHeading1.label");
            result[6] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scoutInfoObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutReportDetail_ScoutInfoUi1.scoutInfo = _arg_1;
            }, "_ScoutReportDetail_ScoutInfoUi1.scoutInfo");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule4.visible = _arg_1;
            }, "_ScoutReportDetail_MyHRule4.visible");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule4.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_MyHRule4.includeInLayout");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_FormItem3.visible = _arg_1;
            }, "_ScoutReportDetail_FormItem3.visible");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_FormItem3.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_FormItem3.includeInLayout");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("部队返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutReportDetail_FormHeading2.label = _arg_1;
            }, "_ScoutReportDetail_FormHeading2.label");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.battleObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_FormHeading2.visible = _arg_1;
            }, "_ScoutReportDetail_FormHeading2.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.battleObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_FormHeading2.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_FormHeading2.includeInLayout");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.battleObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule5.visible = _arg_1;
            }, "_ScoutReportDetail_MyHRule5.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.battleObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule5.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_MyHRule5.includeInLayout");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleObj.defendTroop != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                battleWin.visible = _arg_1;
            }, "battleWin.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.battleObj.defendTroop != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                battleWin.includeInLayout = _arg_1;
            }, "battleWin.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.ScoutObj.scoutInfo == null) ? Lang.msg("等级不够，无法侦察。") : Lang.msg("可以升级得到更多的信息。"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutReportDetail_Label2.text = _arg_1;
            }, "_ScoutReportDetail_Label2.text");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.autoHealObj);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule6.visible = _arg_1;
            }, "_ScoutReportDetail_MyHRule6.visible");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.autoHealObj);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_MyHRule6.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_MyHRule6.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.autoHealObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutReportDetail_AutoHealReportDetail1.xmlObj = _arg_1;
            }, "_ScoutReportDetail_AutoHealReportDetail1.xmlObj");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.autoHealObj);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_AutoHealReportDetail1.visible = _arg_1;
            }, "_ScoutReportDetail_AutoHealReportDetail1.visible");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.autoHealObj);
            }, function (_arg_1:Boolean):void
            {
                _ScoutReportDetail_AutoHealReportDetail1.includeInLayout = _arg_1;
            }, "_ScoutReportDetail_AutoHealReportDetail1.includeInLayout");
            result[24] = binding;
            return (result);
        }

        private function set battleObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._487945953battleObj;
            if (_local_2 !== _arg_1)
            {
                this._487945953battleObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "battleObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get autoHealObj():ObjectProxy
        {
            return (this._595557056autoHealObj);
        }

        [Bindable(event="propertyChange")]
        private function get ScoutObj():ObjectProxy
        {
            return (this._417656519ScoutObj);
        }

        private function _ScoutReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((Lang.msg("执行侦查任务的军队已经到达目标") + " ") + this.targetPos);
            _local_1 = this.ScoutObj;
            _local_1 = ((this.scoutInfoObj == null) ? false : true);
            _local_1 = ((this.scoutInfoObj == null) ? false : true);
            _local_1 = ((this.scoutInfoObj == null) ? false : true);
            _local_1 = ((this.scoutInfoObj == null) ? false : true);
            _local_1 = (Lang.msg("侦察报告") + ":");
            _local_1 = this.scoutInfoObj;
            _local_1 = ((this.battleObj == null) ? false : true);
            _local_1 = ((this.battleObj == null) ? false : true);
            _local_1 = ((this.battleObj == null) ? false : true);
            _local_1 = ((this.battleObj == null) ? false : true);
            _local_1 = Lang.msg("部队返回");
            _local_1 = this.battleObj.isBack;
            _local_1 = this.battleObj.isBack;
            _local_1 = this.battleObj.isBack;
            _local_1 = this.battleObj.isBack;
            _local_1 = ((this.battleObj.defendTroop != null) ? true : false);
            _local_1 = ((this.battleObj.defendTroop != null) ? true : false);
            _local_1 = ((this.ScoutObj.scoutInfo == null) ? Lang.msg("等级不够，无法侦察。") : Lang.msg("可以升级得到更多的信息。"));
            _local_1 = this.autoHealObj;
            _local_1 = this.autoHealObj;
            _local_1 = this.autoHealObj;
            _local_1 = this.autoHealObj;
            _local_1 = this.autoHealObj;
        }

        private function refresh():void
        {
            this.battleWin.setXmlObj(this.battleObj, this.startPos, this.targetPos);
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String, _arg_3:String):void
        {
            this.startPos = _arg_2;
            this.targetPos = _arg_3;
            this.ScoutObj = _arg_1;
            if (((!(_arg_1.battleInfo == null)) && (_arg_1.battleInfo is Object)))
            {
                this.battleObj = (_arg_1.battleInfo as ObjectProxy);
                if (this.initialized)
                {
                    this.refresh();
                };
            }
            else
            {
                this.battleObj = _arg_1.battleInfo;
            };
            autoHealObj = null;
            if (battleObj != null)
            {
                if (((!(battleObj.autoHeal == null)) && (this.battleObj.autoHeal is Object)))
                {
                    this.autoHealObj = (battleObj.autoHeal as ObjectProxy);
                }
                else
                {
                    this.autoHealObj = battleObj.autoHeal;
                };
            };
            if (((!(_arg_1.scoutInfo == null)) && (_arg_1.scoutInfo is Object)))
            {
                this.scoutInfoObj = (_arg_1.scoutInfo as ObjectProxy);
            }
            else
            {
                this.scoutInfoObj = _arg_1.scoutInfo;
            };
        }

        public function ___ScoutReportDetail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set ScoutObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._417656519ScoutObj;
            if (_local_2 !== _arg_1)
            {
                this._417656519ScoutObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ScoutObj", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports

