// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.SowDiscordReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import mx.utils.ObjectProxy;
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

    public class SowDiscordReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _SowDiscordReportDetail_Image1:Image;
        public var _SowDiscordReportDetail_Label1:Label;
        private var _619399765heroDesc:String;
        private var _410464834imgSource:String;
        public var _SowDiscordReportDetail_Text1:Text;
        private var _3079825desc:String;
        private var _1846061848heroVisible:Boolean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Text,
                        "id":"_SowDiscordReportDetail_Text1",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "styleName":"ParamgraphText2",
                                "height":54
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_SowDiscordReportDetail_Image1",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":54,
                                "width":40,
                                "height":40
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_SowDiscordReportDetail_Label1",
                        "stylesFactory":function ():void
                        {
                            this.left = "64";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ParamgraphText2",
                                "y":75,
                                "percentWidth":100
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SowDiscordReportDetail()
        {
            mx_internal::_document = this;
            this.styleName = "whiteBackGroundWithBode";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SowDiscordReportDetail._watcherSetupUtil = _arg_1;
        }


        private function _SowDiscordReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = desc;
            _local_1 = imgSource;
            _local_1 = heroVisible;
            _local_1 = heroVisible;
            _local_1 = heroDesc;
            _local_1 = heroVisible;
            _local_1 = heroVisible;
        }

        [Bindable(event="propertyChange")]
        private function get imgSource():String
        {
            return (this._410464834imgSource);
        }

        [Bindable(event="propertyChange")]
        private function get desc():String
        {
            return (this._3079825desc);
        }

        override public function initialize():void
        {
            var target:SowDiscordReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SowDiscordReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_SowDiscordReportDetailWatcherSetupUtil");
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

        private function set heroDesc(_arg_1:String):void
        {
            var _local_2:Object = this._619399765heroDesc;
            if (_local_2 !== _arg_1)
            {
                this._619399765heroDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroDesc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroVisible():Boolean
        {
            return (this._1846061848heroVisible);
        }

        public function setXmlObj(_arg_1:ObjectProxy):void
        {
            this.desc = Lang.msg("挑拨战报描述", _arg_1.suzerainLord, _arg_1.suzerainCastle);
            if (_arg_1.capturedHero != null)
            {
                imgSource = _arg_1.capturedHero.heroURL;
                heroDesc = Lang.msg("挑拨战报英雄", _arg_1.capturedHero.heroName, _arg_1.capturedHero.heroLevel);
                heroVisible = true;
            }
            else
            {
                heroVisible = false;
            };
        }

        private function _SowDiscordReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SowDiscordReportDetail_Text1.htmlText = _arg_1;
            }, "_SowDiscordReportDetail_Text1.htmlText");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (imgSource);
            }, function (_arg_1:Object):void
            {
                _SowDiscordReportDetail_Image1.source = _arg_1;
            }, "_SowDiscordReportDetail_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroVisible);
            }, function (_arg_1:Boolean):void
            {
                _SowDiscordReportDetail_Image1.visible = _arg_1;
            }, "_SowDiscordReportDetail_Image1.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroVisible);
            }, function (_arg_1:Boolean):void
            {
                _SowDiscordReportDetail_Image1.includeInLayout = _arg_1;
            }, "_SowDiscordReportDetail_Image1.includeInLayout");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SowDiscordReportDetail_Label1.text = _arg_1;
            }, "_SowDiscordReportDetail_Label1.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroVisible);
            }, function (_arg_1:Boolean):void
            {
                _SowDiscordReportDetail_Label1.visible = _arg_1;
            }, "_SowDiscordReportDetail_Label1.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroVisible);
            }, function (_arg_1:Boolean):void
            {
                _SowDiscordReportDetail_Label1.includeInLayout = _arg_1;
            }, "_SowDiscordReportDetail_Label1.includeInLayout");
            result[6] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get heroDesc():String
        {
            return (this._619399765heroDesc);
        }

        private function set heroVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1846061848heroVisible;
            if (_local_2 !== _arg_1)
            {
                this._1846061848heroVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroVisible", _local_2, _arg_1));
            };
        }

        private function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        private function set imgSource(_arg_1:String):void
        {
            var _local_2:Object = this._410464834imgSource;
            if (_local_2 !== _arg_1)
            {
                this._410464834imgSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSource", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports

