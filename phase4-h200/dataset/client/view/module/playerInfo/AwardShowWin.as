// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.AwardShowWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.containers.Tile;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.common.module.shop.UseItemResultResponse;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import com.evony.common.beans.ItemBean;
    import mx.core.Application;
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

    public class AwardShowWin extends Canvas implements IBindingClient 
    {

        private static var instance:AwardShowWin = new (AwardShowWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var space_y:int = 63;
        private var containerWidth:int = 64;
        private var containerHeight:int = 64;
        private var maxCount:int = 7;
        private var goodCount:int = 0;
        private var _1178661300item_x:int = 63;
        public var _AwardShowWin_Label1:Label;
        private var minCount:int = 3;
        private var distance_x:int = 10;
        private var distance_y:int = 5;
        private var _1177154070itemHbox:Tile;
        private var space_x:int = 73;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":200,
                    "width":300,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AwardShowWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Tile,
                        "id":"itemHbox",
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 5;
                            this.horizontalGap = 10;
                            this.borderStyle = "none";
                            this.backgroundAlpha = 0;
                            this.kerning = true;
                            this.top = "110";
                            this.bottom = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "direction":"horizontal",
                                "showInAutomationHierarchy":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AwardShowWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _itemBeansArray:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(300);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AwardShowWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.height = 200;
            this.width = 300;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AwardShowWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:UseItemResultResponse):void
        {
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                PopUpManager.centerPopUp(instance);
            };
            instance.itemShow(_arg_1);
        }


        private function set item_x(_arg_1:int):void
        {
            var _local_2:Object = this._1178661300item_x;
            if (_local_2 !== _arg_1)
            {
                this._1178661300item_x = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "item_x", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemHbox():Tile
        {
            return (this._1177154070itemHbox);
        }

        public function set itemHbox(_arg_1:Tile):void
        {
            var _local_2:Object = this._1177154070itemHbox;
            if (_local_2 !== _arg_1)
            {
                this._1177154070itemHbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemHbox", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AwardShowWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AwardShowWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_AwardShowWinWatcherSetupUtil");
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

        public function ___AwardShowWin_Button1_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        private function get item_x():int
        {
            return (this._1178661300item_x);
        }

        private function _AwardShowWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardShowWin_Label1.text = _arg_1;
            }, "_AwardShowWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = item_x;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                itemHbox.setStyle("left", _arg_1);
            }, "itemHbox.left");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = item_x;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                itemHbox.setStyle("right", _arg_1);
            }, "itemHbox.right");
            result[2] = binding;
            return (result);
        }

        private function _AwardShowWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("获得");
            _local_1 = item_x;
            _local_1 = item_x;
        }

        private function itemShow(_arg_1:UseItemResultResponse):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:ItemBean;
            var _local_5:AwardContainer;
            this.goodCount = 0;
            this._itemBeansArray = _arg_1.itemBeansArray;
            if (this._itemBeansArray.length > 0)
            {
                _local_2 = 0;
                while (_local_2 < this._itemBeansArray.length)
                {
                    if (_arg_1.getItemBeans(_local_2).count > 0)
                    {
                        this.goodCount++;
                    };
                    _local_2++;
                };
                this.uiCache.reset();
                this.itemHbox.removeAllChildren();
                if (this.goodCount < maxCount)
                {
                    this.width = 450;
                    item_x = ((450 - (containerWidth + ((distance_x + containerWidth) * (this.goodCount - 1)))) / 2);
                }
                else
                {
                    this.width = (((space_x * 2) + containerWidth) + ((distance_x + containerWidth) * (Math.ceil((this.goodCount / Math.ceil((this.goodCount / (maxCount - 1))))) - 1)));
                    item_x = space_x;
                };
                this.height = ((((space_y * 2) + containerHeight) + ((Math.ceil((this.goodCount / (maxCount - 1))) - 1) * (containerHeight + distance_y))) + 100);
                this.x = ((Application.application.width - this.width) / 2);
                this.y = ((Application.application.height - this.height) / 2);
                _local_3 = 0;
                while (_local_3 < this._itemBeansArray.length)
                {
                    _local_4 = _arg_1.getItemBeans(_local_3);
                    if (_local_4.count > 0)
                    {
                        _local_5 = (this.uiCache.getUI(AwardContainer) as AwardContainer);
                        _local_5.itemBean = _local_4;
                        this.itemHbox.addChild(_local_5);
                    };
                    _local_3++;
                };
            };
        }

        private function close():void
        {
            PopUpManager.removePopUp(this);
        }


    }
}//package view.module.playerInfo

