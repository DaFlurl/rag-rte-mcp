// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.LostTroopUI

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.factory.ImageManager;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.eum.FortificationEumDefine;
    import com.evony.eum.TroopEumDefine;
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

    public class LostTroopUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _LostTroopUI_Image1:Image;
        public var _LostTroopUI_Label1:Label;
        public var _LostTroopUI_Label2:Label;
        private var _91062260_lose:int;
        public var _LostTroopUI_Label3:Label;
        private var _858803723typeId:int;
        private var _1480346608_count:int;
        private var _1523380288_imgSrc:Object;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":294,
                    "height":35,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_LostTroopUI_Image1",
                        "events":{"creationComplete":"___LostTroopUI_Image1_creationComplete"},
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":25,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.verticalCenter = "0";
                            this.horizontalAlign = "right";
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":0x0100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LostTroopUI_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":80});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LostTroopUI_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":80});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LostTroopUI_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":80});
                                    }
                                })]
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

        public function LostTroopUI()
        {
            mx_internal::_document = this;
            this.width = 294;
            this.height = 35;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LostTroopUI._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get _imgSrc():Object
        {
            return (this._1523380288_imgSrc);
        }

        public function set imgSrc(_arg_1:int):void
        {
            this.typeId = _arg_1;
            if (_arg_1 >= 14)
            {
                this._imgSrc = ImageManager.getFortSmallLogo(_arg_1);
            }
            else
            {
                this._imgSrc = ImageManager.getTroopSmallLogo(_arg_1);
            };
        }

        [Bindable(event="propertyChange")]
        private function get _lose():int
        {
            return (this._91062260_lose);
        }

        private function set _imgSrc(_arg_1:Object):void
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
            var target:LostTroopUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _LostTroopUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_LostTroopUIWatcherSetupUtil");
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

        private function _LostTroopUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this._imgSrc);
            }, function (_arg_1:Object):void
            {
                _LostTroopUI_Image1.source = _arg_1;
            }, "_LostTroopUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = getTypeName(this.typeId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LostTroopUI_Label1.text = _arg_1;
            }, "_LostTroopUI_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._count;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LostTroopUI_Label2.text = _arg_1;
            }, "_LostTroopUI_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._lose;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LostTroopUI_Label3.text = _arg_1;
            }, "_LostTroopUI_Label3.text");
            result[3] = binding;
            return (result);
        }

        private function _LostTroopUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._imgSrc;
            _local_1 = getTypeName(this.typeId);
            _local_1 = this._count;
            _local_1 = this._lose;
        }

        private function getTypeName(_arg_1:int):String
        {
            var _local_2:String;
            if (_arg_1 >= 14)
            {
                _local_2 = FortificationEumDefine.getFortificationEumByType(_arg_1).name;
            }
            else
            {
                _local_2 = TroopEumDefine.getTroopEumByType(_arg_1).name;
            };
            return (_local_2);
        }

        public function set count(_arg_1:int):void
        {
            this._count = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get _count():int
        {
            return (this._1480346608_count);
        }

        private function set _count(_arg_1:int):void
        {
            var _local_2:Object = this._1480346608_count;
            if (_local_2 !== _arg_1)
            {
                this._1480346608_count = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_count", _local_2, _arg_1));
            };
        }

        public function ___LostTroopUI_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function set _lose(_arg_1:int):void
        {
            var _local_2:Object = this._91062260_lose;
            if (_local_2 !== _arg_1)
            {
                this._91062260_lose = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_lose", _local_2, _arg_1));
            };
        }

        public function set lose(_arg_1:int):void
        {
            this._lose = _arg_1;
        }

        private function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeId():int
        {
            return (this._858803723typeId);
        }


    }
}//package view.module.info.reports.ReportUi

