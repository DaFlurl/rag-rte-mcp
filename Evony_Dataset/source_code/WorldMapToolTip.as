// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.WorldMapToolTip

package view.castle.world
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.constants.FieldConstants;
    import com.evony.Lang;
    import flash.events.MouseEvent;
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

    public class WorldMapToolTip extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _WorldMapToolTip_Label1:Label;
        public var _WorldMapToolTip_Label2:Label;
        public var _WorldMapToolTip_Label4:Label;
        public var _WorldMapToolTip_Label6:Label;
        public var _WorldMapToolTip_Label8:Label;
        public var _WorldMapToolTip_Label3:Label;
        public var _WorldMapToolTip_Label5:Label;
        public var _WorldMapToolTip_Label7:Label;
        public var _WorldMapToolTip_Label9:Label;
        private var _1436069623selectedIndex:int = 0;
        private var _747804969position:String;
        private var _3083686dist:Number;
        private var _1265009317fieldName:String;
        private var _1264715435fieldDesc:String;
        private var _946505330viewstack1:ViewStack;
        private var _3560110tile:Tile;
        public var _WorldMapToolTip_Label10:Label;
        public var _WorldMapToolTip_Label11:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":270,
                    "height":150,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "percentWidth":100,
                                "y":0,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 1;
                                                    this.horizontalAlign = "left";
                                                    this.paddingBottom = 10;
                                                    this.paddingTop = 10;
                                                    this.paddingLeft = 10;
                                                    this.paddingRight = 10;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"fieldVs",
                                                        "styleName":"tooltips",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_WorldMapToolTip_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"contentheader1"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_WorldMapToolTip_Label2",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"ParamgraphText1"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_WorldMapToolTip_Label3",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"ParamgraphText1"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.paddingBottom = 10;
                                                    this.paddingTop = 10;
                                                    this.paddingLeft = 10;
                                                    this.paddingRight = 10;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"castleVs",
                                                        "styleName":"tooltips",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_WorldMapToolTip_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"contentheader1"});
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
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_WorldMapToolTip_Label5",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "styleName":"contentheader1",
                                                                                            "percentWidth":100
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_WorldMapToolTip_Label6",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "styleName":"contentheader1",
                                                                                            "percentWidth":100
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_WorldMapToolTip_Label7",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "styleName":"contentheader1",
                                                                                            "percentWidth":100
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentHeight":100,
                                                                                "percentWidth":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_WorldMapToolTip_Label8",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"PropertyValue1"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_WorldMapToolTip_Label9",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"PropertyValue1"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_WorldMapToolTip_Label10",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"PropertyValue1"});
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_WorldMapToolTip_Label11",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"ParamgraphText1"});
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
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function WorldMapToolTip()
        {
            mx_internal::_document = this;
            this.width = 270;
            this.height = 150;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WorldMapToolTip._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:WorldMapToolTip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _WorldMapToolTip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_world_WorldMapToolTipWatcherSetupUtil");
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
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
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

        [Bindable(event="propertyChange")]
        private function get dist():Number
        {
            return (this._3083686dist);
        }

        [Bindable(event="propertyChange")]
        private function get position():String
        {
            return (this._747804969position);
        }

        [Bindable(event="propertyChange")]
        private function get fieldDesc():String
        {
            return (this._1264715435fieldDesc);
        }

        [Bindable(event="propertyChange")]
        private function get tile():Tile
        {
            return (this._3560110tile);
        }

        public function setTile(_arg_1:Tile, _arg_2:Number):void
        {
            this.dist = _arg_2;
            this.position = (((("(" + _arg_1.getAddress().x) + ",") + _arg_1.getAddress().y) + ")");
            this.tile = _arg_1;
            if (_arg_1.fieldType == FieldConstants.TYPE_CASTLE)
            {
                this.fieldName = _arg_1.getFieldName();
                selectedIndex = 1;
            }
            else
            {
                if (_arg_1.fieldType == FieldConstants.TYPE_NPC)
                {
                    if (_arg_1.getPowerLevel() < 4)
                    {
                        this.fieldName = _arg_1.getFieldName();
                        this.fieldDesc = Lang.msg("无主城市可以攻打并占領");
                    }
                    else
                    {
                        this.fieldName = Lang.msg("蛮族等级{0}", _arg_1.getLevel());
                        this.fieldDesc = Lang.msg("无主城市可以攻打并占領");
                    };
                    selectedIndex = 0;
                }
                else
                {
                    this.fieldName = (((_arg_1.getFieldName() + " ") + Lang.msg("等级（简）")) + _arg_1.getLevel());
                    this.fieldDesc = _arg_1.getFieldDesc();
                    selectedIndex = 0;
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get fieldName():String
        {
            return (this._1265009317fieldName);
        }

        private function _WorldMapToolTip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.selectedIndex);
            }, function (_arg_1:int):void
            {
                viewstack1.selectedIndex = _arg_1;
            }, "viewstack1.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.position + " ") + this.fieldName);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label1.text = _arg_1;
            }, "_WorldMapToolTip_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fieldDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label2.text = _arg_1;
            }, "_WorldMapToolTip_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("距离主城{0}里", this.dist.toFixed(1));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label3.text = _arg_1;
            }, "_WorldMapToolTip_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.position + " ") + this.fieldName);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label4.text = _arg_1;
            }, "_WorldMapToolTip_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label5.text = _arg_1;
            }, "_WorldMapToolTip_Label5.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label6.text = _arg_1;
            }, "_WorldMapToolTip_Label6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label7.text = _arg_1;
            }, "_WorldMapToolTip_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tile.mapCastleBean.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label8.text = _arg_1;
            }, "_WorldMapToolTip_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tile.mapCastleBean.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label9.text = _arg_1;
            }, "_WorldMapToolTip_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.tile.mapCastleBean.allianceName == null) ? "- -" : this.tile.mapCastleBean.allianceName);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label10.text = _arg_1;
            }, "_WorldMapToolTip_Label10.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("距离主城{0}里", this.dist.toFixed(1));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WorldMapToolTip_Label11.text = _arg_1;
            }, "_WorldMapToolTip_Label11.text");
            result[11] = binding;
            return (result);
        }

        private function set position(_arg_1:String):void
        {
            var _local_2:Object = this._747804969position;
            if (_local_2 !== _arg_1)
            {
                this._747804969position = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "position", _local_2, _arg_1));
            };
        }

        private function set dist(_arg_1:Number):void
        {
            var _local_2:Object = this._3083686dist;
            if (_local_2 !== _arg_1)
            {
                this._3083686dist = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dist", _local_2, _arg_1));
            };
        }

        private function set fieldDesc(_arg_1:String):void
        {
            var _local_2:Object = this._1264715435fieldDesc;
            if (_local_2 !== _arg_1)
            {
                this._1264715435fieldDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldDesc", _local_2, _arg_1));
            };
        }

        public function moveToMouse(_arg_1:MouseEvent):void
        {
            this.x = (_arg_1.stageX + 10);
            this.y = (_arg_1.stageY + 20);
        }

        private function set fieldName(_arg_1:String):void
        {
            var _local_2:Object = this._1265009317fieldName;
            if (_local_2 !== _arg_1)
            {
                this._1265009317fieldName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldName", _local_2, _arg_1));
            };
        }

        private function set tile(_arg_1:Tile):void
        {
            var _local_2:Object = this._3560110tile;
            if (_local_2 !== _arg_1)
            {
                this._3560110tile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tile", _local_2, _arg_1));
            };
        }

        private function set selectedIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1436069623selectedIndex;
            if (_local_2 !== _arg_1)
            {
                this._1436069623selectedIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedIndex", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get selectedIndex():int
        {
            return (this._1436069623selectedIndex);
        }

        private function _WorldMapToolTip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.selectedIndex;
            _local_1 = ((this.position + " ") + this.fieldName);
            _local_1 = this.fieldDesc;
            _local_1 = Lang.msg("距离主城{0}里", this.dist.toFixed(1));
            _local_1 = ((this.position + " ") + this.fieldName);
            _local_1 = (Lang.msg("君主") + ": ");
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = (Lang.msg("联盟") + ": ");
            _local_1 = this.tile.mapCastleBean.userName;
            _local_1 = this.tile.mapCastleBean.prestige;
            _local_1 = ((this.tile.mapCastleBean.allianceName == null) ? "- -" : this.tile.mapCastleBean.allianceName);
            _local_1 = Lang.msg("距离主城{0}里", this.dist.toFixed(1));
        }


    }
}//package view.castle.world

