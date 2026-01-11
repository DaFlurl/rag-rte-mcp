// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.wall.CastleDefProduceUI

package view.module.wall
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import com.evony.common.beans.ProduceBean;
    import mx.controls.Image;
    import view.ui.RemainTimeLabel;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.factory.ImageManager;
    import com.evony.Lang;
    import com.evony.util.UIUtil;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import view.ui.SpeedupItemSelector;
    import com.evony.factory.ItemManager;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import com.evony.events.CommonProduceEvent;
    import flash.display.Bitmap;
    import flash.events.Event;
    import com.evony.eum.ItemEum;
    import com.evony.eum.FortificationEumDefine;
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

    public class CastleDefProduceUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _676507419typeName:String;
        private var _26187659timeTitle:String;
        private var _675646097vsInQueue:HBox;
        private var _1185090783imgSrc:Object;
        private var _476548482cancelBtn:Button;
        private var _734350791vsSelectIndex:int = 0;
        private var _946505330viewstack1:ViewStack;
        private var _3019696bean:ProduceBean;
        public var _CastleDefProduceUI_Image1:Image;
        private var _84932619quickenUpBtn:Button;
        private var _1210321869remainTimeUi:RemainTimeLabel;
        public var _CastleDefProduceUI_Label1:Label;
        public var _CastleDefProduceUI_Label2:Label;
        public var _CastleDefProduceUI_Label4:Label;
        public var _CastleDefProduceUI_Label5:Label;
        private var _1758951584vsProducing:HBox;
        public var _CastleDefProduceUI_Label3:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":280,
                    "height":45,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"cancelBtn",
                        "events":{"click":"__cancelBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":23,
                                "width":20,
                                "height":20,
                                "styleName":"interruption"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_CastleDefProduceUI_Image1",
                        "events":{"creationComplete":"___CastleDefProduceUI_Image1_creationComplete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":6,
                                "width":40,
                                "height":32
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"quickenUpBtn",
                        "events":{"click":"__quickenUpBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":3,
                                "styleName":"quickenUp"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":54,
                                "width":184,
                                "height":20,
                                "y":1,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduceUI_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":120});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduceUI_Label2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":60});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":54,
                                "y":23,
                                "width":201,
                                "height":20,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"vsProducing",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleDefProduceUI_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":RemainTimeLabel,
                                                "id":"remainTimeUi",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"vsInQueue",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleDefProduceUI_Label4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleDefProduceUI_Label5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":100});
                                                }
                                            })]
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

        public function CastleDefProduceUI()
        {
            mx_internal::_document = this;
            this.width = 280;
            this.height = 45;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleDefProduceUI._watcherSetupUtil = _arg_1;
        }


        private function _CastleDefProduceUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ImageManager.getFortSmallLogo(bean.type);
            _local_1 = (this.typeName + ": ");
            _local_1 = this.bean.num;
            _local_1 = this.vsSelectIndex;
            _local_1 = (Lang.msg("耗时") + ": ");
            _local_1 = this.bean.endTime;
            _local_1 = (Lang.msg("耗时") + ": ");
            _local_1 = UIUtil.timeToString(this.bean.costTime);
        }

        [Bindable(event="propertyChange")]
        public function get cancelBtn():Button
        {
            return (this._476548482cancelBtn);
        }

        public function set cancelBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._476548482cancelBtn;
            if (_local_2 !== _arg_1)
            {
                this._476548482cancelBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancelBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeName():String
        {
            return (this._676507419typeName);
        }

        [Bindable(event="propertyChange")]
        public function get quickenUpBtn():Button
        {
            return (this._84932619quickenUpBtn);
        }

        [Bindable(event="propertyChange")]
        public function get vsProducing():HBox
        {
            return (this._1758951584vsProducing);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        override public function initialize():void
        {
            var target:CastleDefProduceUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleDefProduceUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_wall_CastleDefProduceUIWatcherSetupUtil");
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
        private function get timeTitle():String
        {
            return (this._26187659timeTitle);
        }

        private function set bean(_arg_1:ProduceBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        public function set remainTimeUi(_arg_1:RemainTimeLabel):void
        {
            var _local_2:Object = this._1210321869remainTimeUi;
            if (_local_2 !== _arg_1)
            {
                this._1210321869remainTimeUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainTimeUi", _local_2, _arg_1));
            };
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        public function set quickenUpBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._84932619quickenUpBtn;
            if (_local_2 !== _arg_1)
            {
                this._84932619quickenUpBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "quickenUpBtn", _local_2, _arg_1));
            };
        }

        private function set vsSelectIndex(_arg_1:int):void
        {
            var _local_2:Object = this._734350791vsSelectIndex;
            if (_local_2 !== _arg_1)
            {
                this._734350791vsSelectIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "vsSelectIndex", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        private function speedup():void
        {
            SpeedupItemSelector.show(ItemManager.speedDefenceArray, onSpeedUpItemSelected);
        }

        private function set timeTitle(_arg_1:String):void
        {
            var _local_2:Object = this._26187659timeTitle;
            if (_local_2 !== _arg_1)
            {
                this._26187659timeTitle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "timeTitle", _local_2, _arg_1));
            };
        }

        public function ___CastleDefProduceUI_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        public function __cancelBtn_click(_arg_1:MouseEvent):void
        {
            cancelTroopProduce();
        }

        [Bindable(event="propertyChange")]
        private function get bean():ProduceBean
        {
            return (this._3019696bean);
        }

        public function __quickenUpBtn_click(_arg_1:MouseEvent):void
        {
            speedup();
        }

        private function freeSpeed(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                CommonProduceEvent.speedup(Wall.EVENT_FREE_SPEEDUP, this.bean, null);
            };
        }

        private function set imgSrc(_arg_1:Object):void
        {
            var _local_2:Object = this._1185090783imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1185090783imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSrc", _local_2, _arg_1));
            };
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function set vsProducing(_arg_1:HBox):void
        {
            var _local_2:Object = this._1758951584vsProducing;
            if (_local_2 !== _arg_1)
            {
                this._1758951584vsProducing = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "vsProducing", _local_2, _arg_1));
            };
        }

        private function cancelTroopProduce():void
        {
            CommonProduceEvent.cancel(Wall.EVENT_CANCEL, this.bean);
        }

        private function onSpeedUpItemSelected(_arg_1:ItemEum=null):void
        {
            if (_arg_1 != null)
            {
                CommonProduceEvent.speedup(Wall.EVENT_SPEEDUP, this.bean, _arg_1);
            };
        }

        [Bindable(event="propertyChange")]
        public function get remainTimeUi():RemainTimeLabel
        {
            return (this._1210321869remainTimeUi);
        }

        private function _CastleDefProduceUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getFortSmallLogo(bean.type));
            }, function (_arg_1:Object):void
            {
                _CastleDefProduceUI_Image1.source = _arg_1;
            }, "_CastleDefProduceUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.typeName + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduceUI_Label1.text = _arg_1;
            }, "_CastleDefProduceUI_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.bean.num;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduceUI_Label2.text = _arg_1;
            }, "_CastleDefProduceUI_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.vsSelectIndex);
            }, function (_arg_1:int):void
            {
                viewstack1.selectedIndex = _arg_1;
            }, "viewstack1.selectedIndex");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("耗时") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduceUI_Label3.text = _arg_1;
            }, "_CastleDefProduceUI_Label3.text");
            result[4] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.bean.endTime);
            }, function (_arg_1:Number):void
            {
                remainTimeUi.remainTime = _arg_1;
            }, "remainTimeUi.remainTime");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("耗时") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduceUI_Label4.text = _arg_1;
            }, "_CastleDefProduceUI_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.timeToString(this.bean.costTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduceUI_Label5.text = _arg_1;
            }, "_CastleDefProduceUI_Label5.text");
            result[7] = binding;
            return (result);
        }

        private function set typeName(_arg_1:String):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get vsSelectIndex():int
        {
            return (this._734350791vsSelectIndex);
        }

        public function set vsInQueue(_arg_1:HBox):void
        {
            var _local_2:Object = this._675646097vsInQueue;
            if (_local_2 !== _arg_1)
            {
                this._675646097vsInQueue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "vsInQueue", _local_2, _arg_1));
            };
        }

        public function set produceBean(_arg_1:ProduceBean):void
        {
            this.bean = _arg_1;
            this.typeName = FortificationEumDefine.getFortificationEumByType(_arg_1.type).name;
            if (_arg_1.endTime > 0)
            {
                this.vsSelectIndex = 0;
            }
            else
            {
                this.vsSelectIndex = 1;
            };
        }

        public function getLeftTime():Number
        {
            return (remainTimeUi.leftTime);
        }

        [Bindable(event="propertyChange")]
        public function get vsInQueue():HBox
        {
            return (this._675646097vsInQueue);
        }


    }
}//package view.module.wall

