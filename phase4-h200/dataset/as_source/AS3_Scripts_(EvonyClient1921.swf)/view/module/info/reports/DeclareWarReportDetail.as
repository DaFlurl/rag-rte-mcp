// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.DeclareWarReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.utils.ObjectProxy;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class DeclareWarReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1607243192endTime:String;
        private var _486420412targetName:String;
        private var _109815obj:ObjectProxy;
        public var _DeclareWarReportDetail_Text1:Text;
        public var _DeclareWarReportDetail_Text2:Text;
        public var _DeclareWarReportDetail_Text3:Text;
        public var _DeclareWarReportDetail_Text4:Text;
        public var _DeclareWarReportDetail_Text5:Text;
        public var _DeclareWarReportDetail_Text7:Text;
        public var _DeclareWarReportDetail_Text6:Text;
        private var _2129294769startTime:String;
        private var _2129481203startName:String;
        private var _795051899warDir:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 3;
                            this.left = "10";
                            this.top = "5";
                            this.right = "10";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
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
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
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
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
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
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
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
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text5",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
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
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
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
                                    "type":Text,
                                    "id":"_DeclareWarReportDetail_Text7",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function DeclareWarReportDetail()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            DeclareWarReportDetail._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get warDir():String
        {
            return (this._795051899warDir);
        }

        private function set warDir(_arg_1:String):void
        {
            var _local_2:Object = this._795051899warDir;
            if (_local_2 !== _arg_1)
            {
                this._795051899warDir = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warDir", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get startName():String
        {
            return (this._2129481203startName);
        }

        override public function initialize():void
        {
            var target:DeclareWarReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DeclareWarReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_DeclareWarReportDetailWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (internal::target[_arg_1]);
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

        private function set startName(_arg_1:String):void
        {
            var _local_2:Object = this._2129481203startName;
            if (_local_2 !== _arg_1)
            {
                this._2129481203startName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startName", _local_2, _arg_1));
            };
        }

        private function _DeclareWarReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.warDir;
            _local_1 = Lang.msg("8小时后战争");
            _local_1 = Lang.msg("可互相攻击");
            _local_1 = Lang.msg("持续48小时");
            _local_1 = startTime;
            _local_1 = endTime;
            _local_1 = Lang.msg("使用道具提升战斗力");
        }

        private function set startTime(_arg_1:String):void
        {
            var _local_2:Object = this._2129294769startTime;
            if (_local_2 !== _arg_1)
            {
                this._2129294769startTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startTime", _local_2, _arg_1));
            };
        }

        private function set endTime(_arg_1:String):void
        {
            var _local_2:Object = this._1607243192endTime;
            if (_local_2 !== _arg_1)
            {
                this._1607243192endTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _local_2, _arg_1));
            };
        }

        public function set target(_arg_1:String):void
        {
            this.targetName = _arg_1;
        }

        private function _DeclareWarReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.warDir;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text1.text = _arg_1;
            }, "_DeclareWarReportDetail_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("8小时后战争");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text2.text = _arg_1;
            }, "_DeclareWarReportDetail_Text2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("可互相攻击");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text3.text = _arg_1;
            }, "_DeclareWarReportDetail_Text3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("持续48小时");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text4.text = _arg_1;
            }, "_DeclareWarReportDetail_Text4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = startTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text5.text = _arg_1;
            }, "_DeclareWarReportDetail_Text5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = endTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text6.text = _arg_1;
            }, "_DeclareWarReportDetail_Text6.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用道具提升战斗力");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DeclareWarReportDetail_Text7.text = _arg_1;
            }, "_DeclareWarReportDetail_Text7.text");
            result[6] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get targetName():String
        {
            return (this._486420412targetName);
        }

        public function set start(_arg_1:String):void
        {
            this.startName = _arg_1;
        }

        public function set xmlObj(_arg_1:ObjectProxy):void
        {
            this.obj = _arg_1;
            this.startTime = ("War will begin at " + obj.startTime);
            this.endTime = ("War will end at " + obj.endTime);
            if (obj.myself)
            {
                this.warDir = ("You have declared war against " + this.targetName);
            }
            else
            {
                this.warDir = (this.startName + " has declared war against you.");
            };
        }

        [Bindable(event="propertyChange")]
        private function get endTime():String
        {
            return (this._1607243192endTime);
        }

        [Bindable(event="propertyChange")]
        private function get startTime():String
        {
            return (this._2129294769startTime);
        }

        private function set obj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._109815obj;
            if (_local_2 !== _arg_1)
            {
                this._109815obj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "obj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get obj():ObjectProxy
        {
            return (this._109815obj);
        }

        private function set targetName(_arg_1:String):void
        {
            var _local_2:Object = this._486420412targetName;
            if (_local_2 !== _arg_1)
            {
                this._486420412targetName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetName", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports

