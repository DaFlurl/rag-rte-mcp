// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Reports.ReportView

package autoevony.gui.info.Reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TabBar;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.common.constants.ObjConstants;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
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

    use namespace mx_internal;

    public class ReportView extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _3002781army:Reports;
        private var _1057242163reportInfoTab:TabBar;
        private var _109264638scout:Reports;
        private var _1897885786reportInfoStack:ViewStack;
        private var _110621028trade:Reports;
        private var _106069776other:Reports;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"none",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "0";
                            this.top = "3";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "bottom";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TabBar,
                                                "id":"reportInfoTab",
                                                "stylesFactory":function ():void
                                                {
                                                    this.tabStyleName = "REtabBarTab";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "dataProvider":"reportInfoStack",
                                                        "styleName":"REtabBar"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"reportInfoStack",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderColor = 0x222222;
                                        this.borderThickness = 1;
                                        this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "creationPolicy":"all",
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Reports,
                                                "id":"army",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Army"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Reports,
                                                "id":"scout",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Scout"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Reports,
                                                "id":"trade",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Trade"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Reports,
                                                "id":"other",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Other"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ReportView()
        {
            mx_internal::_document = this;
            this.creationPolicy = "none";
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ReportView._watcherSetupUtil = _arg_1;
        }


        private function _ReportView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ObjConstants.REPORT_TYPE_ARMY;
            _local_1 = ObjConstants.REPORT_TYPE_SCOUT;
            _local_1 = ObjConstants.REPORT_TYPE_TRADE;
            _local_1 = ObjConstants.REPORT_TYPE_OTHER;
        }

        public function set trade(_arg_1:Reports):void
        {
            var _local_2:Object = this._110621028trade;
            if (_local_2 !== _arg_1)
            {
                this._110621028trade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "trade", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get reportInfoTab():TabBar
        {
            return (this._1057242163reportInfoTab);
        }

        [Bindable(event="propertyChange")]
        public function get scout():Reports
        {
            return (this._109264638scout);
        }

        private function _ReportView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (ObjConstants.REPORT_TYPE_ARMY);
            }, function (_arg_1:int):void
            {
                army.reportType = _arg_1;
            }, "army.reportType");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (ObjConstants.REPORT_TYPE_SCOUT);
            }, function (_arg_1:int):void
            {
                scout.reportType = _arg_1;
            }, "scout.reportType");
            result[1] = binding;
            binding = new Binding(this, function ():int
            {
                return (ObjConstants.REPORT_TYPE_TRADE);
            }, function (_arg_1:int):void
            {
                trade.reportType = _arg_1;
            }, "trade.reportType");
            result[2] = binding;
            binding = new Binding(this, function ():int
            {
                return (ObjConstants.REPORT_TYPE_OTHER);
            }, function (_arg_1:int):void
            {
                other.reportType = _arg_1;
            }, "other.reportType");
            result[3] = binding;
            return (result);
        }

        public function toDebugString():String
        {
            return ("field: army scout trade other");
        }

        override public function initialize():void
        {
            var target:ReportView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._ReportView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Reports_ReportViewWatcherSetupUtil");
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

        public function set reportInfoStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1897885786reportInfoStack;
            if (_local_2 !== _arg_1)
            {
                this._1897885786reportInfoStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportInfoStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get army():Reports
        {
            return (this._3002781army);
        }

        public function set other(_arg_1:Reports):void
        {
            var _local_2:Object = this._106069776other;
            if (_local_2 !== _arg_1)
            {
                this._106069776other = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "other", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get reportInfoStack():ViewStack
        {
            return (this._1897885786reportInfoStack);
        }

        [Bindable(event="propertyChange")]
        public function get other():Reports
        {
            return (this._106069776other);
        }

        [Bindable(event="propertyChange")]
        public function get trade():Reports
        {
            return (this._110621028trade);
        }

        public function set army(_arg_1:Reports):void
        {
            var _local_2:Object = this._3002781army;
            if (_local_2 !== _arg_1)
            {
                this._3002781army = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "army", _local_2, _arg_1));
            };
        }

        public function set scout(_arg_1:Reports):void
        {
            var _local_2:Object = this._109264638scout;
            if (_local_2 !== _arg_1)
            {
                this._109264638scout = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scout", _local_2, _arg_1));
            };
        }

        public function set reportInfoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1057242163reportInfoTab;
            if (_local_2 !== _arg_1)
            {
                this._1057242163reportInfoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportInfoTab", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui.info.Reports

