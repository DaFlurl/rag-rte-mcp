// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.GoodContainer

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ItemBean;
    import mx.controls.Button;
    import com.evony.eum.ItemEum;
    import mx.controls.Image;
    import mx.controls.Label;
    import view.module.shop.TreasureTooltip;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import mx.events.PropertyChangeEvent;
    import view.module.guide.GuideStep;
    import com.evony.Context;
    import com.evony.common.constants.CommonConstants;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.ItemEumDefine;
    import com.evony.factory.ImageManager;
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

    public class GoodContainer extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var dataObject:ItemBean;
        private var _1377735653butBtn:Button;
        private var itemEum:ItemEum;
        private var _738344555iconFile:Image;
        public var _GoodContainer_Label1:Label;
        private var tips:TreasureTooltip;
        public var _GoodContainer_Label3:Label;
        private var _2116189043itemNum:int;
        public var _GoodContainer_Label2:Label;
        private var _1177331774itemName:String;
        private var _2116183984itemImg:Object;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":238,
                    "height":101,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "29";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":66,
                                "height":66,
                                "styleName":"treasureContainerBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
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
                                            "width":63,
                                            "height":63
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"butBtn",
                        "events":{
                            "mouseMove":"__butBtn_mouseMove",
                            "mouseOut":"__butBtn_mouseOut",
                            "mouseOver":"__butBtn_mouseOver"
                        },
                        "stylesFactory":function ():void
                        {
                            this.bottom = "5";
                            this.right = "18";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "focusEnabled":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_GoodContainer_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "1";
                            this.right = "5";
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":23,
                                "styleName":"fontTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "left";
                            this.horizontalGap = 0;
                            this.top = "29";
                            this.left = "76";
                            this.right = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_GoodContainer_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"SpecialText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_GoodContainer_Label3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"SpecialText"});
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

        public function GoodContainer()
        {
            mx_internal::_document = this;
            this.width = 238;
            this.height = 101;
            this.styleName = "textBackgroundShopTiles";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GoodContainer._watcherSetupUtil = _arg_1;
        }


        private function _GoodContainer_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemImg;
            _local_1 = Lang.msg("说明");
            _local_1 = itemName;
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = ((itemNum > 100000000) ? ((itemNum / 1000000) + "M") : itemNum);
        }

        [Bindable(event="propertyChange")]
        private function get itemNum():int
        {
            return (this._2116189043itemNum);
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        [Bindable(event="propertyChange")]
        public function get butBtn():Button
        {
            return (this._1377735653butBtn);
        }

        override public function initialize():void
        {
            var target:GoodContainer;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GoodContainer_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_GoodContainerWatcherSetupUtil");
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

        public function __butBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOutHandle();
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

        public function set butBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1377735653butBtn;
            if (_local_2 !== _arg_1)
            {
                this._1377735653butBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "butBtn", _local_2, _arg_1));
            };
        }

        public function set itemVisible(_arg_1:String):void
        {
            if (((!(this.itemEum == null)) && (this.itemEum.itemType == _arg_1)))
            {
                this.visible = true;
                this.includeInLayout = true;
                if ((((((((((((((this.itemEum.id == "player.box.gambling.food") || (this.itemEum.id == "player.box.gambling.gold")) || (this.itemEum.id == "player.box.gambling.iron")) || (this.itemEum.id == "player.box.gambling.medal.10")) || (this.itemEum.id == "player.box.gambling.stone")) || (this.itemEum.id == "player.box.gambling.wood")) || (this.itemEum.id == "consume.key.1")) || (this.itemEum.id == "consume.key.2")) || (this.itemEum.id == "consume.key.3")) || (this.itemEum.id == "player.box.1")) || (this.itemEum.id == "player.box.2")) || (this.itemEum.id == "player.box.3")) || (this.itemEum.id == "player.box.present.3")))
                {
                    this.visible = false;
                    this.includeInLayout = false;
                };
                if (((Context.getInstance().needUserGuide) && (!(GuideStep.getInstance().currentStep == 14))))
                {
                    this.butBtn.enabled = false;
                }
                else
                {
                    this.butBtn.enabled = true;
                };
            }
            else
            {
                this.visible = false;
                this.includeInLayout = false;
            };
        }

        private function onMouseOverHandle(_arg_1:MouseEvent):void
        {
            if (dataObject.id != CommonConstants.ITEM_MEDAL_ID)
            {
                this.tips = TreasureTooltip.getInstance();
                this.tips.itemEum = this.itemEum;
                this.tips.moveToMouse(_arg_1);
                PopUpManager.addPopUp(this.tips, this);
            };
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

        public function set itemBean(_arg_1:ItemBean):void
        {
            this.dataObject = _arg_1;
            this.itemEum = ItemEumDefine.getItemEum(_arg_1.id);
            if (_arg_1.id != CommonConstants.ITEM_MEDAL_ID)
            {
                if (this.itemEum != null)
                {
                    itemName = itemEum.name;
                    itemImg = itemEum.iconUrl;
                }
                else
                {
                    itemName = _arg_1.id;
                    itemImg = null;
                };
                itemNum = _arg_1.count;
            }
            else
            {
                itemName = Lang.msg("元宝");
                itemNum = _arg_1.count;
                itemImg = ImageManager.getCommonImg(CommonConstants.ITEM_MEDAL_ID);
            };
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function __butBtn_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMoveHandle(_arg_1);
        }

        public function __butBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOverHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get itemImg():Object
        {
            return (this._2116183984itemImg);
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

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function _GoodContainer_bindingsSetup():Array
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
                var _local_1:* = Lang.msg("说明");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                butBtn.label = _arg_1;
            }, "butBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoodContainer_Label1.text = _arg_1;
            }, "_GoodContainer_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoodContainer_Label2.text = _arg_1;
            }, "_GoodContainer_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((itemNum > 100000000) ? ((itemNum / 1000000) + "M") : itemNum);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoodContainer_Label3.text = _arg_1;
            }, "_GoodContainer_Label3.text");
            result[4] = binding;
            return (result);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(this.itemEum.name, this.itemEum.itemDesc, _arg_1);
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

        private function set itemNum(_arg_1:int):void
        {
            var _local_2:Object = this._2116189043itemNum;
            if (_local_2 !== _arg_1)
            {
                this._2116189043itemNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemNum", _local_2, _arg_1));
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
}//package view.module.playerInfo

