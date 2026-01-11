// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.AwardContainer

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ItemBean;
    import com.evony.eum.ItemEum;
    import mx.controls.Image;
    import view.module.shop.TreasureTooltip;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.constants.CommonConstants;
    import com.evony.Lang;
    import com.evony.factory.ImageManager;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
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

    public class AwardContainer extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var dataObject:ItemBean;
        private var itemEum:ItemEum;
        private var _738344555iconFile:Image;
        private var tips:TreasureTooltip;
        public var _AwardContainer_Label1:Label;
        private var _1177331774itemName:String;
        private var _2116189043itemNum:int;
        private var _2116183984itemImg:Object;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":64,
                    "height":64,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"iconFile",
                        "events":{"complete":"__iconFile_complete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":61,
                                "height":61
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AwardContainer_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"simpleStyle",
                                "height":20
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

        public function AwardContainer()
        {
            mx_internal::_document = this;
            this.width = 64;
            this.height = 64;
            this.styleName = "treasureContainerBackGround";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AwardContainer_Canvas1_creationComplete);
            this.addEventListener("mouseMove", ___AwardContainer_Canvas1_mouseMove);
            this.addEventListener("mouseOut", ___AwardContainer_Canvas1_mouseOut);
            this.addEventListener("mouseOver", ___AwardContainer_Canvas1_mouseOver);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AwardContainer._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:AwardContainer;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AwardContainer_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_AwardContainerWatcherSetupUtil");
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

        public function init():void
        {
            this.mouseChildren = false;
        }

        [Bindable(event="propertyChange")]
        private function get itemImg():Object
        {
            return (this._2116183984itemImg);
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

        private function _AwardContainer_bindingsSetup():Array
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
                _AwardContainer_Label1.text = _arg_1;
            }, "_AwardContainer_Label1.text");
            result[1] = binding;
            return (result);
        }

        public function ___AwardContainer_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get itemName():String
        {
            return (this._1177331774itemName);
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set itemVisible(_arg_1:String):void
        {
            if (this.itemEum.itemType == _arg_1)
            {
                this.visible = true;
                this.includeInLayout = true;
            }
            else
            {
                this.visible = false;
                this.includeInLayout = false;
            };
        }

        public function set itemBean(_arg_1:ItemBean):void
        {
            this.dataObject = _arg_1;
            this.itemEum = ItemEumDefine.getItemEum(_arg_1.id);
            if (_arg_1.id != CommonConstants.ITEM_MEDAL_ID)
            {
                itemName = itemEum.name;
                itemImg = itemEum.iconUrl;
                itemNum = _arg_1.count;
            }
            else
            {
                itemName = Lang.msg("元宝");
                itemNum = _arg_1.count;
                itemImg = ImageManager.getCommonImg(CommonConstants.ITEM_MEDAL_ID);
            };
        }

        public function ___AwardContainer_Canvas1_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function ___AwardContainer_Canvas1_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
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

        public function get itemBean():ItemBean
        {
            return (this.dataObject);
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

        public function ___AwardContainer_Canvas1_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onMouseOut():void
        {
            if (this.tips != null)
            {
                PopUpManager.removePopUp(this.tips);
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemNum():int
        {
            return (this._2116189043itemNum);
        }

        private function _AwardContainer_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemImg;
            _local_1 = itemNum;
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (this.tips != null)
            {
                this.tips.moveToMouse(_arg_1);
            };
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            if (dataObject.id != CommonConstants.ITEM_MEDAL_ID)
            {
                this.tips = TreasureTooltip.getInstance();
                this.tips.itemEum = this.itemEum;
                this.tips.moveToMouse(_arg_1);
                PopUpManager.addPopUp(this.tips, this);
            };
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


    }
}//package view.module.playerInfo

