// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.LoseHeroUnitUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
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

    public class LoseHeroUnitUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1806289884_loseHeroInfo:String;
        public var _LoseHeroUnitUi_Image1:Image;
        private var _1523380288_imgSrc:String;
        public var _LoseHeroUnitUi_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":35,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_LoseHeroUnitUi_Image1",
                        "events":{"creationComplete":"___LoseHeroUnitUi_Image1_creationComplete"},
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":35,
                                "height":35
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_LoseHeroUnitUi_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":43,
                                "y":9
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

        public function LoseHeroUnitUi()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.height = 35;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LoseHeroUnitUi._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get _imgSrc():String
        {
            return (this._1523380288_imgSrc);
        }

        public function set loseHeroInfo(_arg_1:String):void
        {
            this._loseHeroInfo = _arg_1;
        }

        public function set imgSrc(_arg_1:String):void
        {
            this._imgSrc = _arg_1;
        }

        private function set _imgSrc(_arg_1:String):void
        {
            var _local_2:Object = this._1523380288_imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1523380288_imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_imgSrc", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:LoseHeroUnitUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _LoseHeroUnitUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_LoseHeroUnitUiWatcherSetupUtil");
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

        private function _LoseHeroUnitUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this._imgSrc);
            }, function (_arg_1:Object):void
            {
                _LoseHeroUnitUi_Image1.source = _arg_1;
            }, "_LoseHeroUnitUi_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._loseHeroInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoseHeroUnitUi_Label1.text = _arg_1;
            }, "_LoseHeroUnitUi_Label1.text");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get _loseHeroInfo():String
        {
            return (this._1806289884_loseHeroInfo);
        }

        public function ___LoseHeroUnitUi_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function _LoseHeroUnitUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._imgSrc;
            _local_1 = this._loseHeroInfo;
        }

        private function set _loseHeroInfo(_arg_1:String):void
        {
            var _local_2:Object = this._1806289884_loseHeroInfo;
            if (_local_2 !== _arg_1)
            {
                this._1806289884_loseHeroInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_loseHeroInfo", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

