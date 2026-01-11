// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.barrack.ArmyInfoTooltip

package view.module.barrack
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.eum.TroopEum;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import com.evony.eum.TroopEumDefine;
    import view.MainWin;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
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

    public class ArmyInfoTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:ArmyInfoTooltip = new (ArmyInfoTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ArmyInfoTooltip_Label1:Label;
        public var _ArmyInfoTooltip_Label2:Label;
        public var _ArmyInfoTooltip_Label3:Label;
        public var _ArmyInfoTooltip_Label4:Label;
        public var _ArmyInfoTooltip_Label5:Label;
        public var _ArmyInfoTooltip_Label6:Label;
        public var _ArmyInfoTooltip_Label7:Label;
        public var _ArmyInfoTooltip_Label8:Label;
        public var _ArmyInfoTooltip_Label9:Label;
        private var _1682493707troopEum:TroopEum;
        public var _ArmyInfoTooltip_Label11:Label;
        public var _ArmyInfoTooltip_Label12:Label;
        public var _ArmyInfoTooltip_Label13:Label;
        public var _ArmyInfoTooltip_Label14:Label;
        public var _ArmyInfoTooltip_Label16:Label;
        public var _ArmyInfoTooltip_Label10:Label;
        public var _ArmyInfoTooltip_Label15:Label;
        public var _ArmyInfoTooltip_Label17:Label;
        public var _ArmyInfoTooltip_Text1:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":340,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.left = "5";
                            this.right = "5";
                            this.top = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ArmyInfoTooltip_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":20,
                                            "styleName":"ftpfff",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyInfoTooltip_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":330,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":101.666664,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label3",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "x":0,
                                                        "y":25,
                                                        "height":20,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label5",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "y":25,
                                                        "x":140,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label7",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "y":75,
                                                        "x":140,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label9",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "y":75,
                                                        "x":0,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label11",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "y":50,
                                                        "x":0,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label13",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "y":50,
                                                        "x":140,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label14",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label15",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
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
                                                        "width":140,
                                                        "y":0,
                                                        "x":140,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label16",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":75
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ArmyInfoTooltip_Label17",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"fontp",
                                                                    "width":50
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
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

        public function ArmyInfoTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
            this.width = 340;
        }

        public static function move2Mouse(_arg_1:MouseEvent):void
        {
            instance.moveToMouse(_arg_1);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ArmyInfoTooltip._watcherSetupUtil = _arg_1;
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:int, _arg_2:MouseEvent):void
        {
            instance.troopEum = TroopEumDefine.getTroopEumByType(_arg_1);
            instance.moveToMouse(_arg_2);
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainWin.instance);
            }
            else
            {
                PopUpManager.bringToFront(instance);
            };
        }


        private function _ArmyInfoTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label1.text = _arg_1;
            }, "_ArmyInfoTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.wikiDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Text1.text = _arg_1;
            }, "_ArmyInfoTooltip_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("生命") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label2.text = _arg_1;
            }, "_ArmyInfoTooltip_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.life;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label3.text = _arg_1;
            }, "_ArmyInfoTooltip_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("攻击") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label4.text = _arg_1;
            }, "_ArmyInfoTooltip_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.attack;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label5.text = _arg_1;
            }, "_ArmyInfoTooltip_Label5.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("防御") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label6.text = _arg_1;
            }, "_ArmyInfoTooltip_Label6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.defence;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label7.text = _arg_1;
            }, "_ArmyInfoTooltip_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("射程") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label8.text = _arg_1;
            }, "_ArmyInfoTooltip_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.range;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label9.text = _arg_1;
            }, "_ArmyInfoTooltip_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("速度") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label10.text = _arg_1;
            }, "_ArmyInfoTooltip_Label10.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.speed;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label11.text = _arg_1;
            }, "_ArmyInfoTooltip_Label11.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("负重") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label12.text = _arg_1;
            }, "_ArmyInfoTooltip_Label12.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.load;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label13.text = _arg_1;
            }, "_ArmyInfoTooltip_Label13.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("粮食") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label14.text = _arg_1;
            }, "_ArmyInfoTooltip_Label14.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.foodRequest;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label15.text = _arg_1;
            }, "_ArmyInfoTooltip_Label15.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label16.text = _arg_1;
            }, "_ArmyInfoTooltip_Label16.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.population;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ArmyInfoTooltip_Label17.text = _arg_1;
            }, "_ArmyInfoTooltip_Label17.text");
            result[17] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get troopEum():TroopEum
        {
            return (this._1682493707troopEum);
        }

        override public function initialize():void
        {
            var target:ArmyInfoTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ArmyInfoTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_barrack_ArmyInfoTooltipWatcherSetupUtil");
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

        private function set troopEum(_arg_1:TroopEum):void
        {
            var _local_2:Object = this._1682493707troopEum;
            if (_local_2 !== _arg_1)
            {
                this._1682493707troopEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopEum", _local_2, _arg_1));
            };
        }

        private function _ArmyInfoTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.troopEum.name;
            _local_1 = this.troopEum.wikiDesc;
            _local_1 = (Lang.msg("生命") + ":");
            _local_1 = this.troopEum.life;
            _local_1 = (Lang.msg("攻击") + ":");
            _local_1 = this.troopEum.attack;
            _local_1 = (Lang.msg("防御") + ":");
            _local_1 = this.troopEum.defence;
            _local_1 = (Lang.msg("射程") + ":");
            _local_1 = this.troopEum.range;
            _local_1 = (Lang.msg("速度") + ":");
            _local_1 = this.troopEum.speed;
            _local_1 = (Lang.msg("负重") + ":");
            _local_1 = this.troopEum.load;
            _local_1 = (Lang.msg("粮食") + ":");
            _local_1 = this.troopEum.foodRequest;
            _local_1 = (Lang.msg("人口") + ":");
            _local_1 = this.troopEum.population;
        }


    }
}//package view.module.barrack

