// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.TroopTypeUI

package view.module.trainningField
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import view.module.barrack.ArmyInfoTooltip;
    import mx.events.PropertyChangeEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.TroopEumDefine;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.factory.ImageManager;
    import flash.display.Bitmap;
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

    public class TroopTypeUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1294617975_amount:*;
        private var _858803723typeId:int;
        private var bakTypeId:int;
        public var _TroopTypeUI_Image1:Image;
        private var _1523380288_imgSrc:Object;
        public var _TroopTypeUI_Label1:Label;
        public var _TroopTypeUI_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":35,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 5;
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_TroopTypeUI_Image1",
                                    "events":{
                                        "complete":"___TroopTypeUI_Image1_complete",
                                        "mouseOut":"___TroopTypeUI_Image1_mouseOut",
                                        "mouseMove":"___TroopTypeUI_Image1_mouseMove",
                                        "mouseOver":"___TroopTypeUI_Image1_mouseOver"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":25,
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TroopTypeUI_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"tableContent1",
                                            "width":130
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TroopTypeUI_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"tableContent2",
                                            "width":90
                                        });
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

        public function TroopTypeUI()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.height = 35;
            this.styleName = "armyTiles";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopTypeUI._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get _imgSrc():Object
        {
            return (this._1523380288_imgSrc);
        }

        public function ___TroopTypeUI_Image1_mouseOut(_arg_1:MouseEvent):void
        {
            hideArmyTooltip();
        }

        private function hideArmyTooltip():void
        {
            ArmyInfoTooltip.hide();
        }

        public function ___TroopTypeUI_Image1_mouseOver(_arg_1:MouseEvent):void
        {
            showArmyTooltip(_arg_1);
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

        public function ___TroopTypeUI_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get typeId():int
        {
            return (this._858803723typeId);
        }

        private function _TroopTypeUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._imgSrc;
            _local_1 = TroopEumDefine.getTroopEumByType(this.typeId).name;
            _local_1 = this._amount;
        }

        override public function initialize():void
        {
            var target:TroopTypeUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopTypeUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_TroopTypeUIWatcherSetupUtil");
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

        public function set imgSrc(_arg_1:int):void
        {
            this.typeId = _arg_1;
            this._imgSrc = ImageManager.getTroopSmallLogo(_arg_1);
            this.bakTypeId = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get _amount():*
        {
            return (this._1294617975_amount);
        }

        private function onArmyMouseMove(_arg_1:MouseEvent):void
        {
            ArmyInfoTooltip.move2Mouse(_arg_1);
        }

        private function set _amount(_arg_1:*):void
        {
            var _local_2:Object = this._1294617975_amount;
            if (_local_2 !== _arg_1)
            {
                this._1294617975_amount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_amount", _local_2, _arg_1));
            };
        }

        private function showArmyTooltip(_arg_1:MouseEvent):void
        {
            ArmyInfoTooltip.show(this.bakTypeId, _arg_1);
        }

        public function ___TroopTypeUI_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onArmyMouseMove(_arg_1);
        }

        private function _TroopTypeUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this._imgSrc);
            }, function (_arg_1:Object):void
            {
                _TroopTypeUI_Image1.source = _arg_1;
            }, "_TroopTypeUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = TroopEumDefine.getTroopEumByType(this.typeId).name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopTypeUI_Label1.text = _arg_1;
            }, "_TroopTypeUI_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._amount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopTypeUI_Label2.text = _arg_1;
            }, "_TroopTypeUI_Label2.text");
            result[2] = binding;
            return (result);
        }

        public function set amount(_arg_1:*):void
        {
            this._amount = _arg_1;
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

        private function onLoadComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                Bitmap(_arg_1.target.content).smoothing = true;
            };
        }


    }
}//package view.module.trainningField

