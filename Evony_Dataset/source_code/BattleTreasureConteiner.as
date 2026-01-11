// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.BattleTreasureConteiner

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.ItemEum;
    import mx.controls.Image;
    import view.module.shop.TreasureTooltip;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import view.ui.DescribeTooltip;
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

    public class BattleTreasureConteiner extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1177331774itemName:String;
        private var _2116183984itemImg:Object;
        private var itemEum:ItemEum;
        private var _2116189043itemNum:int;
        private var _738344555iconFile:Image;
        private var tips:TreasureTooltip;
        public var _BattleTreasureConteiner_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":70,
                    "height":35,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"iconFile",
                                    "events":{
                                        "complete":"__iconFile_complete",
                                        "mouseOver":"__iconFile_mouseOver",
                                        "mouseOut":"__iconFile_mouseOut",
                                        "mouseMove":"__iconFile_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":32,
                                            "height":32
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BattleTreasureConteiner_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":100});
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

        public function BattleTreasureConteiner()
        {
            mx_internal::_document = this;
            this.width = 70;
            this.height = 35;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BattleTreasureConteiner._watcherSetupUtil = _arg_1;
        }


        private function onMouseOverHandle(_arg_1:MouseEvent):void
        {
            this.tips = TreasureTooltip.getInstance();
            this.tips.itemEum = this.itemEum;
            this.tips.moveToMouse(_arg_1);
            PopUpManager.addPopUp(this.tips, this);
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get itemName():String
        {
            return (this._1177331774itemName);
        }

        [Bindable(event="propertyChange")]
        private function get itemNum():int
        {
            return (this._2116189043itemNum);
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function set myItemNum(_arg_1:int):void
        {
            itemNum = _arg_1;
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        override public function initialize():void
        {
            var target:BattleTreasureConteiner;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BattleTreasureConteiner_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_BattleTreasureConteinerWatcherSetupUtil");
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

        private function _BattleTreasureConteiner_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (itemImg);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleTreasureConteiner_Label1.text = _arg_1;
            }, "_BattleTreasureConteiner_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((itemNum > 1) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleTreasureConteiner_Label1.visible = _arg_1;
            }, "_BattleTreasureConteiner_Label1.visible");
            result[2] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get itemImg():Object
        {
            return (this._2116183984itemImg);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        private function set itemName(_arg_1:String):void
        {
            var _local_2:Object = this._1177331774itemName;
            if (_local_2 !== _arg_1)
            {
                this._1177331774itemName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemName", _local_2, _arg_1));
            };
        }

        private function set itemImg(_arg_1:Object):void
        {
            var _local_2:Object = this._2116183984itemImg;
            if (_local_2 !== _arg_1)
            {
                this._2116183984itemImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemImg", _local_2, _arg_1));
            };
        }

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        private function onMouseOutHandle():void
        {
            if (this.tips != null)
            {
                PopUpManager.removePopUp(this.tips);
            };
        }

        public function set iconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        private function set itemNum(_arg_1:int):void
        {
            var _local_2:Object = this._2116189043itemNum;
            if (_local_2 !== _arg_1)
            {
                this._2116189043itemNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemNum", _local_2, _arg_1));
            };
        }

        private function _BattleTreasureConteiner_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemImg;
            _local_1 = itemNum;
            _local_1 = ((itemNum > 1) ? true : false);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(this.itemEum.name, this.itemEum.itemDesc, _arg_1);
        }

        public function set myItemEum(_arg_1:ItemEum):void
        {
            this.itemEum = _arg_1;
            itemName = itemEum.name;
            itemImg = itemEum.iconUrl;
            if (_arg_1.id == "player.item.candy")
            {
                itemImg = "images/icon/shop/candydrop.png";
            };
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onMouseMoveHandle(_arg_1:MouseEvent):void
        {
            if (this.tips != null)
            {
                this.tips.moveToMouse(_arg_1);
            };
        }


    }
}//package view.module.info.reports.ReportUi

