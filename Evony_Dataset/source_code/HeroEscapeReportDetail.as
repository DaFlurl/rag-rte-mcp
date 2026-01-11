// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.HeroEscapeReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.collections.ArrayCollection;
    import mx.utils.ObjectProxy;
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

    public class HeroEscapeReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2012413074heroNames:String = "";
        public var _HeroEscapeReportDetail_Text1:Text;
        public var _HeroEscapeReportDetail_Text2:Text;
        private var _1112064572castlePos:String;
        public var _HeroEscapeReportDetail_Label1:Label;
        public var _HeroEscapeReportDetail_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 2;
                            this.top = "10";
                            this.left = "10";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroEscapeReportDetail_Text1"
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
                                    "type":Label,
                                    "id":"_HeroEscapeReportDetail_Label1"
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
                                    "id":"_HeroEscapeReportDetail_Text2"
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
                                    "type":Label,
                                    "id":"_HeroEscapeReportDetail_Label2"
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HeroEscapeReportDetail()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HeroEscapeReportDetail._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get castlePos():String
        {
            return (this._1112064572castlePos);
        }

        override public function initialize():void
        {
            var target:HeroEscapeReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HeroEscapeReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_HeroEscapeReportDetailWatcherSetupUtil");
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

        private function set heroNames(_arg_1:String):void
        {
            var _local_2:Object = this._2012413074heroNames;
            if (_local_2 !== _arg_1)
            {
                this._2012413074heroNames = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroNames", _local_2, _arg_1));
            };
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String):void
        {
            var _local_3:ArrayCollection;
            var _local_4:int;
            if ((_arg_1.heroName is ArrayCollection))
            {
                _local_3 = (_arg_1.heroName as ArrayCollection);
                this.heroNames = "";
                _local_4 = 0;
                while (_local_4 < _local_3.length)
                {
                    if (_local_4 > 0)
                    {
                        this.heroNames = (this.heroNames + ",");
                    };
                    this.heroNames = (this.heroNames + _local_3[_local_4]);
                    _local_4++;
                };
            }
            else
            {
                this.heroNames = _arg_1.heroName;
            };
            this.castlePos = _arg_2;
        }

        [Bindable(event="propertyChange")]
        private function get heroNames():String
        {
            return (this._2012413074heroNames);
        }

        private function _HeroEscapeReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.castlePos + " ") + Lang.msg("财政无法按时支付将领俸禄"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroEscapeReportDetail_Text1.text = _arg_1;
            }, "_HeroEscapeReportDetail_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领出逃");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroEscapeReportDetail_Label1.text = _arg_1;
            }, "_HeroEscapeReportDetail_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.heroNames;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroEscapeReportDetail_Text2.text = _arg_1;
            }, "_HeroEscapeReportDetail_Text2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心下降");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroEscapeReportDetail_Label2.text = _arg_1;
            }, "_HeroEscapeReportDetail_Label2.text");
            result[3] = binding;
            return (result);
        }

        private function set castlePos(_arg_1:String):void
        {
            var _local_2:Object = this._1112064572castlePos;
            if (_local_2 !== _arg_1)
            {
                this._1112064572castlePos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castlePos", _local_2, _arg_1));
            };
        }

        private function _HeroEscapeReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.castlePos + " ") + Lang.msg("财政无法按时支付将领俸禄"));
            _local_1 = Lang.msg("将领出逃");
            _local_1 = this.heroNames;
            _local_1 = Lang.msg("民心下降");
        }


    }
}//package view.module.info.reports

