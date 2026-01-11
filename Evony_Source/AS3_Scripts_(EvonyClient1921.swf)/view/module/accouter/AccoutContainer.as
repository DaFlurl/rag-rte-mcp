// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.accouter.AccoutContainer

package view.module.accouter
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.EquipmentBean;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.factory.ItemManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import mx.managers.PopUpManager;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.EquipTechEum;
    import com.evony.eum.EquipTechEumDefine;
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

    public class AccoutContainer extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var dataObject:EquipmentBean;
        private var takeOffEnable:Boolean;
        public var posId:int;
        private var _738344555iconFile:Image;
        private var heroId:int;
        private var tips:AccouterTooltip;
        private var _2116189043itemNum:int;
        private var attriEnable:Boolean;
        private var _1177331774itemName:String;
        private var _2127704613itemClass:String;
        private var _1917741607showPanle:Boolean = true;
        private var _2116183984itemImg:Object;
        public var _AccoutContainer_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":60,
                    "height":60,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccoutContainer_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":-15,
                                "y":10,
                                "width":70,
                                "styleName":"LabelWhite13"
                            });
                        }
                    }), new UIComponentDescriptor({
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
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100
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

        public function AccoutContainer()
        {
            mx_internal::_document = this;
            this.width = 60;
            this.height = 60;
            this.clipContent = false;
            this.addEventListener("click", ___AccoutContainer_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AccoutContainer._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:AccoutContainer;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AccoutContainer_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_accouter_AccoutContainerWatcherSetupUtil");
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
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        public function setNull():void
        {
            itemImg = null;
            itemClass = Lang.msg(ItemManager.heroPosArray[(posId - 1)]);
            this.takeOffEnable = false;
            this.attriEnable = false;
        }

        public function ___AccoutContainer_Canvas1_click(_arg_1:MouseEvent):void
        {
            openAccoutPanel();
        }

        private function _AccoutContainer_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.itemClass;
            _local_1 = ((showPanle) ? Lang.msg("点击进行换装") : null);
            _local_1 = itemImg;
        }

        [Bindable(event="propertyChange")]
        private function get itemClass():String
        {
            return (this._2127704613itemClass);
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

        private function openAccoutPanel():void
        {
            if (showPanle)
            {
                ControlUI.show(this.heroId, this.posId, this.attriEnable, this.takeOffEnable);
            };
        }

        private function onMouseOutHandle():void
        {
            if (this.tips != null)
            {
                PopUpManager.removePopUp(this.tips);
            };
        }

        public function set showPanle(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1917741607showPanle;
            if (_local_2 !== _arg_1)
            {
                this._1917741607showPanle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showPanle", _local_2, _arg_1));
            };
        }

        public function setHeroId(_arg_1:int):void
        {
            this.heroId = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get itemName():String
        {
            return (this._1177331774itemName);
        }

        [Bindable(event="propertyChange")]
        private function get itemImg():Object
        {
            return (this._2116183984itemImg);
        }

        private function onMouseOverHandle(_arg_1:MouseEvent):void
        {
            this.tips = AccouterTooltip.getInstance();
            this.tips.moveToMouse(_arg_1);
            PopUpManager.addPopUp(this.tips, this);
            this.tips.itemEums = this.dataObject;
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMoveHandle(_arg_1);
        }

        public function set itemBean(_arg_1:EquipmentBean):void
        {
            var _local_2:EquipTechEum;
            this.dataObject = _arg_1;
            if (_arg_1.lv == 0)
            {
                itemImg = null;
                itemClass = Lang.msg(ItemManager.heroPosArray[(posId - 1)]);
                this.takeOffEnable = false;
                this.attriEnable = false;
                return;
            };
            if (_arg_1.addAttributeType == 0)
            {
                itemImg = null;
                itemClass = Lang.msg(ItemManager.heroPosArray[(posId - 1)]);
                this.takeOffEnable = false;
                this.attriEnable = true;
            }
            else
            {
                _local_2 = EquipTechEumDefine.getEquipTechEum(((_arg_1.equipmenttech + "_") + _arg_1.lv));
                itemImg = _local_2.iconURL;
                itemClass = null;
                this.takeOffEnable = true;
                this.attriEnable = true;
            };
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOverHandle(_arg_1);
        }

        private function set itemClass(_arg_1:String):void
        {
            var _local_2:Object = this._2127704613itemClass;
            if (_local_2 !== _arg_1)
            {
                this._2127704613itemClass = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemClass", _local_2, _arg_1));
            };
        }

        private function _AccoutContainer_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemClass;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccoutContainer_Label1.text = _arg_1;
            }, "_AccoutContainer_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showPanle) ? Lang.msg("点击进行换装") : null);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccoutContainer_Label1.toolTip = _arg_1;
            }, "_AccoutContainer_Label1.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (itemImg);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[2] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get showPanle():Boolean
        {
            return (this._1917741607showPanle);
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

        public function get itemBean():EquipmentBean
        {
            return (this.dataObject);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOutHandle();
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

        [Bindable(event="propertyChange")]
        private function get itemNum():int
        {
            return (this._2116189043itemNum);
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

        private function onMouseMoveHandle(_arg_1:MouseEvent):void
        {
            if (this.tips != null)
            {
                this.tips.moveToMouse(_arg_1);
            };
        }


    }
}//package view.module.accouter

